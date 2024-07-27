import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/account_settings/account_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class WelcomeText extends GetView<AccountController> {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppTexts.welcomeText + controller.fullName,
        style: TextStyle(
          fontSize: AppDecoration().screenWidth * 0.05,
          color: AppColors.black,
          fontFamily: AppDecoration.cairo,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
