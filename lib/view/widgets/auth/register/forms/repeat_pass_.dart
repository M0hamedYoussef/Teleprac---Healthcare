import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/auth/register_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class RepeatPasswordForm extends StatelessWidget {
  const RepeatPasswordForm({super.key});

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
                      'Password Confirmation',
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
                  hintText: 'Repeat Your Password',
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
