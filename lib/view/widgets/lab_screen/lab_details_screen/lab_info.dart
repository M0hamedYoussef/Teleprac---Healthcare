import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/labs/labs_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class LabInfo extends GetView<LabsController> {
  const LabInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.location_on,
              color: AppColors.primaryColor,
            ),
            SizedBox(width: AppDecoration().screenWidth * .01),
            Expanded(
              child: Text(
                controller.advancedLabModel!.fullAddress!,
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: AppDecoration().screenWidth * 0.04,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppDecoration().screenHeight * .01),
        Row(
          children: [
            const Icon(
              Icons.email,
              color: AppColors.primaryColor,
            ),
            SizedBox(width: AppDecoration().screenWidth * .01),
            Expanded(
              child: Text(
                controller.advancedLabModel!.email!,
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: AppDecoration().screenWidth * 0.04,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppDecoration().screenHeight * .01),
        Row(
          children: [
            const Icon(
              Icons.phone,
              color: AppColors.primaryColor,
            ),
            SizedBox(width: AppDecoration().screenWidth * .01),
            Expanded(
              child: Text(
                controller.advancedLabModel!.mobileno!,
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: AppDecoration().screenWidth * 0.04,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
