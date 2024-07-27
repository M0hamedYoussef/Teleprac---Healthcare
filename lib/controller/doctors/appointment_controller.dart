import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/model/doctors/session_model.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:teleprac/model/home/dashboard/family_member_model.dart';
import 'package:teleprac/routes.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/drop_down.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/standalone.dart';

class AppointmentController extends GetxController {
  Crud crud = Crud();
  MyServices myServices = Get.find();
  String appointmentDate = '';
  List<SessionModel> sessions = [];
  int? selectedTokenIndex;
  int? selectedSessionIndex;
  String appointmentType = 'Online';
  String? nextAvailable;
  String? previousRoute;
  late String doctorId;
  late String doctorName;
  late String doctorImage;
  late String amount;
  late String patientId;
  late String myUid;
  late String myEmail;
  late String myName;
  late String myMobileno;
  late Location indianTimeZone;
  late List familyMembers;
  String familyMemberId = '';
  Razorpay razorpay = Razorpay();

  @override
  onInit() async {
    super.onInit();
    previousRoute = Get.arguments['previousRoute'];
    doctorId = Get.arguments['doctor_id'];
    if (previousRoute != AppRoutes.patientProfileScreen) {
      doctorName = Get.arguments['doctor_name'];
      doctorImage = Get.arguments['doctor_image'];
      amount = Get.arguments['amount'];
    } else {
      patientId = Get.arguments['patient_id'];
      amount = Get.arguments['amount'];
    }
    sessions = Get.arguments['today_sessions'];
    nextAvailable = Get.arguments['nextAvailable'];
    myUid = myServices.sharedPreferences.getString('id')!;
    myName = myServices.sharedPreferences.getString('first_name')!;
    myEmail = myServices.sharedPreferences.getString('email')!;
    myMobileno = myServices.sharedPreferences.getString('mobileNumber')!;
    initializeTimeZones();
    indianTimeZone = getLocation('Asia/Kolkata');
    appointmentDate =
        TZDateTime.now(indianTimeZone).toString().substring(0, 10);
  }

