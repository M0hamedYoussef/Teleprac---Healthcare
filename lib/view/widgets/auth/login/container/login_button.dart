import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/auth/login_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class LoginButton extends GetView<LoginCon> {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      height: AppDecoration().screenHeight * 0.06,
      width: AppDecoration().screenWidth * 0.5,
      child: ElevatedButton(
        onPressed: () {
          controller.login();
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
          AppTexts.login,
          style: TextStyle(
            color: AppColors.secondaryColor,
            fontSize: AppDecoration().screenWidth * 0.05,
          ),
        ),
      ),
    );
  }
}
