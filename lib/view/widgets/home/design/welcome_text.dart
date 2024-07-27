import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/main_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class WelcomeText extends GetView<MainController> {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
          ),
          child: Text(
            controller.myRole! == '1'
                ? '${AppTexts.welcomeText}Dr. ${controller.fullName}'
                : AppTexts.welcomeText + controller.fullName,
            style: const TextStyle(
              fontSize: 20,
              color: AppColors.black,
              fontFamily: AppDecoration.cairo,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          width: AppDecoration().screenWidth,
          child: const Text(
            'LOOKING FOR A DOCTOR, DIAGNOSTIC TEST OR MEDICINE?',
            style: TextStyle(
              fontSize: 17,
              color: AppColors.black,
              fontFamily: AppDecoration.cairo,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: AppDecoration().screenWidth,
          child: const Text(
            'It\'s all here! Search for the best doctors, quality medicines, accurate diagnostic in your city or across the country.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.black,
              fontFamily: AppDecoration.cairo,
              fontWeight: FontWeight.w400,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
