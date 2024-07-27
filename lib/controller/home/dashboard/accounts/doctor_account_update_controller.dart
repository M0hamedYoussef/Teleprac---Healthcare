import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard/accounts/doctor_accounts_controller.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/model/home/dashboard/accounts/account_details_model.dart';

class DoctorAccountUpdateController extends GetxController {
  late AccountDetails accountDetails;
  //
  late TextEditingController bankNameCon;
  late TextEditingController branchNameCon;
  late TextEditingController accountNameCon;
  late TextEditingController accountNumberCon;
  late TextEditingController ifscCodeCon;
  late TextEditingController upiIdCon;
  FocusNode branchNameFocus = FocusNode();
  FocusNode accountNameFocus = FocusNode();
  FocusNode accountNumberFocus = FocusNode();
  FocusNode ifscCodeFocus = FocusNode();
  FocusNode upiIdFocus = FocusNode();
  //
  Crud crud = Crud();
  MyServices myServices = Get.find();
  DoctorAccountsController doctorAccountsController = Get.find();

  @override
  void onInit() {
    accountDetails = Get.arguments['accountDetails'];
    bankNameCon = TextEditingController(text: accountDetails.bankName ?? '');
    branchNameCon =
        TextEditingController(text: accountDetails.branchName ?? '');
    accountNameCon =
        TextEditingController(text: accountDetails.accountName ?? '');
    accountNumberCon =
        TextEditingController(text: accountDetails.accountNo ?? '');
    ifscCodeCon = TextEditingController(text: accountDetails.ifscCode ?? '');
    upiIdCon = TextEditingController(text: accountDetails.upiId ?? '');
    super.onInit();
  }

  updateAccountDetails() async {
    if (validate()) {
      loading();
      var res = await updateAccountDetailsRequest();
      Get.back();
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        Get.back();
        doctorAccountsController.accountDetailsModel.accountDetails!
            .accountName = accountNameCon.text.trim();

        doctorAccountsController.accountDetailsModel.accountDetails!.accountNo =
            accountNumberCon.text.trim();

        doctorAccountsController.accountDetailsModel.accountDetails!.bankName =
            bankNameCon.text.trim();
        doctorAccountsController.accountDetailsModel.accountDetails!
            .branchName = branchNameCon.text.trim();

        doctorAccountsController.accountDetailsModel.accountDetails!.ifscCode =
            ifscCodeCon.text.trim();

        doctorAccountsController.accountDetailsModel.accountDetails!.upiId =
            upiIdCon.text.trim();

        doctorAccountsController.update();
        Fluttertoast.showToast(
          msg: 'Success',
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

  updateAccountDetailsRequest() async {
    var res = await crud.connect(
      link: AppLinks.addDoctorAccountDetails,
      data: {
        'user_id': myServices.sharedPreferences.getString('id')!,
        'bank_name': bankNameCon.text.trim(),
        'branch_name': branchNameCon.text.trim(),
        'account_name': accountNameCon.text.trim(),
        'account_no': accountNumberCon.text.trim(),
        'upi_id': upiIdCon.text.trim(),
        'ifsc_code': ifscCodeCon.text.trim(),
      },
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  bool validate() {
    if (bankNameCon.text.trim().isEmpty ||
        branchNameCon.text.trim().isEmpty ||
        accountNameCon.text.trim().isEmpty ||
        accountNumberCon.text.trim().isEmpty) {
      Get.defaultDialog(
        middleText:
            'Bank Name ,Branch Name , Account Name and Account Number are required',
        middleTextStyle: TextStyle(
          fontWeight: FontWeight.w300,
          fontFamily: AppDecoration.cairo,
          fontSize: AppDecoration().screenWidth * 0.045,
          color: AppColors.black,
        ),
      );
      return false;
    } else {
      return true;
    }
  }
}
