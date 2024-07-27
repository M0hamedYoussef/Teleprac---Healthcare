import 'dart:io';
import 'package:teleprac/core/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/const/decoration.dart';

Future<bool> exitAlert() {
  Get.defaultDialog(
    title: 'Alert',
    middleText: 'Do You Want To Close The App ?',
    titleStyle: TextStyle(
      color: AppColors.black,
      fontSize: AppDecoration().screenWidth * 0.04,
      fontWeight: FontWeight.bold,
      fontFamily: AppDecoration.cairo,
    ),
    middleTextStyle: TextStyle(
      color: AppColors.black,
      fontSize: AppDecoration().screenWidth * 0.045,
      fontWeight: FontWeight.w500,
      fontFamily: AppDecoration.cairo,
    ),
    actions: [
      MaterialButton(
        onPressed: () {
          Get.back();
        },
        color: AppColors.blue,
        child: Text(
          'No',
          style: TextStyle(
            color: AppColors.secondaryColor,
            fontSize: AppDecoration().screenWidth * 0.04,
            fontWeight: FontWeight.bold,
            fontFamily: AppDecoration.cairo,
          ),
        ),
      ),
      MaterialButton(
        onPressed: () {
          exit(0);
        },
        color: AppColors.blue,
        child: Text(
          'Yes',
          style: TextStyle(
            color: AppColors.secondaryColor,
            fontSize: AppDecoration().screenWidth * 0.04,
            fontWeight: FontWeight.bold,
            fontFamily: AppDecoration.cairo,
          ),
        ),
      ),
    ],
  );
  return Future.value(false);
}
