import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/model/doctors/advanced_doctor_model.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/model/pharmacies/pharmacy_model.dart';
import 'package:teleprac/model/profile/patient_profile_model.dart';
import 'package:teleprac/routes.dart';
import 'package:teleprac/view/screens/home/account_screen/profile_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountController extends GetxController {
  MyServices myServices = Get.find();
  Crud crud = Crud();
  late String userID;
  late String userName;
  late String firstName;
  late String lastName;
  late String fullName;
  late String userEmail;
  late String userPFP;
  late String userPhone;
  late String userToken;
  late String userRole;
  late List specializationsList;

  @override
  void onInit() {
    initUserData();
    specializationsList = Get.arguments['specializationsList'];
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    super.onInit();
  }

  initUserData() {
    userID = myServices.sharedPreferences.getString('id')!;
    userName = myServices.sharedPreferences.getString('username')!;
    userRole = myServices.sharedPreferences.getString('role')!;
    firstName = myServices.sharedPreferences.getString('first_name')!;
    lastName = myServices.sharedPreferences.getString('last_name')!;
    fullName = '$firstName $lastName';
    userPFP = myServices.sharedPreferences.getString('pfp')!;
    userEmail = myServices.sharedPreferences.getString('email')!;
    userToken = myServices.sharedPreferences.getString('token')!;
    userPhone = myServices.sharedPreferences.getString('mobileNumber')!;
  }

  onProfileSettingsPressed() {
    if (userRole == '1' || userRole == '7') {
      // The Api Developer Using The Same Api To Both Doctor And Nurse
      doctorProfileData();
    } else if (userRole == '2') {
      patientProfileData();
    } else if (userRole == '5') {
      pharmacyProfileData();
    }
  }

  patientProfileData() async {
    loading();
    var res = await patientProfileDataRequest();
    var statesRes = await statesRequest();
    if (res is RequsetStatus == false && statesRes is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      ResponseModel statesResponseModel = ResponseModel.fromJson(statesRes);
      if (responseModel.responseCode.toString().trim() == '200' &&
          statesResponseModel.responseCode.toString().trim() == '200') {
        PatientProfileModel patientProfileModel =
            PatientProfileModel.fromJson(responseModel.patientDetails!);
        Get.off(
          () => const ProfileScreen(),
          transition: Transition.downToUp,
          arguments: {
            'patientModel': patientProfileModel,
            'states': statesResponseModel.requestedList,
          },
        );
      }
    }
  }

  patientProfileDataRequest() async {
    var res = await crud.connect(
      link: AppLinks.patientProfile,
      method: 'GET',
      headers: {
        'token': userToken,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  doctorProfileData() async {
    loading();
    var res = await doctorProfileDataRequest();
    var statesRes = await statesRequest();
    if (res is RequsetStatus == false && statesRes is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      ResponseModel statesResponseModel = ResponseModel.fromJson(statesRes);
      if (responseModel.responseCode.toString().trim() == '200' &&
          statesResponseModel.responseCode.toString().trim() == '200') {
        AdvancedDoctorModel advancedDoctorModel =
            AdvancedDoctorModel.fromJson(responseModel.data);
        Get.off(
          () => const ProfileScreen(),
          transition: Transition.downToUp,
          arguments: {
            'doctorModel': advancedDoctorModel,
            'states': statesResponseModel.requestedList,
            'specializationsList': specializationsList,
          },
        );
      }
    }
  }

  pharmacyProfileData() async {
    loading();
    var res = await pharmacyProfileDataRequest();
    var statesRes = await statesRequest();
    if (res is RequsetStatus == false && statesRes is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      ResponseModel statesResponseModel = ResponseModel.fromJson(statesRes);
      if (responseModel.responseCode.toString().trim() == '200' &&
          statesResponseModel.responseCode.toString().trim() == '200') {
        List pharmaciesList = responseModel.data['data']!;
        Map<String, dynamic> myPharmacyJson = {};

        for (var element in pharmaciesList) {
          if (element['id'] == userID) {
            myPharmacyJson = element;
            break;
          }
        }

        PharmacyModel pharmacyModel = PharmacyModel.fromJson(myPharmacyJson);
        Get.off(
          () => const ProfileScreen(),
          transition: Transition.downToUp,
          arguments: {
            'pharmacyModel': pharmacyModel,
            'states': statesResponseModel.requestedList,
          },
        );
      }
    }
  }

  doctorProfileDataRequest() async {
    var res = await crud.connect(
      link: AppLinks.doctorDetails,
      data: {
        'doctor_id': userID,
      },
      headers: {
        'token': AppLinks.token,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  pharmacyProfileDataRequest() async {
    var res = await crud.connect(
      link: AppLinks.pharmaciesList,
      headers: {
        'token': AppLinks.token,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  statesRequest() async {
    var res = await crud.connect(
      link: AppLinks.locationsApi,
      data: {
        'type': '2',
        'id': '101',
      },
      headers: {
        'token': AppLinks.token,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  onChangePasswordPressed() {
    Get.toNamed(AppRoutes.changePasswordScreen);
  }

  onAboutUsPressed() async {
    String url = 'https://www.teleprac.com/about-us-page';
    await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }

  onConactUsPressed() async {
    String tele = 'tel:+91-6006715123';
    await launchUrl(
      Uri.parse(tele),
      mode: LaunchMode.externalApplication,
    );
  }

  logout() async {
    loading();
    await myServices.unSubscribeFromUserTopic();
    await myServices.sharedPreferences.clear();
    myServices.loginSuccess = false;
    Get.offAllNamed(AppRoutes.login);
  }

  Future<bool> willPop() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.lightGrey1,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    Get.back();
    return Future.value(false);
  }
}
