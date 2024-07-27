import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/firebase_options.dart';
import 'package:teleprac/model/doctors/advanced_doctor_model.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/model/global/user_model.dart';
import 'package:teleprac/model/home/dashboard/appointment/call_data_model.dart';
import 'package:teleprac/model/profile/patient_profile_model.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:teleprac/routes.dart';
import 'package:teleprac/view/widgets/global/user_image.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;
  late bool loginSuccess;
  late List myFavouritesList;
  String? currentLocation;
  Crud crud = Crud();

  Future<MyServices> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    await getUserDetails();
    await myFavourites();
    await setUserTopic();
    return this;
  }

  loginRequest() async {
    var res = await crud.connect(
      link: AppLinks.signIn,
      data: {
        'email': sharedPreferences.getString('email'),
        'password': sharedPreferences.getString('password'),
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  login() async {
    var data = await loginRequest();
    if (data is RequsetStatus == false) {
      ResponseModel responseModel =
          ResponseModel.fromJson(data as Map<String, dynamic>);
      if (responseModel.responseCode == '500') {
        await sharedPreferences.clear();
        return false;
      } else if (responseModel.responseCode == '200') {
        UserModel myUserModel = UserModel.fromJson(responseModel.userData!);
        await sharedPreferences.setString('id', myUserModel.id!);
        await sharedPreferences.setString('username', myUserModel.username!);
        await sharedPreferences.setString('first_name', myUserModel.firstName!);
        await sharedPreferences.setString('last_name', myUserModel.lastName!);
        await sharedPreferences.setString(
          'role',
          myUserModel.role!,
        );
        await sharedPreferences.setString(
          'pfp',
          '${AppLinks.baseUrl}/${myUserModel.profileimage!}',
        );
        await sharedPreferences.setString('token', myUserModel.token!);
        return true;
      }
    }
  }

  getUserDetails() async {
    if (sharedPreferences.getBool('LoginSkip') == true &&
        sharedPreferences.getString('email') != null &&
        sharedPreferences.getString('password') != null) {
      loginSuccess = (await login());
    } else {
      loginSuccess = false;
    }
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    if (message.data['type'] == 'incoming_call') {
      await FlutterRingtonePlayer.play();
    }
  }

  myFavourites() async {
    if (sharedPreferences.getString('token') != null) {
      var res = await myFavouritesRequest();
      if (res is RequsetStatus == false) {
        ResponseModel responseModel = ResponseModel.fromJson(res);
        if (responseModel.responseCode == '200') {
          myFavouritesList = responseModel.doctorsList!;
        } else {
          myFavouritesList = [];
        }
      }
    }
  }

  myFavouritesRequest() async {
    var res = await crud.connect(
      link: AppLinks.favouritesList,
      headers: {
        'token': sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  getUserLocation() async {
    if (sharedPreferences.get('currentLocation') == null) {
      if (sharedPreferences.getString('token') != null) {
        if (sharedPreferences.getString('role') == '1') {
          await doctorProfileData();
        } else if (sharedPreferences.getString('role') == '2') {
          await patientProfileData();
        }
      }

      await sharedPreferences.setString(
        'currentLocation',
        currentLocation ?? 'Unavailable',
      );
    }
  }

  setUserTopic() async {
    if (sharedPreferences.getString('id') != null) {
      if (sharedPreferences.getBool('subscribed') != true) {
        await FirebaseMessaging.instance.subscribeToTopic(
          sharedPreferences.getString('id')!,
        );
        await sharedPreferences.setBool('subscribed', true);
      }
    }
  }

  unSubscribeFromUserTopic() async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(
      sharedPreferences.getString('id')!,
    );
  }

  patientProfileData() async {
    if (sharedPreferences.getString('token') != null) {
      var res = await patientProfileDataRequest();
      if (res is RequsetStatus == false) {
        ResponseModel responseModel = ResponseModel.fromJson(res);
        if (responseModel.responseCode.toString().trim() == '200') {
          PatientProfileModel patientProfileModel =
              PatientProfileModel.fromJson(responseModel.patientDetails!);
          currentLocation = patientProfileModel.cityname;
        }
      }
    }
  }

  patientProfileDataRequest() async {
    var res = await crud.connect(
      link: AppLinks.patientProfile,
      method: 'GET',
      headers: {
        'token': sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  doctorProfileData() async {
    if (sharedPreferences.getString('id') != null) {
      var res = await doctorProfileDataRequest();
      if (res is RequsetStatus == false) {
        ResponseModel responseModel = ResponseModel.fromJson(res);

        if (responseModel.responseCode.toString().trim() == '200') {
          AdvancedDoctorModel advancedDoctorModel =
              AdvancedDoctorModel.fromJson(responseModel.data);

          currentLocation = advancedDoctorModel.doctorDetails?.cityname;
        }
      }
    }
  }

  doctorProfileDataRequest() async {
    var res = await crud.connect(
      link: AppLinks.doctorDetails,
      data: {
        'doctor_id': sharedPreferences.getString('id')!,
      },
      headers: {
        'token': AppLinks.token,
      },
    );
    return res.fold((l) => l, (r) => r);
  }
}

initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  // await onTerminatedOpenApp();
  FirebaseMessaging.onMessage.listen((message) async {
    if (message.data['type'] == 'incoming_call') {
      if (Get.currentRoute != AppRoutes.callScreen &&
          Get.isDialogOpen != true) {
        await FlutterRingtonePlayer.playRingtone();
        Get.defaultDialog(
          title: 'Incoming Call',
          onWillPop: () async {
            await FlutterRingtonePlayer.stop();
            Get.back();
            return Future.value(false);
          },
          content: Column(
            children: [
              UserImage(image: message.data['caller_pfp']),
              SizedBox(height: AppDecoration().screenHeight * 0.01),
              Text(
                message.data['caller_name'],
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: AppDecoration().screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppDecoration().screenHeight * 0.01),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.secondaryColor,
                    boxShadow: const [
                      BoxShadow(blurRadius: 0.2),
                    ],
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColors.primaryColor,
                        ),
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: GestureDetector(
                          onTap: () async {
                            await FlutterRingtonePlayer.stop();
                            Get.toNamed(
                              AppRoutes.callScreen,
                              arguments: {
                                'doctor_id': message.data['role'] == '1'
                                    ? message.data['remote_uid']
                                    : null,
                                'patient_id': message.data['role'] == '2'
                                    ? message.data['remote_uid']
                                    : null,
                                'appointmentEndTime':
                                    message.data['appointmentEndTime'],
                                'callType': 'video',
                                'agoraData': AdditionalKeyData.fromJson(
                                  {
                                    'room_name': message.data['channel_id'],
                                    'access_token':
                                        message.data['channel_token'],
                                  },
                                ),
                              },
                            );
                          },
                          child: Icon(
                            Icons.video_call,
                            color: AppColors.secondaryColor,
                            size: AppDecoration().screenWidth * 0.1,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColors.red,
                        ),
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: GestureDetector(
                          onTap: () async {
                            await FlutterRingtonePlayer.stop();
                            Get.back();
                          },
                          child: Icon(
                            Icons.phone,
                            color: AppColors.secondaryColor,
                            size: AppDecoration().screenWidth * 0.1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      } else if (Get.isDialogOpen == true) {
        Get.snackbar(
          'Alert',
          '${message.data['caller_name']} is calling you',
        );
      }
    }
  });
  FirebaseMessaging.onMessageOpenedApp.listen(
    (message) async {
      if (message.data['type'] == 'incoming_call') {
        if (Get.currentRoute != AppRoutes.callScreen &&
            Get.isDialogOpen != true) {
          await FlutterRingtonePlayer.playRingtone();
          Get.defaultDialog(
            title: 'Incoming Call',
            onWillPop: () async {
              await FlutterRingtonePlayer.stop();
              Get.back();
              return Future.value(false);
            },
            content: Column(
              children: [
                UserImage(image: message.data['caller_pfp']),
                SizedBox(height: AppDecoration().screenHeight * 0.01),
                Text(
                  message.data['caller_name'],
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: AppDecoration().screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppDecoration().screenHeight * 0.01),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, bottom: 20, right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.secondaryColor,
                      boxShadow: const [
                        BoxShadow(blurRadius: 0.2),
                      ],
                    ),
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppColors.primaryColor,
                          ),
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: GestureDetector(
                            onTap: () async {
                              await FlutterRingtonePlayer.stop();
                              Get.toNamed(
                                AppRoutes.callScreen,
                                arguments: {
                                  'doctor_id': message.data['role'] == '1'
                                      ? message.data['remote_uid']
                                      : null,
                                  'patient_id': message.data['role'] == '2'
                                      ? message.data['remote_uid']
                                      : null,
                                  'appointmentEndTime':
                                      message.data['appointmentEndTime'],
                                  'callType': 'video',
                                  'agoraData': AdditionalKeyData.fromJson(
                                    {
                                      'room_name': message.data['channel_id'],
                                      'access_token':
                                          message.data['channel_token'],
                                    },
                                  ),
                                },
                              );
                            },
                            child: Icon(
                              Icons.video_call,
                              color: AppColors.secondaryColor,
                              size: AppDecoration().screenWidth * 0.1,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppColors.red,
                          ),
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: GestureDetector(
                            onTap: () async {
                              await FlutterRingtonePlayer.stop();
                              Get.back();
                            },
                            child: Icon(
                              Icons.phone,
                              color: AppColors.secondaryColor,
                              size: AppDecoration().screenWidth * 0.1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (Get.isDialogOpen == true) {
          Get.snackbar(
            'Alert',
            '${message.data['caller_name']} is calling you',
          );
        }
      }
    },
  );
}

onTerminatedOpenApp() async {
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    if (initialMessage.data['type'] == 'incoming_call') {
      await FlutterRingtonePlayer.playRingtone();
      Get.defaultDialog(
        title: 'Incoming Call',
        onWillPop: () async {
          await FlutterRingtonePlayer.stop();
          Get.back();
          return Future.value(false);
        },
        content: Column(
          children: [
            UserImage(image: initialMessage.data['caller_pfp']),
            SizedBox(height: AppDecoration().screenHeight * 0.01),
            Text(
              initialMessage.data['caller_name'],
              style: TextStyle(
                color: AppColors.black,
                fontSize: AppDecoration().screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.01),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.secondaryColor,
                  boxShadow: const [
                    BoxShadow(blurRadius: 0.2),
                  ],
                ),
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.primaryColor,
                      ),
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: GestureDetector(
                        onTap: () async {
                          await FlutterRingtonePlayer.stop();
                          Get.toNamed(
                            AppRoutes.callScreen,
                            arguments: {
                              'doctor_id': initialMessage.data['role'] == '1'
                                  ? initialMessage.data['remote_uid']
                                  : null,
                              'patient_id': initialMessage.data['role'] == '2'
                                  ? initialMessage.data['remote_uid']
                                  : null,
                              'appointmentEndTime':
                                  initialMessage.data['appointmentEndTime'],
                              'callType': 'video',
                              'agoraData': AdditionalKeyData.fromJson(
                                {
                                  'room_name':
                                      initialMessage.data['channel_id'],
                                  'access_token':
                                      initialMessage.data['channel_token'],
                                },
                              ),
                            },
                          );
                        },
                        child: Icon(
                          Icons.video_call,
                          color: AppColors.secondaryColor,
                          size: AppDecoration().screenWidth * 0.1,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.red,
                      ),
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: GestureDetector(
                        onTap: () async {
                          await FlutterRingtonePlayer.stop();
                          Get.back();
                        },
                        child: Icon(
                          Icons.phone,
                          color: AppColors.secondaryColor,
                          size: AppDecoration().screenWidth * 0.1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

initService() async {
  await Get.putAsync(() => MyServices().init());
}
