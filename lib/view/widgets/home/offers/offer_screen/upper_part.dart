import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

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
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  SystemChrome.setSystemUIOverlayStyle(
                    const SystemUiOverlayStyle(
                      statusBarColor: AppColors.lightGrey1,
                      statusBarIconBrightness: Brightness.light,
                    ),
                  );

                  Get.back();
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
                AppTexts.offerScreen,
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
