import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/search_con.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/model/doctors/advanced_doctor_model.dart';
import 'package:teleprac/model/doctors/doctors_model.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/model/doctors/session_model.dart';
import 'package:teleprac/routes.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/standalone.dart';

class DoctorController extends GetxController {
  late AdvancedDoctorModel advancedDoctorModel;
  late List allDoctors;
  late List allSpecializations;
  String? previousRoute;
  String? nextAvailable;
  List sessions = [];
  bool isFavourite = false;
  MyServices myServices = Get.find();
  Crud crud = Crud();

  @override
  void onInit() {
    advancedDoctorModel = Get.arguments['advancedDoctorModel'];
    allDoctors = Get.arguments['allDoctors'];
    allSpecializations = Get.arguments['allSpecializations'];
    previousRoute = Get.arguments['previousRoute'];
    for (var element in myServices.myFavouritesList) {
      DoctorModel favDoctorModel = DoctorModel.fromJson(element);
      if (favDoctorModel.id == advancedDoctorModel.doctorDetails!.userId) {
        isFavourite = true;
        break;
      }
    }

    super.onInit();
  }

  specializationSelected() async {
    if (allDoctors.isEmpty || allSpecializations.isEmpty) {
      loading();
      if (allDoctors.isEmpty) {
        await getAllDoctors();
      }
      if (allSpecializations.isEmpty) {
        await getAllSpecializations();
      }
      if (previousRoute == AppRoutes.home) {
        Get.offNamed(
          AppRoutes.allDoctors,
          arguments: {
            'specializationsList': allSpecializations,
            'appliedFilter': advancedDoctorModel.doctorDetails!.speciality,
          },
        );
      } else {
        SearchCon searchCon = Get.put(SearchCon());
        searchCon.doctorsSearchCon = TextEditingController();
        searchCon.allSpecializationsList = allSpecializations;
        searchCon.specialityFilters
            .add(advancedDoctorModel.doctorDetails!.speciality!);
        Get.offNamed(
          AppRoutes.allDoctors,
        );
      }
    } else {
      if (previousRoute == AppRoutes.home) {
        Get.toNamed(
          AppRoutes.allDoctors,
          arguments: {
            'specializationsList': allSpecializations,
            'appliedFilter': advancedDoctorModel.doctorDetails!.speciality,
          },
        );
      } else {
        SearchCon searchCon = Get.put(SearchCon());
        searchCon.doctorsSearchCon = TextEditingController();
        searchCon.allSpecializationsList = allSpecializations;
        searchCon.specialityFilters
            .add(advancedDoctorModel.doctorDetails!.speciality!);
        Get.toNamed(
          AppRoutes.allDoctors,
        );
      }
    }
  }

  checkAvailableTimes() async {
    loading();
    var res = await checkAvailableTimesRequest();
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
      nextAvailable = await nextAvailableAppointment();
    }
  }

  checkAvailableTimesRequest() async {
    initializeTimeZones();
    Location indianTimeZone = getLocation('Asia/Kolkata');
    String todayDate =
        TZDateTime.now(indianTimeZone).toString().substring(0, 10);
    var res = await crud.connect(
      link: AppLinks.availableSlots,
      data: {
        'schedule_date': todayDate,
        'doctor_id': advancedDoctorModel.doctorDetails!.userId,
      },
      headers: {
        'token': AppLinks.token,
        'timezone': 'Asia/Kolkata',
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  nextAvailableAppointment() async {
    String? nextAvailable;
    var res = await nextAvailableAppointmentRequest();
    ResponseModel responseModel = ResponseModel.fromJson(res);
    if (responseModel.responseCode == '200') {
      nextAvailable =
          responseModel.data['next_availability'].toString() == 'null'
              ? null
              : responseModel.data['next_availability'].toString();
    }
    return nextAvailable;
  }

  nextAvailableAppointmentRequest() async {
    var res = await crud.connect(
      link: AppLinks.nextAvailableAppointment,
      data: {
        'doctor_id': advancedDoctorModel.doctorDetails!.userId,
      },
      headers: {
        'token': AppLinks.token,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  bookApp() async {
    await checkAvailableTimes();
    List<SessionModel> savedSessions = [];
    for (var element in sessions) {
      SessionModel sessionModel = SessionModel.fromJson(element);
      savedSessions.add(sessionModel);
    }
    sessions = [];
    Get.offNamed(
      AppRoutes.appointment,
      arguments: {
        'doctor_id': advancedDoctorModel.doctorDetails!.userId,
        'doctor_name': advancedDoctorModel.doctorDetails!.fullName,
        'doctor_image': advancedDoctorModel.doctorDetails!.profileimage,
        'amount': advancedDoctorModel.doctorDetails!.amount,
        'today_sessions': savedSessions,
        'nextAvailable': nextAvailable,
      },
    );
  }

  getAllDoctors() async {
    var res = await allDoctorsRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        allDoctors = responseModel.doctorsList!;
        update();
      }
    }
  }

  getAllSpecializations() async {
    var res = await allSpecializationsRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        allSpecializations = responseModel.specializationsList!;
        update();
      }
    }
  }

  addToFavourites() async {
    if (!isFavourite) {
      isFavourite = true;
      myServices.myFavouritesList.add({
        'id': advancedDoctorModel.doctorDetails!.userId,
        'first_name': advancedDoctorModel.doctorDetails!.firstName,
        'last_name': advancedDoctorModel.doctorDetails!.lastName,
        'speciality': advancedDoctorModel.doctorDetails!.speciality,
        'cityname': advancedDoctorModel.doctorDetails!.cityname,
        'rating_value': advancedDoctorModel.doctorDetails!.ratingValue,
        'rating_count': advancedDoctorModel.doctorDetails!.ratingCount,
        'profileimage': advancedDoctorModel.doctorDetails!.profileimage
            ?.replaceAll('${AppLinks.baseUrl}/', ''),
        'amount': advancedDoctorModel.doctorDetails!.amount,
        'price_type': advancedDoctorModel.doctorDetails!.priceType,
      });
      update();
      await addToFavouritesRequest();
    }
  }

  allDoctorsRequest() async {
    var res = await crud.connect(
      link: AppLinks.doctors,
      headers: {
        'token': AppLinks.token,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  allSpecializationsRequest() async {
    var res = await crud.connect(
      link: AppLinks.specializations,
      headers: {
        'token': AppLinks.token,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  addToFavouritesRequest() async {
    var res = await crud.connect(
      link: AppLinks.addToFavourites,
      data: {
        'doctor_id': advancedDoctorModel.doctorDetails!.userId,
      },
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
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
