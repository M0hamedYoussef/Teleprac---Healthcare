import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/offers_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class OfferMiddleText extends GetView<OffersController> {
  const OfferMiddleText({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.offerTests.isEmpty) {
      return Text(
        AppTexts.offerProducts,
        style: TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: AppDecoration().screenWidth * 0.06,
        ),
      );
    } else {
      return Text(
        AppTexts.offerTests,
        style: TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: AppDecoration().screenWidth * 0.06,
        ),
      );
    }
  }
}
