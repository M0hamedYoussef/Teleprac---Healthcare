import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/routes.dart';

class SurgeryGradientContainer extends StatelessWidget {
  const SurgeryGradientContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: GestureDetector(
        onTap: () {
          Get.toNamed(
            AppRoutes.planYourSurgery,
          );
        },
        child: Container(
          width: AppDecoration().screenWidth,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.greenAccent, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppTexts.planTitle,
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: AppDecoration().screenWidth * 0.06,
                        fontFamily: AppDecoration.cairo,
                        wordSpacing: 2,
                        height: 0.4,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.primaryColor,
                      ),
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                      child: Text(
                        AppTexts.planNow,
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: AppDecoration().screenWidth * 0.03,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
