import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/account_settings/change_password_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class CurrentPasswordForm extends StatelessWidget {
  const CurrentPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: GetBuilder<ChangePasswordController>(
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.lock_outline,
                    color: AppColors.grey,
                  ),
                  SizedBox(width: AppDecoration().screenWidth * 0.02),
                  const Expanded(
                    child: Text(
                      AppTexts.currentPass,
                      style: TextStyle(fontFamily: AppDecoration.cairo),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: controller.currentPassCon,
                focusNode: controller.currentPassFocus,
                obscureText: controller.obscCurrentPass,
                onEditingComplete: () {
                  controller.currentPassEditingCompleted();
                },
                cursorColor: AppColors.primaryColor,
                decoration: InputDecoration(
                  hintText: 'Enter Your Current Password',
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.changeCurrentPassObsc();
                    },
                    icon: Icon(
                      Icons.remove_red_eye_outlined,
                      color: controller.obscCurrentPass
                          ? AppColors.grey
                          : AppColors.primaryColor,
                    ),
                  ),
                  focusColor: AppColors.primaryColor,
                  floatingLabelStyle: const TextStyle(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: AppDecoration().screenHeight * 0.02),
              Text(
                controller.currentPassValidationText,
                style: TextStyle(
                  color: AppColors.red,
                  fontSize: AppDecoration().screenWidth * 0.04,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/*
GetBuilder<ChangePasswordController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.lightGreen,
                ),
                child: Row(
                  children: [
                    SizedBox(width: AppDecoration().screenWidth * 0.05),
                    GestureDetector(
                      onTap: () {
                        controller.changeCurrentPassObsc();
                      },
                      child: Icon(
                        controller.obscCurrentPass
                            ? Icons.lock_outline_rounded
                            : Icons.lock_open_rounded,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(width: AppDecoration().screenWidth * 0.02),
                    Expanded(
                      child: TextFormField(
                        controller: controller.currentPassCon,
                        focusNode: controller.currentPassFocus,
                        obscureText: controller.obscCurrentPass,
                        onEditingComplete: () {
                          controller.currentPassEditingCompleted();
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          label: Text(AppTexts.currentPass),
                          floatingLabelStyle: TextStyle(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                controller.currentPassValidationText,
                style: const TextStyle(
                  color: AppColors.red,
                ),
              ),
            ],
          ),
        );
      },
    );

 */