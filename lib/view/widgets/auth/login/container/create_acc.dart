import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/auth/login_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class CreateAccountText extends GetView<LoginCon> {
  const CreateAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppTexts.dontHaveAcc,
          style: TextStyle(
            color: AppColors.grey,
            fontSize: AppDecoration().screenWidth * 0.04,
          ),
        ),
        SizedBox(width: AppDecoration().screenWidth * 0.01),
        GestureDetector(
          onTap: () {
            controller.createAcc();
          },
          child: Text(
            AppTexts.createAcc1,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: AppDecoration().screenWidth * 0.037,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
