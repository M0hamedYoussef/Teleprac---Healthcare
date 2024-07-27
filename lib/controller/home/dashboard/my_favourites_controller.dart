import 'package:get/get.dart';
import 'package:teleprac/controller/main_controller.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/model/doctors/advanced_doctor_model.dart';
import 'package:teleprac/model/doctors/doctors_model.dart';
import 'package:teleprac/model/doctors/session_model.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/routes.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/standalone.dart';

class MyFavouritesController extends GetxController {
  late List myFavourites;
  late Location indianTimeZone;
  Crud crud = Crud();
  MainController mainController = Get.find();
  List sessions = [];
  String? nextAvailable;

  @override
  void onInit() {
    myFavourites = Get.arguments['favouritesList'];
    initializeTimeZones();
    indianTimeZone = getLocation('Asia/Kolkata');
    super.onInit();
  }

  viewDoctor({required DoctorModel doctorModel}) async {
    if (mainController.allDoctors.isEmpty ||
        mainController.allSpecializationsList.isEmpty) {
      loading();
      if (mainController.allDoctors.isEmpty) {
        await mainController.getAllDoctors();
      }
      if (mainController.allSpecializationsList.isEmpty) {
        await mainController.getAllSpecializations();
      }
      var res = await doctorDetailsRequest(doctorModel: doctorModel);
      if (res is RequsetStatus == false) {
        ResponseModel responseModel = ResponseModel.fromJson(res);
        if (responseModel.responseCode == '200') {
          AdvancedDoctorModel advancedDoctorModel =
              AdvancedDoctorModel.fromJson(
            responseModel.data,
          );

          Get.offNamed(
            AppRoutes.doctorScreen,
            arguments: {
              'advancedDoctorModel': advancedDoctorModel,
              'allDoctors': mainController.allDoctors,
              'allSpecializations': mainController.allSpecializationsList,
            },
          );
        }
      }
    } else {
      loading();
      var res = await doctorDetailsRequest(doctorModel: doctorModel);
      if (res is RequsetStatus == false) {
        ResponseModel responseModel = ResponseModel.fromJson(res);
        if (responseModel.responseCode == '200') {
          AdvancedDoctorModel advancedDoctorModel =
              AdvancedDoctorModel.fromJson(
            responseModel.data,
          );

          Get.offNamed(
            AppRoutes.doctorScreen,
            arguments: {
              'advancedDoctorModel': advancedDoctorModel,
              'allDoctors': mainController.allDoctors,
              'allSpecializations': mainController.allSpecializationsList,
            },
          );
        }
      }
    }
  }

  doctorDetailsRequest({required DoctorModel doctorModel}) async {
    var res = await crud.connect(
      link: AppLinks.doctorDetails,
      data: {
        'doctor_id': doctorModel.id!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  checkAvailableTimes({required DoctorModel doctorModel}) async {
    loading();
    var res = await checkAvailableTimesRequest(doctorModel: doctorModel);
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        if (responseModel.data is List) {
          for (var element in responseModel.data) {
            sessions.add(element);
          }
        }
      }
    }
    if (sessions.isEmpty) {
      nextAvailable = await nextAvailableAppointment(doctorModel: doctorModel);
    }
  }

  checkAvailableTimesRequest({required DoctorModel doctorModel}) async {
    String todayDate =
        TZDateTime.now(indianTimeZone).toString().substring(0, 10);
    var res = await crud.connect(
      link: AppLinks.availableSlots,
      data: {
        'schedule_date': todayDate,
        'doctor_id': doctorModel.id,
      },
      headers: {
        'token': AppLinks.token,
        'timezone': 'Asia/Kolkata',
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  nextAvailableAppointment({required DoctorModel doctorModel}) async {
    String? nextAvailable;
    var res = await nextAvailableAppointmentRequest(doctorModel: doctorModel);
    ResponseModel responseModel = ResponseModel.fromJson(res);
    if (responseModel.responseCode == '200') {
      nextAvailable =
          responseModel.data['next_availability'].toString() == 'null'
              ? null
              : responseModel.data['next_availability'].toString();
    }
    return nextAvailable;
  }

  nextAvailableAppointmentRequest({required DoctorModel doctorModel}) async {
    var res = await crud.connect(
      link: AppLinks.nextAvailableAppointment,
      data: {
        'doctor_id': doctorModel.id,
      },
      headers: {
        'token': AppLinks.token,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  bookNow({required DoctorModel doctorModel}) async {
    await checkAvailableTimes(doctorModel: doctorModel);
    List<SessionModel> sessionModels = [];
    for (var element in sessions) {
      SessionModel sessionModel = SessionModel.fromJson(element);
      sessionModels.add(sessionModel);
    }

    Get.offNamed(
      AppRoutes.appointment,
      arguments: {
        'doctor_id': doctorModel.id,
        'doctor_name': doctorModel.fullName,
        'doctor_image': doctorModel.profileimage,
        'amount': doctorModel.amount,
        'today_sessions': sessionModels,
        'nextAvailable': nextAvailable,
      },
    );
    sessions = [];
    nextAvailable = null;
  }
}
