import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/auth/forgot_password_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class ResetButton extends GetView<ForgotPassCon> {
  const ResetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      height: AppDecoration().screenHeight * 0.05,
      width: AppDecoration().screenWidth,
      child: ElevatedButton(
        onPressed: () {
          controller.forgotPass();
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
          AppTexts.reset,
          style: TextStyle(
            color: AppColors.secondaryColor,
            fontSize: AppDecoration().screenWidth * 0.06,
          ),
        ),
      ),
    );
  }
}
