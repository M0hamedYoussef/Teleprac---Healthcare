import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

loading() {
  Get.defaultDialog(
    title: '',
    middleText: '',
    contentPadding: const EdgeInsets.only(bottom: 20),
    backgroundColor: AppColors.secondaryColor,
    content: Center(
      child: Lottie.asset(
        AppDecoration.loading,
        width: AppDecoration().screenWidth * .4,
        frameRate: FrameRate(90),
      ),
    ),
    onWillPop: () {
      return Future.value(false);
    },
  );
}
