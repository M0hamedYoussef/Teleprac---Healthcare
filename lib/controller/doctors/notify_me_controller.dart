import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/routes.dart';

class NotifyMeController extends GetxController {
  late String doctorId;
  TextEditingController emailCon = TextEditingController();
  TextEditingController nameCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode nameFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  Crud crud = Crud();

  String nameValidationText = '';
  String emailValidationText = '';
  String phoneValidationText = '';

  @override
  void onInit() {
    doctorId = Get.arguments['doctor_id'];
    super.onInit();
  }

  notifyNext() async {
    if (validate()) {
      loading();
      var res = await notifyNextRequest();
      Get.back();
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        Get.offNamed(
          AppRoutes.successScreen,
          arguments: {
            'function': () {
              Get.offAllNamed(AppRoutes.home);
            },
            'buttonText': 'Home',
          },
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

  notifyNextRequest() async {
    var res = await crud.connect(
      link: AppLinks.notifyNextAppointment,
      data: {
        'doctor_id': doctorId,
        'email': emailCon.text.trim(),
        'name': nameCon.text.trim(),
        'phone': phoneCon.text.trim(),
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
    bool valid = false;

    if (nameCon.text.isNotEmpty) {
      nameValidationText = '';
      nameValidate = true;
    } else if (nameCon.text.isEmpty) {
      nameValidationText = 'Can\'t be empty';
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

    if (nameValidate && emailValidate && phoneValidate) {
      valid = true;
    }

    update();
    return valid;
  }
}
