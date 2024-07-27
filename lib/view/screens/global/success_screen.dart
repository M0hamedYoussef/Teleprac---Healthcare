import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:teleprac/controller/global/success_screen_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SuccessScreenCon controller = Get.put(SuccessScreenCon());
    if (controller.centerText == null) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppDecoration.bg_0),
              fit: BoxFit.fill,
            ),
          ),
          width: AppDecoration().screenWidth,
          height: AppDecoration().screenHeight,
          child: Column(
            children: [
              SizedBox(height: AppDecoration().screenHeight * 0.2),
              Center(
                child: Lottie.asset(
                  AppDecoration.check,
                  width: AppDecoration().screenWidth * .9,
                  frameRate: FrameRate(90),
                ),
              ),
              const Spacer(),
              CustomButton(
                function: controller.function,
                text: controller.buttonText,
                width: 1,
              ),
              SizedBox(height: AppDecoration().screenHeight * 0.05),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppDecoration.bg_0),
              fit: BoxFit.fill,
            ),
          ),
          width: AppDecoration().screenWidth,
          height: AppDecoration().screenHeight,
          child: Column(
            children: [
              SizedBox(height: AppDecoration().screenHeight * 0.1),
              Lottie.asset(
                AppDecoration.check,
                width: AppDecoration().screenWidth * .9,
                frameRate: FrameRate(90),
              ),
              SizedBox(
                width: AppDecoration().screenWidth,
                child: Text(
                  controller.centerText!,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: AppDecoration().screenWidth * 0.05,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              CustomButton(
                function: controller.function,
                text: controller.buttonText,
                width: 1,
              ),
              SizedBox(height: AppDecoration().screenHeight * 0.05),
            ],
          ),
        ),
      );
    }
  }
}
