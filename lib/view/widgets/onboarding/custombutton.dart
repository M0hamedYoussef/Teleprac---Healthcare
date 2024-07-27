import 'package:teleprac/controller/onboarding_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/const/decoration.dart';

class CustomButtonOnBoarding extends GetView<OnBoardingCon> {
  const CustomButtonOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
      child: SizedBox(
        height: AppDecoration().screenHeight * 0.06,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: AppColors.secondaryColor,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            controller.nextPage();
          },
          child: GetBuilder<OnBoardingCon>(
            builder: (controller) => Text(
              controller.currentPageIndex == 0 ? 'Get Started' : 'Continue',
              style: const TextStyle(color: AppColors.secondaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
