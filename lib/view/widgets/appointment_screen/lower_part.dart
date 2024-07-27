import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class LowerPart extends StatelessWidget {
  const LowerPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                color: AppColors.red,
                width: AppDecoration().screenWidth * 0.05,
                height: AppDecoration().screenWidth * 0.05,
              ),
              SizedBox(width: AppDecoration().screenWidth * 0.01),
              const Text(
                AppTexts.alreadyBooked,
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Row(
            children: [
              Container(
                color: AppColors.primaryColor,
                width: AppDecoration().screenWidth * 0.05,
                height: AppDecoration().screenWidth * 0.05,
              ),
              SizedBox(width: AppDecoration().screenWidth * 0.01),
              const Text(
                AppTexts.availableSlots,
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
