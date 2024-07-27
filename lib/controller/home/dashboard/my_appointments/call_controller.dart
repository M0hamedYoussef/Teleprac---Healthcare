import 'dart:async';
import 'dart:convert';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/model/home/dashboard/appointment/call_data_model.dart';
import 'package:teleprac/model/home/dashboard/patient_model.dart';
import 'package:teleprac/routes.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/custom_text_form_field.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/standalone.dart';

class CallController extends GetxController {
  late RtcEngine engine;
  late String callType;
  late int myUid;
  late String channelId;
  late String channelToken;
  late String appointmentEndTime;
  late TZDateTime now;
  late String currentTime;
  late String cam;
  late String myRole;
  late String remoteId;
  late String myFullName;
  late String myPfp;
  late Location indianTimeZone;
  int? remoteUid;
  CallDataModel? callData;
  AdditionalKeyData? additionalKeyData;
  bool joined = false;
  bool isMicrophoneEnabled = false;
  bool isCameraEnabled = false;
  bool remoteCameraEnabled = false;
  bool warned = false;
  bool ended = false;
  bool out = false;
  MyServices myServices = Get.find();
  Crud crud = Crud();

  @override
  onInit() async {
    initArguments();
    initializeTimeZones();
    indianTimeZone = getLocation('Asia/Kolkata');
    now = TZDateTime.now(indianTimeZone);
    currentTime = DateFormat("h:mm a")
        .format(Jiffy(now.toString().split('.')[0]).dateTime);

    if (appointmentEndTime != currentTime) {
      await initAgora();
      sendCallNotification();
      initTimer();
    } else {
      ended = true;
      willPop();
      Get.snackbar(
        'Alert',
        'The Appointment Ended',
        duration: const Duration(
          seconds: 3,
        ),
      );
    }
    super.onInit();
  }

  initArguments() {
    myUid = int.parse(myServices.sharedPreferences.getString('id')!);
    myRole = myServices.sharedPreferences.getString('role')!;
    myPfp = myServices.sharedPreferences.getString('pfp')!;
    myFullName =
        '${myServices.sharedPreferences.getString('first_name')} ${myServices.sharedPreferences.getString('last_name')}';

    if (Get.arguments['callData'] != null) {
      callData = Get.arguments['callData'];
    } else if (Get.arguments['agoraData'] != null) {
      additionalKeyData = Get.arguments['agoraData'];
    }
    appointmentEndTime = Get.arguments['appointmentEndTime'];
    callType = Get.arguments['callType'];
    if (myRole == '1') {
      remoteId = Get.arguments['patient_id'];
    } else if (myRole == '2') {
      remoteId = Get.arguments['doctor_id'];
    }
  }

