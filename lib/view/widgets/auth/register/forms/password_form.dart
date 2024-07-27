import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/auth/register_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class PasswordForm extends StatelessWidget {
  const PasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterCon>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
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
                obscureText: controller.obscPass,
                onEditingComplete: () {
                  controller.passEditingCompleted();
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
                      controller.changePassObsc();
                    },
                    icon: Icon(
                      Icons.remove_red_eye_outlined,
                      color: controller.obscPass
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
