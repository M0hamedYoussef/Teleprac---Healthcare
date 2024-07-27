import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/routes.dart';

class ForgotPassCon extends GetxController {
  TextEditingController emailCon = TextEditingController();
  FocusNode emailFocus = FocusNode();
  String emailValidationText = '';
  Crud crud = Crud();

  // @override
  // void onInit() {
  //   super.onInit();
  //   SystemChrome.setSystemUIOverlayStyle(
  //     const SystemUiOverlayStyle(
  //       statusBarColor: AppColors.lightGreenSecond,
  //       statusBarIconBrightness: Brightness.dark,
  //     ),
  //   );
  // }

  forgotPass() async {
    validate();
    if (emailValidationText.isEmpty) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarColor: AppColors.transparent,
          statusBarBrightness: Brightness.dark,
        ),
      );
      loading();
      var data = await request();
      Get.back();
      if (data is RequsetStatus == false) {
        ResponseModel responseModel = ResponseModel.fromJson(data);
        if (responseModel.responseCode == '200' &&
            responseModel.responseMessage.toString().trim() ==
                'Your email address not registered') {
          Get.defaultDialog(
            middleText: responseModel.responseMessage.toString(),
          );
        } else if (responseModel.responseCode == '200' &&
            responseModel.responseMessage.toString().trim() ==
                'Your reset password email sent successfully') {
          Get.offAllNamed(
            AppRoutes.successScreen,
            arguments: {
              'function': () {
                Get.offAllNamed(AppRoutes.login);
              },
              'centerText':
                  'Password recovery email sent.\nPlease check your inbox (and spam folder) for instructions and password reset link.\nThank you',
              'buttonText': 'Login',
            },
          );
        }
      }
    }
  }

  emailEditingCompleted() {
    forgotPass();
  }

  validate() {
    if (!GetUtils.isEmail(emailCon.text)) {
      emailValidationText = "Please Type Valid Email";
      update();
    } else {
      emailValidationText = "";
      update();
    }
  }

  request() async {
    var res = await crud.connect(
      link: AppLinks.forgotPassword,
      data: {
        'email': emailCon.text.trim(),
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  Future<bool> willPop() {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     statusBarColor: AppColors.transparent,
    //     statusBarIconBrightness: Brightness.dark,
    //   ),
    // );
    // Get.offAllNamed(AppRoutes.login);
    Get.back();
    return Future.value(false);
  }
}
