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
        AppTexts.forgotPassText0,
        style: TextStyle(
          fontSize: AppDecoration().screenWidth * 0.076,
          color: AppColors.black,
          fontWeight: FontWeight.w400,
          fontFamily: AppDecoration.cairo,
          height: 1.2,
        ),
      ),
    );
  }
}
