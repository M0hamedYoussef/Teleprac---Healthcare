import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/doctors/notify_me_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/custom_text_form_field.dart';

class NotifyMeFields extends StatelessWidget {
  const NotifyMeFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.secondaryColor,
      ),
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: GetBuilder<NotifyMeController>(
        builder: (controller) {
          return Column(
            children: [
              SizedBox(height: AppDecoration().screenHeight * 0.02),
              CustomTextFormField(
                textEditingController: controller.nameCon,
                focusNode: controller.nameFocus,
                nextFocusNode: controller.phoneFocus,
                validationText: controller.nameValidationText,
                label: 'Full Name',
                oldDesign: false,
              ),
              SizedBox(height: AppDecoration().screenHeight * 0.01),
              CustomTextFormField(
                leading: const Icon(
                  Icons.phone,
                  color: AppColors.primaryColor,
                ),
                textEditingController: controller.phoneCon,
                focusNode: controller.phoneFocus,
                nextFocusNode: controller.emailFocus,
                keyboardType: TextInputType.number,
                oldDesign: false,
                validationText: controller.phoneValidationText,
                label: 'Phone Number',
              ),
              SizedBox(height: AppDecoration().screenHeight * 0.01),
              CustomTextFormField(
                leading: const Icon(
                  Icons.mail,
                  color: AppColors.primaryColor,
                ),
                textEditingController: controller.emailCon,
                focusNode: controller.emailFocus,
                oldDesign: false,
                validationText: controller.emailValidationText,
                label: 'Email',
                onEditingComplete: () {
                  controller.notifyNext();
                },
              ),
              SizedBox(height: AppDecoration().screenHeight * 0.02),
            ],
          );
        },
      ),
    );
  }
}
