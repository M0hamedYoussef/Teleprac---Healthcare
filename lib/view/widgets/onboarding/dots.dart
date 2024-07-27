import 'package:teleprac/controller/onboarding_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/const/on_boarding_data.dart';

class DotsOnBoarding extends GetView<OnBoardingCon> {
  const DotsOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          onBoardingData.length,
          (index) {
            return GestureDetector(
              onTap: () {
                controller.dotsCon(index: index);
              },
              child: GetBuilder<OnBoardingCon>(
                builder: (controller) => AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  decoration: BoxDecoration(
                    color: controller.currentPageIndex == index
                        ? AppColors.primaryColor
                        : AppColors.primaryColor.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(right: 4),
                  width: controller.currentPageIndex == index ? 15 : 6,
                  height: 6,
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
