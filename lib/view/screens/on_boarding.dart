import 'package:teleprac/controller/onboarding_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/view/widgets/onboarding/pagebuilder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnBoardingCon());
    return const Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: CustomPageBuilder(),
    );
  }
}
