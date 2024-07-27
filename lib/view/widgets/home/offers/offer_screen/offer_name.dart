import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/offers_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class OfferName extends GetView<OffersController> {
  const OfferName({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      controller.offerModel.title!,
      style: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.bold,
        fontFamily: AppDecoration.cairo,
        fontSize: AppDecoration().screenWidth * 0.05,
      ),
      textAlign: TextAlign.center,
    );
  }
}
