import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/auth/login_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class PasswordForm extends StatelessWidget {
  const PasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: GetBuilder<LoginCon>(
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
                      'Password',
                      style: TextStyle(fontFamily: AppDecoration.cairo),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: controller.passCon,
                focusNode: controller.passFocus,
                obscureText: controller.obsc,
                onEditingComplete: () {
                  controller.passwordEditingComplete();
                },
                cursorColor: AppColors.primaryColor,
                decoration: InputDecoration(
                  hintText: 'Enter Your Password',
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.changeObsc();
                    },
                    icon: Icon(
                      Icons.remove_red_eye_outlined,
                      color: controller.obsc
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
                controller.passValidationText,
                style: const TextStyle(
                  color: AppColors.red,
                  fontSize: 14,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
/* OLD
  Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.lightGreen,
                ),
                child: Row(
                  children: [
                    SizedBox(width: AppDecoration().screenWidth * 0.02),
                    GestureDetector(
                      onTap: () {
                        controller.changeObsc();
                      },
                      child: Icon(
                        controller.obsc
                            ? Icons.lock_outline_rounded
                            : Icons.lock_open_rounded,
                        color: AppColors.grey,
                      ),
                    ),
                    SizedBox(width: AppDecoration().screenWidth * 0.02),
                    Expanded(
                      child: TextFormField(
                        controller: controller.passCon,
                        focusNode: controller.passFocus,
                        obscureText: controller.obsc,
                        onEditingComplete: () {
                          controller.passwordEditingComplete();
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          label: Text(AppTexts.passwordLabel),
                          floatingLabelStyle: TextStyle(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
               */