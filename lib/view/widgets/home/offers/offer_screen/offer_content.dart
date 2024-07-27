import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/offers_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:teleprac/core/const/decoration.dart';

class OfferContent extends GetView<OffersController> {
  const OfferContent({super.key});

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      controller.offerModel.contant!,
      textStyle: TextStyle(
        color: AppColors.black.withOpacity(0.8),
        fontWeight: FontWeight.w300,
        fontFamily: AppDecoration.cairo,
        fontSize: AppDecoration().screenWidth * 0.05,
        wordSpacing: 1.2,
      ),
    );
    // return Text(
    //   controller.offerModel.contant!,
    //   style: const TextStyle(
    //     color: AppColors.black,
    //     fontWeight: FontWeight.w400,
    //     fontSize: 20,
    //     height: 1.5,
    //   ),
    // );
  }
}
