import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard/accounts/doctor_account_update_controller.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/custom_text_form_field.dart';

class DoctorAccountUpdateScreen extends StatelessWidget {
  const DoctorAccountUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DoctorAccountUpdateController controller =
        Get.put(DoctorAccountUpdateController());

    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: SafeArea(
        child: Column(
          children: [
            const UpperPart(
              text: 'Account Details',
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.02),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.secondaryColor,
                    ),
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        SizedBox(height: AppDecoration().screenHeight * 0.02),
                        CustomTextFormField(
                          textEditingController: controller.bankNameCon,
                          nextFocusNode: controller.branchNameFocus,
                          label: 'Bank Name',
                          oldDesign: false,
                        ),
                        SizedBox(height: AppDecoration().screenHeight * 0.01),
                        CustomTextFormField(
                          textEditingController: controller.branchNameCon,
                          focusNode: controller.branchNameFocus,
                          nextFocusNode: controller.accountNameFocus,
                          label: 'Branch Name',
                          oldDesign: false,
                        ),
                        SizedBox(height: AppDecoration().screenHeight * 0.01),
                        CustomTextFormField(
                          textEditingController: controller.accountNameCon,
                          focusNode: controller.accountNameFocus,
                          nextFocusNode: controller.accountNumberFocus,
                          label: 'Account Name',
                          oldDesign: false,
                        ),
                        SizedBox(height: AppDecoration().screenHeight * 0.01),
                        CustomTextFormField(
                          textEditingController: controller.accountNumberCon,
                          focusNode: controller.accountNumberFocus,
                          nextFocusNode: controller.ifscCodeFocus,
                          label: 'Account Number',
                          oldDesign: false,
                        ),
                        SizedBox(height: AppDecoration().screenHeight * 0.01),
                        CustomTextFormField(
                          textEditingController: controller.ifscCodeCon,
                          focusNode: controller.ifscCodeFocus,
                          nextFocusNode: controller.upiIdFocus,
                          label: 'IFSC CODE',
                          oldDesign: false,
                        ),
                        SizedBox(height: AppDecoration().screenHeight * 0.01),
                        CustomTextFormField(
                          textEditingController: controller.upiIdCon,
                          focusNode: controller.upiIdFocus,
                          label: 'UPI ID',
                          oldDesign: false,
                          onEditingComplete: () {
                            controller.updateAccountDetails();
                          },
                        ),
                        SizedBox(height: AppDecoration().screenHeight * 0.02),
                      ],
                    ),
                  ),
                  SizedBox(height: AppDecoration().screenHeight * 0.05),
                  CustomButton(
                    function: () {
                      controller.updateAccountDetails();
                    },
                    text: 'Confirm',
                    textColor: AppColors.secondaryColor,
                    buttonColor: AppColors.primaryColor,
                    circularRadius: 10,
                    width: 0.7,
                  ),
                  SizedBox(height: AppDecoration().screenHeight * 0.02),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
