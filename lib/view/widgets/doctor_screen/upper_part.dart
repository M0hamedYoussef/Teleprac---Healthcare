import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/controller/doctors/doctor_controller.dart';

class UpperPart extends GetView<DoctorController> {
  const UpperPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.mainLinarGradient,
      ),
      width: AppDecoration().screenWidth,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  controller.willPop();
                },
                icon: Icon(
                  CupertinoIcons.back,
                  color: AppColors.secondaryColor,
                  size: AppDecoration().screenWidth * 0.087,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                AppTexts.doctorProfile,
                style: TextStyle(
                  fontSize: AppDecoration().screenWidth * 0.076,
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppDecoration.cairo,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
