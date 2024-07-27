import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/labs/labs_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class LabBio extends GetView<LabsController> {
  const LabBio({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.advancedLabModel!.biography != null &&
        controller.advancedLabModel!.biography!.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Text(
              AppTexts.aboutLab,
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w400,
                fontFamily: AppDecoration.cairo,
                fontSize: AppDecoration().screenWidth * 0.07,
              ),
            ),
          ),
          // Row(
          //   children: [
          //     Image.asset(
          //       AppDecoration.info,
          //       width: AppDecoration().screenWidth * 0.1,
          //     ),
          //     Expanded(
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Text(
          //           AppTexts.aboutLab,
          //           style: TextStyle(
          //             color: AppColors.black,
          //             fontWeight: FontWeight.bold,
          //             fontSize: AppDecoration().screenWidth * 0.07,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              controller.advancedLabModel!.biography!,
              style: TextStyle(
                color: AppColors.black.withOpacity(0.8),
                fontWeight: FontWeight.w100,
                fontFamily: AppDecoration.cairo,
                wordSpacing: 1.2,
                fontSize: AppDecoration().screenWidth * 0.045,
              ),
            ),
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
