import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppTexts.loginScreenWelcome,
        style: TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: AppDecoration().screenWidth * 0.065,
          height: 1.2,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
