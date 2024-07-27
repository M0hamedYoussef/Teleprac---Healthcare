import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/auth/register_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class RegisterButton extends GetView<RegisterCon> {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      height: AppDecoration().screenHeight * 0.05,
      child: ElevatedButton(
        onPressed: () {
          controller.goToOtpScreen();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.secondaryColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          AppTexts.sendOtp,
          style: TextStyle(
            color: AppColors.secondaryColor,
            fontSize: AppDecoration().screenWidth * 0.047,
          ),
        ),
      ),
    );
  }
}
