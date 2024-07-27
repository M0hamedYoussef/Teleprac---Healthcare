import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/account_settings/change_password_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class RepeatPasswordForm extends StatelessWidget {
  const RepeatPasswordForm({super.key});

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
                      AppTexts.repeatPassLabel,
                      style: TextStyle(fontFamily: AppDecoration.cairo),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: controller.passRepeatCon,
                focusNode: controller.passRepeatFocus,
                obscureText: controller.obscRePass,
                onEditingComplete: () {
                  controller.rePassEditingCompleted();
                },
                cursorColor: AppColors.primaryColor,
                decoration: InputDecoration(
                  hintText: AppTexts.repeatPassLabel,
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.changeRePassObsc();
                    },
                    icon: Icon(
                      Icons.remove_red_eye_outlined,
                      color: controller.obscRePass
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
                controller.passRepeatValidationText,
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
                        controller.changeRePassObsc();
                      },
                      child: Icon(
                        controller.obscRePass
                            ? Icons.lock_outline_rounded
                            : Icons.lock_open_rounded,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(width: AppDecoration().screenWidth * 0.02),
                    Expanded(
                      child: TextFormField(
                        controller: controller.passRepeatCon,
                        focusNode: controller.passRepeatFocus,
                        obscureText: controller.obscRePass,
                        onEditingComplete: () {
                          controller.rePassEditingCompleted();
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          label: Text(AppTexts.repeatPassLabel),
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
                controller.passRepeatValidationText,
                style: const TextStyle(
                  color: AppColors.red,
                ),
              ),
            ],
          ),
        );
      },
    ); */