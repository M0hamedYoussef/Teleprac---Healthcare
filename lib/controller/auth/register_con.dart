import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/routes.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterCon extends GetxController {
  TextEditingController firstNameCon = TextEditingController();
  TextEditingController lastNameCon = TextEditingController();
  TextEditingController mobileNoCon = TextEditingController();
  TextEditingController otpCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  TextEditingController passRepeatCon = TextEditingController();
  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode mobileNoFocus = FocusNode();
  FocusNode otpFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passFocus = FocusNode();
  FocusNode passRepeatFocus = FocusNode();
  String firstNameValidationText = '';
  String lastNameValidationText = '';
  String mobileNoValidationText = '';
  String emailValidationText = '';
  String passValidationText = '';
  String passRepeatValidationText = '';
  String roleValidationText = '';
  String otpText = '';
  bool obscPass = true;
  bool obscRePass = true;
  String role = '';
  Crud crud = Crud();

  List roles = [
    {
      'label': 'Doctor',
      'value': '1',
    },
    {
      'label': 'Patient',
      'value': '2',
    },
    {
      'label': 'Lab',
      'value': '4',
    },
    {
      'label': 'Pharmacy',
      'value': '5',
    },
    {
      'label': 'Clinic',
      'value': '6',
    },
    {
      'label': 'Nurse',
      'value': '7',
    },
  ];

  // @override
  // void onInit() {
  //   SystemChrome.setSystemUIOverlayStyle(
  //     const SystemUiOverlayStyle(
  //       statusBarColor: AppColors.lightGreenSecond,
  //       statusBarIconBrightness: Brightness.dark,
  //     ),
  //   );
  //   super.onInit();
  // }

  Future<bool> willPop() {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     statusBarColor: AppColors.transparent,
    //     statusBarIconBrightness: Brightness.dark,
    //   ),
    // );
    Get.back();
    return Future.value(false);
  }

  changePassObsc() {
    obscPass = !obscPass;
    update();
  }

  changeRePassObsc() {
    obscRePass = !obscRePass;
    update();
  }

  firstNameEditingCompleted() {
    if (firstNameCon.text.isNotEmpty) {
      firstNameValidationText = '';
      update();
      lastNameFocus.requestFocus();
    } else {
      firstNameValidationText = 'Please type your first name';
      update();
    }
  }

  lastNameEditingCompleted() {
    if (lastNameCon.text.isNotEmpty) {
      lastNameValidationText = '';
      update();
      mobileNoFocus.requestFocus();
    } else {
      lastNameValidationText = 'Please type your last name';
      update();
    }
  }

  mobileNoEditingCompleted() {
    if (GetUtils.isPhoneNumber(mobileNoCon.text)) {
      mobileNoValidationText = '';
      update();
      // sendOtp();
      // otpFocus.requestFocus();
      emailFocus.requestFocus();
    } else {
      mobileNoValidationText = 'Please Enter a valid phone number';
      update();
    }
  }

  otpEditingCompleted() {
    emailFocus.requestFocus();
  }

  emailEditingCompleted() {
    if (GetUtils.isEmail(emailCon.text)) {
      emailValidationText = '';
      update();
      passFocus.requestFocus();
    } else {
      emailValidationText = 'Please Enter a valid email';
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
    } else {
      passRepeatValidationText = 'Passwords are not the same';
      update();
    }
  }

  sendOtp() async {
    var otpRes = await otpRequest();
    if (otpRes is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(otpRes);
      if (responseModel.responseMessage.toString().trim() ==
          'OTP send successfully') {
        otpText = 'sent successfully';
        update();
      } else if (responseModel.responseMessage.toString().trim() ==
          'Mobileno already exits') {
        otpText = '';
        update();
        Get.defaultDialog(
          middleText: 'Mobile Number Already In Use',
        );
      }
    }
  }

  otpRequest() async {
    var res = await crud.connect(
      link: AppLinks.generateOtp,
      data: {
        'mobileno': mobileNoCon.text.trim(),
        'country_code': '91',
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  verifyOtp() async {
    loading();
    var verifyRes = await otpVerifyRequest();
    Get.back();
    if (verifyRes is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(verifyRes);
      if (responseModel.responseMessage!.trim() == 'Invalid OTP.') {
        Get.defaultDialog(
          middleText: 'Invalid OTP',
        );
        // return false;
      } else if (responseModel.responseMessage!.trim() ==
          "OTP verified successfully") {
        register();
        Fluttertoast.showToast(
          msg: 'OTP Verified Successfully',
          textColor: AppColors.black,
          backgroundColor: AppColors.secondaryColor,
        );
        // Get.defaultDialog(
        //   middleText: 'OTP Verified Successfully',
        // );
        // return true;
      }
      // else {
      // return false;
      // }
    }
    //  else {
    // return false;
    // }
  }

  otpVerifyRequest() async {
    var res = await crud.connect(
      link: AppLinks.verifyOtp,
      data: {
        'mobileno': mobileNoCon.text.trim(),
        'otp': otpCon.text.trim(),
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  goToOtpScreen() {
    if (validate()) {
      Get.toNamed(
        AppRoutes.verifyOtp,
      );
    }
  }

  register() async {
    // if (validate()) {
    loading();
    var registerRes = await registerRequest();
    Get.back();
    if (registerRes is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(registerRes);
      if (responseModel.responseMessage.toString().trim() ==
          'Registration success') {
        Get.offAllNamed(
          AppRoutes.successScreen,
          arguments: {
            'function': () {
              Get.offAllNamed(AppRoutes.login);
            },
            'buttonText': 'Login',
          },
        );
      } else if (responseModel.responseMessage.toString().trim() ==
          'Your email address already exits') {
        Get.defaultDialog(
          middleText: 'Email Already In Use',
        );
      } else if (responseModel.responseMessage.toString().trim() ==
          'Your mobileno already exits') {
        Get.defaultDialog(
          middleText: 'Mobile Number Already In Use',
        );
      }
    }
    // }
  }

  registerRequest() async {
    var res = await crud.connect(
      link: AppLinks.signUp,
      data: {
        'first_name': firstNameCon.text.trim(),
        'last_name': lastNameCon.text.trim(),
        'email': emailCon.text.trim(),
        'mobileno': mobileNoCon.text.trim(),
        'role': role,
        'password': passCon.text.trim(),
        'confirm_password': passRepeatCon.text.trim(),
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  validate() {
    bool firstV = false;
    bool lastV = false;
    bool phoneNumberV = false;
    bool emailV = false;
    bool passV = false;
    bool passRepeatV = false;
    bool roleV = false;
    // bool otpV = false;

    // FirstName Validate
    if (firstNameCon.text.isNotEmpty) {
      firstNameValidationText = '';
      firstV = true;
    } else {
      firstNameValidationText = 'Please type your first name';
    }
    // LastName Validate
    if (lastNameCon.text.isNotEmpty) {
      lastNameValidationText = '';
      lastV = true;
    } else {
      lastNameValidationText = 'Please type your last name';
    }
    // PhoneNumber Validate
    if (GetUtils.isPhoneNumber(mobileNoCon.text)) {
      mobileNoValidationText = '';
      phoneNumberV = true;
    } else {
      mobileNoValidationText = 'Please Enter a valid phone number';
    }
    // Email Validate
    if (GetUtils.isEmail(emailCon.text)) {
      emailValidationText = '';
      emailV = true;
    } else {
      emailValidationText = 'Please Enter a valid email';
    }
    // Password Validate
    if (passCon.text.trim().length >= 6) {
      passValidationText = '';
      passV = true;
    } else {
      passValidationText = 'Password should be 6 or more characters long';
    }
    // Password Repeat Validate
    if (passRepeatCon.text.isEmpty) {
      passRepeatValidationText = 'Can\'t be empty';
    } else if (passCon.text != passRepeatCon.text) {
      passRepeatValidationText = 'Passwords are not the same';
    } else {
      passRepeatValidationText = '';
      passRepeatV = true;
    }
    // Role Validate
    if (role.isEmpty) {
      roleValidationText = 'Select your role';
    } else {
      roleValidationText = '';
      roleV = true;
    }
    update();

    // if (firstV &&
    //     lastV &&
    //     phoneNumberV &&
    //     emailV &&
    //     passV &&
    //     passRepeatV &&
    //     roleV) {
    //   if (otpCon.text.trim().isNotEmpty) {
    //     if (otpCon.text.isNumericOnly) {
    //       otpV = await verifyOtp();
    //     } else {
    //       Get.defaultDialog(
    //         middleText: 'Otp Must Be Numbers Only',
    //       );
    //       otpV = false;
    //     }
    //   } else {
    //     Get.defaultDialog(
    //       middleText: 'Otp Can\'t Be Empty',
    //     );
    //     otpV = false;
    //   }
    // }
    //
    if (firstV &&
            lastV &&
            phoneNumberV &&
            emailV &&
            passV &&
            passRepeatV &&
            roleV
        //  &&
        // otpV
        ) {
      return true;
    } else {
      return false;
    }
  }
}
