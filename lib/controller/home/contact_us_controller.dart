import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/routes.dart';

class ContactUsController extends GetxController {
  TextEditingController nameCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController messageCon = TextEditingController();
  FocusNode nameFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode messageFocus = FocusNode();
  Crud crud = Crud();

  String nameValidationText = '';
  String emailValidationText = '';
  String phoneValidationText = '';
  String messageValidationText = '';

  contactUs() async {
    if (validate()) {
      loading();
      var res = await contactUsReqeust();
      Get.back();
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        Get.offAllNamed(
          AppRoutes.successScreen,
          arguments: {
            'function': () {
              Get.offAllNamed(AppRoutes.home);
            },
            'buttonText': 'Home',
          },
        );
        Fluttertoast.showToast(
          msg: 'Submitted',
          textColor: AppColors.black,
          backgroundColor: AppColors.secondaryColor,
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Something went wrong',
          textColor: AppColors.black,
          backgroundColor: AppColors.secondaryColor,
        );
      }
    }
  }

  contactUsReqeust() async {
    var res = await crud.connect(
      link: AppLinks.contactUs,
      data: {
        'email': emailCon.text.trim(),
        'name': nameCon.text.trim(),
        'phone': phoneCon.text.trim(),
        'message': messageCon.text.trim(),
      },
      headers: {
        'token': AppLinks.token,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  bool validate() {
    bool nameValidate = false;
    bool emailValidate = false;
    bool phoneValidate = false;
    bool messageValidate = false;
    bool valid = false;

    if (nameCon.text.isNotEmpty) {
      nameValidationText = '';
      nameValidate = true;
    } else if (nameCon.text.isEmpty) {
      nameValidationText = 'Can\'t be empty';
    }
    if (messageCon.text.isNotEmpty) {
      messageValidationText = '';
      messageValidate = true;
    } else if (nameCon.text.isEmpty) {
      messageValidationText = 'Can\'t be empty';
    }

    if (GetUtils.isEmail(emailCon.text.trim())) {
      emailValidationText = '';
      emailValidate = true;
    } else if (!GetUtils.isEmail(emailCon.text.trim())) {
      emailValidationText = 'Invalid email';
    }

    if (GetUtils.isPhoneNumber(phoneCon.text.trim())) {
      phoneValidationText = '';
      phoneValidate = true;
    } else if (!GetUtils.isPhoneNumber(phoneCon.text.trim())) {
      phoneValidationText = 'Invalid Phone number';
    }

    if (nameValidate && emailValidate && phoneValidate && messageValidate) {
      valid = true;
    }

    update();
    return valid;
  }
}
