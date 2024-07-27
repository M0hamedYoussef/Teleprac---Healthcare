import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/routes.dart';

class MyFamilyController extends GetxController {
  late List myFamily;
  Crud crud = Crud();
  MyServices myServices = Get.find();
  TextEditingController nameCon = TextEditingController();
  TextEditingController phoneNumberCon = TextEditingController();
  TextEditingController addressCon = TextEditingController();
  TextEditingController relationCon = TextEditingController();
  FocusNode nameFocus = FocusNode();
  FocusNode phoneNumberFocus = FocusNode();
  FocusNode addressFocus = FocusNode();
  FocusNode relationFocus = FocusNode();
  String gender = '';
  String dob = '';
  String bloodGroup = '';
  List bloodGroups = [
    {
      'value': 'A+',
      'label': 'A+',
    },
    {
      'value': 'A-',
      'label': 'A-',
    },
    {
      'value': 'B+',
      'label': 'B+',
    },
    {
      'value': 'B-',
      'label': 'B-',
    },
    {
      'value': 'AB+',
      'label': 'AB+',
    },
    {
      'value': 'AB-',
      'label': 'AB-',
    },
    {
      'value': 'O+',
      'label': 'O+',
    },
    {
      'value': 'O-',
      'label': 'O-',
    },
  ];
  List genders = [
    {
      'value': 'Male',
      'label': 'Male',
    },
    {
      'value': 'Female',
      'label': 'Female',
    }
  ];

  @override
  void onInit() {
    myFamily = Get.arguments['family_members'];
    super.onInit();
  }

  goToAddFamilyMember() {
    Get.toNamed(AppRoutes.familyMemberScreen);
  }

  selectDate({required BuildContext context}) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dob == '' ? DateTime.now() : DateTime.parse(dob),
      firstDate: DateTime.parse('1900-01-01'),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      dob = picked.toString().substring(0, 10);
      update();
    }
  }

  addFamilyMember() async {
    if (nameCon.text.isNotEmpty) {
      loading();
      var res = await addFamilyMemberRequest();
      if (res is RequsetStatus == false) {
        ResponseModel responseModel = ResponseModel.fromJson(res);
        if (responseModel.responseCode == '200') {
          myFamily.add({
            'name': nameCon.text.trim(),
            'contact': '+91${phoneNumberCon.text.trim().replaceAll('+91', '')}',
            'address': addressCon.text.trim(),
            'relation': relationCon.text.trim(),
            'dob': dob,
            'gender': gender.capitalizeFirst,
            'blood_group': bloodGroup.capitalizeFirst,
          });
          nameCon.clear();
          phoneNumberCon.clear();
          addressCon.clear();
          relationCon.clear();
          gender = '';
          bloodGroup = '';
          dob = '';
          update();
          Get.back();
          Get.back();
        } else {
          Get.back();
          Fluttertoast.showToast(
            msg: 'Something Went Wrong',
            textColor: AppColors.black,
            backgroundColor: AppColors.secondaryColor,
          );
        }
      }
    } else {
      Get.defaultDialog(middleText: 'Name Can\'t be empty');
    }
  }

  addFamilyMemberRequest() async {
    var res = await crud.connect(
      link: AppLinks.addFamilyMember,
      data: {
        'name': nameCon.text.trim(),
        'contact': '+91${phoneNumberCon.text.trim().replaceAll('+91', '')}',
        'address': addressCon.text.trim(),
        'relation': relationCon.text.trim(),
        'dob': dob,
        'gender': gender.capitalizeFirst,
        'blood_group': bloodGroup.capitalizeFirst,
      },
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  Future<bool> addFamilyWillPop() {
    nameCon.clear();
    phoneNumberCon.clear();
    addressCon.clear();
    relationCon.clear();
    gender = '';
    dob = '';
    bloodGroup = '';
    Get.back();
    return Future.value(false);
  }
}
