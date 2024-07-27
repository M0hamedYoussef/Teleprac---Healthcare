import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/texts.dart';

class SecondDesignText extends StatelessWidget {
  const SecondDesignText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        AppTexts.forgotPassText1,
        style: TextStyle(
          fontSize: 16,
          color: AppColors.black,
        ),
      ),
    );
  }
}
