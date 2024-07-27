import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class FirstDesignText extends StatelessWidget {
  const FirstDesignText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '${AppTexts.loginText0}\n${AppTexts.loginText1}',
        style: TextStyle(
          color: AppColors.black,
          fontSize: AppDecoration().screenWidth * 0.04,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
