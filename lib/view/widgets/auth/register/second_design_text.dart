import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class SecondDesignText extends StatelessWidget {
  const SecondDesignText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
        child: Text(
          AppTexts.privalyPolicyAlert,
          style: TextStyle(
            fontSize: AppDecoration().screenWidth * 0.03,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w400,
            fontFamily: AppDecoration.cairo,
            height: 1,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
