import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/routes.dart';

class UpperPart extends StatelessWidget {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    CupertinoIcons.back,
                    color: AppColors.secondaryColor,
                    size: 40,
                  ),
                ),
                Text(
                  AppTexts.myProducts,
                  style: TextStyle(
                    fontSize: AppDecoration().screenWidth * 0.07,
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppDecoration.cairo,
                    height: 2.2,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                Get.toNamed(AppRoutes.addProductScreen);
              },
              icon: const Icon(
                CupertinoIcons.add,
                color: AppColors.secondaryColor,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
