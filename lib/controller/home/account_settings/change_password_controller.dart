import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/routes.dart';

class ChangePasswordController extends GetxController {
  TextEditingController currentPassCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  TextEditingController passRepeatCon = TextEditingController();
  FocusNode currentPassFocus = FocusNode();
  FocusNode passFocus = FocusNode();
  FocusNode passRepeatFocus = FocusNode();
  String currentPassValidationText = '';
  String passValidationText = '';
  String passRepeatValidationText = '';
  bool obscCurrentPass = true;
  bool obscPass = true;
  bool obscRePass = true;
  Crud crud = Crud();
  MyServices myServices = Get.find();

  @override
  void onInit() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    super.onInit();
  }

  changeCurrentPassObsc() {
    obscCurrentPass = !obscCurrentPass;
    update();
  }

  changePassObsc() {
    obscPass = !obscPass;
    update();
  }

  changeRePassObsc() {
    obscRePass = !obscRePass;
    update();
  }

  currentPassEditingCompleted() {
    if (currentPassCon.text.trim().length >= 6) {
      currentPassValidationText = '';
      update();
      passFocus.requestFocus();
    } else {
      currentPassValidationText =
          'Password should be 6 or more characters long';
      update();
    }
  }

  passEditingCompleted() {
    if (passCon.text.trim().length >= 6) {
      passValidationText = '';
      update();
      passRepeatFocus.requestFocus();
    } else {
      passValidationText = 'Password should be 6 or more characters long';
      update();
    }
  }

  rePassEditingCompleted() {
    if (passRepeatCon.text.isEmpty) {
      passRepeatValidationText = 'Can\'t be empty';
      update();
    } else if (passCon.text == passRepeatCon.text) {
      passRepeatValidationText = '';
      update();
      changePassword();
    } else {
      passRepeatValidationText = 'Passwords are not the same';
      update();
    }
  }

  changePassword() async {
    if (await validate()) {
      loading();
      var changePasswordRes = await changePasswordRequest();
      Get.back();
      if (changePasswordRes is RequsetStatus == false) {
        ResponseModel responseModel = ResponseModel.fromJson(changePasswordRes);
        if (responseModel.responseMessage.toString().trim() ==
            'Password successfully updated') {
          await myServices.sharedPreferences.setString(
            'password',
            passCon.text.trim(),
          );

          Get.offAllNamed(
            AppRoutes.successScreen,
            arguments: {
              'function': () {
                Get.offAllNamed(AppRoutes.home);
              },
              'buttonText': 'Home',
            },
          );
        } else if (responseModel.responseMessage.toString().trim() ==
            'Your current password is invalid') {
          Get.defaultDialog(
            middleText: 'Wrong Password',
          );
        } else if (responseModel.responseMessage.toString().trim() ==
            'Password changed failed') {
          Get.defaultDialog(
            middleText: 'You Entered Your Current Password',
          );
        }
      }
    }
  }

  changePasswordRequest() async {
    var res = await crud.connect(
      link: AppLinks.changePassword,
      data: {
        'current_password': currentPassCon.text.trim(),
        'password': passCon.text.trim(),
        'confirm_password': passRepeatCon.text.trim(),
      },
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  Future<bool> validate() async {
    bool currentPassV = false;
    bool passV = false;
    bool passRepeatV = false;

    if (currentPassCon.text.trim().length >= 6) {
      currentPassValidationText = '';
      currentPassV = true;
    } else {
      currentPassValidationText =
          'Password should be 6 or more characters long';
    }

    if (passCon.text.trim().length >= 6) {
      passValidationText = '';
      passV = true;
    } else {
      passValidationText = 'Password should be 6 or more characters long';
    }
    if (passRepeatCon.text.isEmpty) {
      passRepeatValidationText = 'Can\'t be empty';
    } else if (passCon.text != passRepeatCon.text) {
      passRepeatValidationText = 'Passwords are not the same';
    } else {
      passRepeatValidationText = '';
      passRepeatV = true;
    }

    if (currentPassV && passV && passRepeatV) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> willPop() {
    Get.back();
    return Future.value(false);
  }
}
