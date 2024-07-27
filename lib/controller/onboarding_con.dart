import 'package:teleprac/core/const/on_boarding_data.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingCon extends GetxController {
  MyServices myServices = Get.find();
  PageController pageController = PageController();
  int currentPageIndex = 0;

  onPageChanged({required int index}) {
    currentPageIndex = index;
    update();
  }

  nextPage() {
    if (currentPageIndex != onBoardingData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    } else if (currentPageIndex == onBoardingData.length - 1) {
      Get.toNamed(AppRoutes.login);
    }
  }

  skip() {
    pageController.animateToPage(
      onBoardingData.length,
      duration: const Duration(milliseconds: 700),
      curve: Curves.linear,
    );
  }

  dotsCon({required index}) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
    update();
  }

  createAccount() {
    Get.toNamed(AppRoutes.register);
  }

  signIn() {
    Get.toNamed(AppRoutes.login);
  }
}
