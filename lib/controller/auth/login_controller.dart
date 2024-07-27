import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/main_controller.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/model/global/user_model.dart';
import 'package:teleprac/routes.dart';

class LoginCon extends GetxController {
  TextEditingController emailCon = TextEditingController();
  FocusNode emailFocus = FocusNode();
  TextEditingController passCon = TextEditingController();
  FocusNode passFocus = FocusNode();
  bool rememberMe = true;
  bool obsc = true;
  Crud crud = Crud();
  MyServices myServices = Get.find();
  MainController mainController = Get.find();
  String emailValidationText = '';
  String passValidationText = '';
  @override
  void onInit() {
    super.onInit();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    emailFocus.addListener(() {
      update();
    });
    passFocus.addListener(() {
      update();
    });
  }

  emailEditingCompleted() {
    passFocus.requestFocus();
  }

  passwordEditingComplete() {
    login();
  }

  checkbox() {
    rememberMe = !rememberMe;
    update();
  }

  changeObsc() {
    obsc = !obsc;
    update();
  }

  forgotPass() {
    Get.toNamed(AppRoutes.forgotPass);
  }

  createAcc() {
    Get.toNamed(AppRoutes.register);
  }

  login() async {
    validate();
    if (passValidationText.isEmpty && emailValidationText.isEmpty) {
      loading();
      var data = await request();
      Get.back();
      if (data is RequsetStatus == false) {
        ResponseModel responseModel = ResponseModel.fromJson(data);
        if (responseModel.responseCode == '500') {
          if (responseModel.responseMessage!.trim() ==
              'Wrong login credentials.') {
            Get.defaultDialog(
              title: 'Alert',
              middleText: 'Wrong Credentials',
            );
          } else if (responseModel.responseMessage!.trim() ==
              'Your account has been inactive.') {
            Get.defaultDialog(
              title: 'Alert',
              middleText: 'Your Account Is Not Activated',
            );
          }
        } else if (responseModel.responseCode == '200') {
          loading();
          UserModel myUserModel = UserModel.fromJson(responseModel.userData!);

          // Main
          await myServices.sharedPreferences
              .setString('email', myUserModel.email!);
          await myServices.sharedPreferences
              .setString('password', passCon.text.trim());
          await myServices.sharedPreferences
              .setString('mobileNumber', myUserModel.mobileno!);
          // Name
          await myServices.sharedPreferences
              .setString('username', myUserModel.username!);
          await myServices.sharedPreferences
              .setString('first_name', myUserModel.firstName!);
          await myServices.sharedPreferences
              .setString('last_name', myUserModel.lastName!);
          // Details
          await myServices.sharedPreferences
              .setString('role', myUserModel.role!);
          await myServices.sharedPreferences.setString(
            'pfp',
            '${AppLinks.baseUrl}/${myUserModel.profileimage!}',
          );
          await myServices.sharedPreferences
              .setString('token', myUserModel.token!);
          await myServices.sharedPreferences.setString('id', myUserModel.id!);
          await myServices.sharedPreferences
              .setString('status', myUserModel.status!);
          await myServices.sharedPreferences
              .setString('role', myUserModel.role!);
          //
          if (rememberMe) {
            await myServices.sharedPreferences.setBool('LoginSkip', true);
          }
          await myServices.myFavourites();
          await myServices.getUserLocation();
          await myServices.setUserTopic();
          //
          mainController.firstName = myUserModel.firstName!;
          mainController.lastName = myUserModel.lastName!;
          mainController.myRole = myUserModel.role!;
          mainController.fullName =
              '${myUserModel.firstName!} ${myUserModel.lastName!}';
          mainController.currentLocation =
              myServices.currentLocation ?? 'Unavailable';
          Get.offAllNamed(AppRoutes.home);
        } else {
          Get.defaultDialog(
            middleText: responseModel.responseMessage!.trim(),
          );
        }
      }
    }
  }

  validate() {
    if (!GetUtils.isEmail(emailCon.text)) {
      emailValidationText = "Please Type Valid Email";
      update();
    } else {
      emailValidationText = "";
      update();
    }
    if (passCon.text.isEmpty == true) {
      passValidationText = "Please Type The Password";
      update();
    } else if (passCon.text.length <= 5) {
      passValidationText = "Please Type Valid Password";
      update();
    } else {
      passValidationText = '';
      update();
    }
  }

  request() async {
    var res = await crud.connect(
      link: AppLinks.signIn,
      data: {
        'email': emailCon.text.trim(),
        'password': passCon.text.trim(),
      },
    );
    return res.fold((l) => l, (r) => r);
  }
}