  selectDate({required BuildContext context}) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(appointmentDate),
      firstDate: DateTime.parse(
          TZDateTime.now(indianTimeZone).toString().substring(0, 10)),
      lastDate: DateTime.parse(appointmentDate).add(const Duration(days: 365)),
    );

    if (picked != null) {
      appointmentDate = picked.toString().substring(0, 10);
      selectedSessionIndex = null;
      selectedTokenIndex = null;
      loading();
      await checkAvailableTimes();
      Get.back();
    }
  }

  checkAvailableTimes() async {
    var res = await checkAvailableTimesRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '201') {
        sessions = [];
        await nextAvailableAppointment();
        update();
      } else if (responseModel.responseCode == '200') {
        if (responseModel.data is List) {
          sessions = [];
          for (var element in responseModel.data) {
            sessions.add(SessionModel.fromJson(element));
          }
          update();
        }
      }
    }
  }

  selectSlot({
    required int token,
    // required int session,
  }) {
    selectedTokenIndex = token;
    // selectedSessionIndex = session;
    update();
  }

  changeType({required String type}) {
    appointmentType = type;
    update();
  }

  checkAvailableTimesRequest() async {
    var res = await crud.connect(
      link: AppLinks.availableSlots,
      data: {
        'schedule_date': appointmentDate.trim(),
        'doctor_id': doctorId,
      },
      headers: {
        'token': AppLinks.token,
        'timezone': 'Asia/Kolkata',
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  forMyFamily() async {
    loading();
    var res = await myFamilyRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);

      if (responseModel.responseCode == '200' ||
          responseModel.responseCode == '201') {
        familyMembers = [];
        for (var element in responseModel.doctorsList!) {
          FamilyMemberModel familyMemberModel =
              FamilyMemberModel.fromJson(element);
          familyMembers.add(
            {
              'label': familyMemberModel.name,
              'value': familyMemberModel.id,
            },
          );
        }
        Get.back();
        Get.defaultDialog(
          content: GetBuilder<AppointmentController>(
            builder: (_) {
              return CustomDropDown(
                dropdownList: familyMembers,
                value: familyMemberId,
                label: 'Choose Family Member',
                onChanged: (value) {
                  familyMemberId = value!;
                  update();
                },
              );
            },
          ),
          actions: [
            MaterialButton(
              onPressed: () async {
                Get.back();
                if (amount.removeAllWhitespace == '0' || amount.isEmpty) {
                  loading();
                  var res = await bookAppointmentRequset();
                  if (res is RequsetStatus == false) {
                    ResponseModel responseModel = ResponseModel.fromJson(res);
                    if (responseModel.responseCode == '200') {
                      selectedSessionIndex = null;
                      selectedTokenIndex = null;
                      await checkAvailableTimes();
                      Get.back();
                    }
                  }
                } else {
                  razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                      (PaymentSuccessResponse response) async {
                    loading();
                    var res = await bookAppointmentRequset();
                    if (res is RequsetStatus == false) {
                      ResponseModel responseModel = ResponseModel.fromJson(res);
                      if (responseModel.responseCode == '200') {
                        selectedSessionIndex = null;
                        selectedTokenIndex = null;
                        await checkAvailableTimes();
                        Get.back();
                      }
                    }
                  });

                  razorpay.open({
                    'name': doctorName,
                    'amount': '${double.parse(amount).round().toInt()}00',
                    'image': doctorImage,
                    'key': AppLinks.razorPay,
                    'description': 'Appointment Booking',
                  });
                }
              },
              color: AppColors.primaryColor,
              child: Text(
                'Confirm',
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: AppDecoration().screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppDecoration.cairo,
                ),
              ),
            ),
          ],
        );
      }
    }
  }

  myFamilyRequest() async {
    var res = await crud.connect(
      link: AppLinks.myFamily,
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  bookAppointment() async {
    if (previousRoute != AppRoutes.patientProfileScreen) {
      if (sessions.isNotEmpty &&
          selectedSessionIndex != null &&
          selectedTokenIndex != null) {
        Get.defaultDialog(
          middleText: 'Are You Booking for Your Self Or Family Member? ',
          actions: [
            MaterialButton(
              onPressed: () async {
                familyMemberId = '';
                Get.back();
                if (amount.removeAllWhitespace == '0' || amount.isEmpty) {
                  loading();
                  var res = await bookAppointmentRequset();
                  if (res is RequsetStatus == false) {
                    ResponseModel responseModel = ResponseModel.fromJson(res);
                    if (responseModel.responseCode == '200') {
                      selectedSessionIndex = null;
                      selectedTokenIndex = null;
                      await checkAvailableTimes();
                      Get.back();
                    }
                  }
                } else {
                  razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                      (PaymentSuccessResponse response) async {
                    loading();
                    var res = await bookAppointmentRequset();
                    if (res is RequsetStatus == false) {
                      ResponseModel responseModel = ResponseModel.fromJson(res);
                      if (responseModel.responseCode == '200') {
                        selectedSessionIndex = null;
                        selectedTokenIndex = null;
                        await checkAvailableTimes();
                        Get.back();
                      }
                    }
                  });

                  razorpay.open({
                    'name': doctorName,
                    'amount': '${double.parse(amount).round().toInt()}00',
                    'image': doctorImage,
                    'key': AppLinks.razorPay,
                    'description': 'Appointment Booking',
                  });
                }
              },
              color: AppColors.primaryColor,
              child: Text(
                'Myself',
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: AppDecoration().screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppDecoration.cairo,
                ),
              ),
            ),
            MaterialButton(
              onPressed: () async {
                Get.back();
                forMyFamily();
              },
              color: AppColors.primaryColor,
              child: Text(
                'For Family Member',
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: AppDecoration().screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppDecoration.cairo,
                ),
              ),
            ),
          ],
        );
      } else {
        Get.defaultDialog(middleText: 'No Appointment Selected');
      }
    } else {
      if (sessions.isNotEmpty &&
          selectedSessionIndex != null &&
          selectedTokenIndex != null) {
        loading();
        await bookFollowUpAppointmentRequset();
        selectedSessionIndex = null;
        selectedTokenIndex = null;
        await checkAvailableTimes();
        Get.back();
      } else {
        Get.defaultDialog(middleText: 'No Appointment Selected');
      }
    }
  }

  bookAppointmentRequset() async {
    TokenDetailsModel tokenDetailsModel =
        sessions[selectedSessionIndex!].tokenDetails![selectedTokenIndex!];
    var res = await crud.connect(
      link: AppLinks.checkout,
      data: {
        'payment_type': amount.removeAllWhitespace == '0' || amount.isEmpty
            ? 'Free'
            : 'Paid',
        'payment_method': '1',
        'family_id': familyMemberId,
        'myself': familyMemberId.isEmpty ? '1' : '0',
        'doctor_id': doctorId,
        'appoinment_date': appointmentDate,
        'appoinment_start_time': tokenDetailsModel.tokenStartTime,
        'appoinment_end_time': tokenDetailsModel.tokenEndTime,
        'appoinment_token': tokenDetailsModel.tokenNo,
        'appoinment_session': tokenDetailsModel.tokenSession,
        'appoinment_timezone': tokenDetailsModel.tokenTimeZone,
        'appointment_type': appointmentType,
        'amount': amount,
        'hourly_rate': amount,
        'access_token': myServices.sharedPreferences.getString('token')!,
      },
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  bookFollowUpAppointmentRequset() async {
    TokenDetailsModel tokenDetailsModel =
        sessions[selectedSessionIndex!].tokenDetails![selectedTokenIndex!];
    var res = await crud.connect(
      link: AppLinks.bookFollowUp,
      data: {
        'patient_id': patientId,
        'appoinment_date': appointmentDate,
        'appoinment_start_time': tokenDetailsModel.tokenStartTime,
        'appoinment_end_time': tokenDetailsModel.tokenEndTime,
        'appoinment_token': tokenDetailsModel.tokenNo,
        'appoinment_session': tokenDetailsModel.tokenSession,
        'appoinment_timezone': tokenDetailsModel.tokenTimeZone,
        'appointment_type': appointmentType,
      },
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  nextAvailableAppointment() async {
    var res = await nextAvailableAppointmentRequest();
    ResponseModel responseModel = ResponseModel.fromJson(res);
    if (responseModel.responseCode == '200') {
      nextAvailable =
          responseModel.data['next_availability'].toString() == 'null'
              ? null
              : responseModel.data['next_availability'].toString();
      update();
    }
  }

  nextAvailableAppointmentRequest() async {
    var res = await crud.connect(
      link: AppLinks.nextAvailableAppointment,
      data: {
        'doctor_id': doctorId,
      },
      headers: {
        'token': AppLinks.token,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  notifyMe() {
    Get.toNamed(
      AppRoutes.notifyMe,
      arguments: {
        'doctor_id': doctorId,
      },
    );
  }

  Future<bool> willPop() {
    if (previousRoute == AppRoutes.home) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: AppColors.lightGrey1,
          statusBarIconBrightness: Brightness.light,
        ),
      );
    }
    Get.back();
    return Future.value(false);
  }
}
