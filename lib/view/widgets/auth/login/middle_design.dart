import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class MiddleDesign extends StatelessWidget {
  const MiddleDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 40,
        right: 40,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Image.asset(
                AppDecoration.doctorIcon,
                height: AppDecoration().screenHeight * 0.07,
              ),
              Text(
                AppTexts.doctorImage,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: AppDecoration().screenWidth * 0.05,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Image.asset(
                AppDecoration.medicineIcon,
                height: AppDecoration().screenHeight * 0.07,
              ),
              Text(
                AppTexts.medicineImage,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: AppDecoration().screenWidth * 0.05,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Image.asset(
                AppDecoration.labIcon1,
                height: AppDecoration().screenHeight * 0.07,
              ),
              Text(
                AppTexts.labImage,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: AppDecoration().screenWidth * 0.05,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
