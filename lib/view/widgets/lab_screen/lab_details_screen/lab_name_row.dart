import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/labs/labs_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class LabNameRow extends GetView<LabsController> {
  const LabNameRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Text(
        controller.advancedLabModel!.fullName!,
        style: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.w500,
          fontFamily: AppDecoration.cairo,
          fontSize: AppDecoration().screenWidth * 0.06,
        ),
      ),
    );
  }
}
