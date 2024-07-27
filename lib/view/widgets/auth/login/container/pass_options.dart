import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/auth/login_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class PasswordOptions extends GetView<LoginCon> {
  const PasswordOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: Center(
        child: GestureDetector(
          onTap: () {
            controller.forgotPass();
          },
          child: Text(
            AppTexts.forgotPassword,
            style: TextStyle(
              color: AppColors.grey,
              fontFamily: AppDecoration.cairo,
              fontSize: AppDecoration().screenWidth * 0.04,
            ),
          ),
        ),
      ),
    );
  }
}
