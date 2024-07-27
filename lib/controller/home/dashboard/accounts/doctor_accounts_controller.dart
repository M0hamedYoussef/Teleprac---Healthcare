import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/model/home/dashboard/accounts/account_details_model.dart';
import 'package:teleprac/routes.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/custom_text_form_field.dart';

class DoctorAccountsController extends GetxController {
  late List accounts;
  late AccountDetailsModel accountDetailsModel;
  late double earned;
  late double requested;
  late double balance;

  Crud crud = Crud();
  MyServices myServices = Get.find();

  @override
  void onInit() {
    accounts = Get.arguments['accounts'];
    accountDetailsModel = Get.arguments['accountDetailsModel'];
    requested = accountDetailsModel.requested!;
    earned = accountDetailsModel.earned!;
    balance = accountDetailsModel.balance! - earned - requested;
    super.onInit();
  }

  goToUpdateAccountDetails() {
    Get.toNamed(
      AppRoutes.doctorAccountUpdateScreen,
      arguments: {
        'accountDetails': accountDetailsModel.accountDetails,
      },
    );
  }

  requestBalance() {
    TextEditingController amountCon = TextEditingController();
    TextEditingController descriptionCon = TextEditingController();
    FocusNode descriptionFocus = FocusNode();
    Get.defaultDialog(
      title: 'Balance Request',
      titleStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: AppDecoration.cairo,
        fontSize: AppDecoration().screenWidth * 0.045,
        color: AppColors.grey,
      ),
      content: Column(
        children: [
          CustomTextFormField(
            textEditingController: amountCon,
            label: 'Amount',
            oldDesign: false,
            nextFocusNode: descriptionFocus,
            keyboardType: TextInputType.number,
          ),
          CustomTextFormField(
            textEditingController: descriptionCon,
            oldDesign: false,
            label: 'Description',
            maxLines: null,
            maxHeight: 0.1,
            focusNode: descriptionFocus,
          ),
          CustomButton(
            function: () async {
              if (amountCon.text.isNotEmpty) {
                if (amountCon.text.isNum) {
                  if (double.parse(amountCon.text) <= balance) {
                    Get.back();
                    loading();
                    var res = await requestBalanceRequest(
                      amount: amountCon.text,
                      description: descriptionCon.text,
                    );
                    ResponseModel responseModel = ResponseModel.fromJson(res);
                    if (responseModel.responseCode == '200') {
                      var doctorAcountRes =
                          await getDoctorAccountDetailsRequest();
                      ResponseModel doctorAccountResponseModel =
                          ResponseModel.fromJson(doctorAcountRes);
                      if (doctorAccountResponseModel.responseCode == '200') {
                        accountDetailsModel = AccountDetailsModel.fromJson(
                          doctorAccountResponseModel.data,
                        );
                        requested = accountDetailsModel.requested!;
                        earned = accountDetailsModel.earned!;
                        balance =
                            accountDetailsModel.balance! - earned - requested;
                        update();
                      }
                      Fluttertoast.showToast(
                        msg: 'Success',
                        backgroundColor: AppColors.secondaryColor,
                        textColor: AppColors.black,
                      );
                    }
                    Get.back();
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Amount Must Be In Your Balance',
                      backgroundColor: AppColors.secondaryColor,
                      textColor: AppColors.black,
                    );
                  }
                } else {
                  Fluttertoast.showToast(
                    msg: 'Amount Must Be Numeric Only',
                    backgroundColor: AppColors.secondaryColor,
                    textColor: AppColors.black,
                  );
                }
              } else {
                Fluttertoast.showToast(
                  msg: 'Please Enter An Amount',
                  backgroundColor: AppColors.secondaryColor,
                  textColor: AppColors.black,
                );
              }
            },
            text: 'Confirm',
            buttonColor: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }

  requestBalanceRequest({
    required String amount,
    required String description,
  }) async {
    var res = await crud.connect(
      link: AppLinks.paymentRequest,
      data: {
        'payment_type': '1',
        'request_amount': amount,
        'description': description,
      },
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  getDoctorAccountDetailsRequest() async {
    var res = await crud.connect(
      link: AppLinks.getDoctorAccountDetails,
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }
}