  initTimer() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (out) {
          timer.cancel();
        } else {
          now = TZDateTime.now(indianTimeZone);
          currentTime = DateFormat("h:mm a")
              .format(Jiffy(now.toString().split('.')[0]).dateTime);
          int appointmentEndTimeMinutes =
              int.parse(appointmentEndTime.split(':')[1].split(' ')[0]);
          int currentTimeMinutes =
              int.parse(currentTime.split(':')[1].split(' ')[0]);
          if (int.parse(currentTime.split(':')[0]) < 10 ||
              int.parse(currentTime.split(':')[1].split(' ')[0]) < 10) {
            String timing = currentTime.split(':')[1].split(' ')[1];
            String minutes;
            String hours;
            if (int.parse(currentTime.split(':')[1].split(' ')[0]) < 10) {
              minutes =
                  '0${int.parse(currentTime.split(':')[1].split(' ')[0])}';
            } else {
              minutes = '${int.parse(currentTime.split(':')[1].split(' ')[0])}';
            }
            if (int.parse(currentTime.split(':')[0]) < 10) {
              hours = '0${int.parse(currentTime.split(':')[0])}';
            } else {
              hours = '${int.parse(currentTime.split(':')[0])}';
            }
            currentTime = '$hours:$minutes $timing';
          }

          if (appointmentEndTime == currentTime && !ended) {
            ended = true;
            willPop();
            Get.snackbar(
              'Alert',
              'The Appointment Ended',
              duration: const Duration(
                seconds: 3,
              ),
            );
            if (myRole == '1') {
              myPatient();
            } else if (myRole == '2') {
              rateTheDoctor();
            }
          }

          if (!warned &&
              (appointmentEndTimeMinutes == (currentTimeMinutes + 2))) {
            warned = true;
            Get.snackbar(
              'Alert',
              'The Appointment will be ended in 2 minutes',
              duration: const Duration(
                seconds: 3,
              ),
            );
          }
        }
      },
    );
  }

  initAgora() async {
    engine = createAgoraRtcEngine();
    await [Permission.microphone, Permission.camera].request();
    await engine.initialize(
      const RtcEngineContext(
        appId: AppLinks.agoraAppId,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      ),
    );

    engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          joined = true;
          update();
        },
        onUserJoined: (RtcConnection connection, int remote, int elapsed) {
          remoteUid = remote;
          update();
        },
        onConnectionLost: (RtcConnection connection) {
          Get.defaultDialog(middleText: 'Connection Lost !');
        },
        onRemoteVideoStateChanged:
            (connection, remoteUid, state, reason, elapsed) {
          if (reason.value() == 6) {
            remoteCameraEnabled = true;
            update();
          } else {
            remoteCameraEnabled = false;
            update();
          }
        },
        onUserOffline: (connection, id, reason) {
          remoteUid = null;
          update();
        },
      ),
    );

    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine.enableAudio();
    isMicrophoneEnabled = true;
    await engine.enableVideo();
    await engine.enableLocalVideo(false);
    await engine.startPreview();
    cam = 'front';
    if (callType == 'video') {
      isCameraEnabled = true;
      await engine.enableLocalVideo(true);
    }
    update();
    if (callData != null) {
      channelId = callData!.additionalKeyData!.roomName!;
      channelToken = callData!.additionalKeyData!.accessToken!;
    } else if (additionalKeyData != null) {
      channelId = additionalKeyData!.roomName!;
      channelToken = additionalKeyData!.accessToken!;
    }
    await engine.joinChannel(
      channelId: channelId,
      token: channelToken,
      uid: myUid,
      options: const ChannelMediaOptions(),
    );
  }

  microphone() async {
    isMicrophoneEnabled = !isMicrophoneEnabled;
    await engine.enableLocalAudio(isMicrophoneEnabled);
    update();
  }

  camera() async {
    isCameraEnabled = !isCameraEnabled;
    await engine.enableLocalVideo(isCameraEnabled);
    update();
  }

  cameraSwitch() async {
    await engine.switchCamera();
    if (cam == 'front') {
      cam = 'back';
    } else if (cam == 'back') {
      cam = 'front';
    }
    update();
  }

  endCall() {
    willPop();
  }

  myPatient() async {
    loading();
    var res = await myPatientRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        for (var element in responseModel.patientsList!) {
          PatientModel patientModel = PatientModel.fromJson(element);
          if (patientModel.patientId == remoteId) {
            await Get.defaultDialog(
              middleText: 'Please add prescription/test',
            );
            Get.offNamed(
              AppRoutes.patientProfileScreen,
              arguments: {
                'patient_model': patientModel,
              },
            );

            break;
          }
        }
      }
    }
  }

  myPatientRequest() async {
    var res = await crud.connect(
      link: AppLinks.myPatients,
      headers: {
        'token':  myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  rateTheDoctor() async {
    String rating = '0';
    TextEditingController titleCon = TextEditingController();
    TextEditingController reviewCon = TextEditingController();
    FocusNode titleFocus = FocusNode();
    FocusNode reviewFocus = FocusNode();
    await Get.defaultDialog(
      title: 'Rate The Doctor',
      content: Column(
        children: [
          RatingBar.builder(
            initialRating: double.parse(rating),
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: AppColors.amber,
            ),
            itemCount: 5,
            itemSize: AppDecoration().screenWidth * 0.07,
            unratedColor: AppColors.amber.withAlpha(50),
            direction: Axis.horizontal,
            updateOnDrag: true,
            allowHalfRating: true,
            onRatingUpdate: (value) {
              rating = value.toString();
            },
          ),
          SizedBox(height: AppDecoration().screenHeight * 0.01),
          CustomTextFormField(
            textEditingController: titleCon,
            label: 'Rating Title',
            focusNode: titleFocus,
            nextFocusNode: reviewFocus,
          ),
          SizedBox(height: AppDecoration().screenHeight * 0.01),
          CustomTextFormField(
            textEditingController: reviewCon,
            label: 'Review',
            focusNode: reviewFocus,
            maxLines: null,
          ),
          SizedBox(height: AppDecoration().screenHeight * 0.01),
          CustomButton(
            function: () async {
              if (rating == '0' &&
                  titleCon.text.isEmpty &&
                  reviewCon.text.isEmpty) {
                Get.defaultDialog(
                  middleText: 'Please rate the doctor first',
                );
              } else {
                Get.back();
                loading();
                var res = await rateTheDoctorRequest(
                  rating: rating,
                  title: titleCon.text.trim(),
                  review: reviewCon.text.trim(),
                );
                if (res is RequsetStatus == false) {
                  ResponseModel responseModel = ResponseModel.fromJson(res);
                  if (responseModel.responseCode == '200') {
                    Fluttertoast.showToast(
                      msg: 'Added Successfully',
                      textColor: AppColors.black,
                      backgroundColor: AppColors.secondaryColor,
                    );
                  }
                }
                Get.back();
              }
            },
            text: 'Confirm',
            buttonColor: AppColors.primaryColor,
          ),
          SizedBox(height: AppDecoration().screenHeight * 0.01),
        ],
      ),
      onWillPop: () {
        Get.defaultDialog(
          middleText: 'Please rate the doctor first',
        );
        return Future.value(false);
      },
    );
  }

  rateTheDoctorRequest({
    required String rating,
    required String title,
    required String review,
  }) async {
    var res = await crud.connect(
      link: AppLinks.addReview,
      data: {
        'doctor_id': remoteId,
        'rating': rating,
        'title': title,
        'review': review,
      },
      headers: {
        'token':  myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  sendCallNotification() async {
    await post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=${AppLinks.messagingApi}',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'title': 'You Have An Appointment !',
            'body': myRole == '1'
                ? 'Your Doctor Is Caling You !'
                : 'Your Patient Is Caling You !',
          },
          'priority': 'high',
          'data': {
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'type': 'incoming_call',
            'role': myRole,
            'remote_uid': myUid.toString(),
            'appointmentEndTime': appointmentEndTime,
            'channel_id': channelId,
            'channel_token': channelToken,
            'caller_name': myFullName,
            'caller_pfp': myPfp,
          },
          'to': '/topics/$remoteId',
        },
      ),
    );
  }

  Future<bool> willPop() {
    out = true;
    engine.release();
    engine.leaveChannel();
    Get.back();
    return Future.value(false);
  }
}
