import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class UpperPart extends StatelessWidget {
  const UpperPart({
    super.key,
    required this.text,
    this.changeStatusbarColor = false,
    this.statusBarColor = AppColors.lightGrey1,
    this.customBackFunction,
    this.customBarColor = AppColors.greyDesign,
    this.trFunction,
    this.trIcon,
    this.trText,
    this.trIconColor = AppColors.grey,
  });
  final String text;
  final bool changeStatusbarColor;
  final Color statusBarColor;
  final Color customBarColor;
  final Function? customBackFunction;
  final Function? trFunction;
  final IconData? trIcon;
  final String? trText;
  final Color? trIconColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDecoration().screenWidth,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: AppDecoration().screenHeight * 0.05,
                width: AppDecoration().screenHeight * 0.05,
                margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.greySplash,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  onTap: () {
                    if (customBackFunction == null) {
                      Get.back();
                    } else {
                      customBackFunction!();
                    }
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppColors.grey,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: AppDecoration().screenWidth * 0.07,
                  color: AppColors.grey,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppDecoration.cairo,
                  height: 2.2,
                ),
              ),
            ),
            if (trIcon != null)
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: AppDecoration().screenHeight * 0.05,
                  width: AppDecoration().screenHeight * 0.05,
                  margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.greySplash,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {
                      trFunction!();
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Icon(
                      trIcon,
                      color: trIconColor,
                    ),
                  ),
                ),
              ),
            if (trText != null)
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: AppDecoration().screenHeight * 0.05,
                  width: AppDecoration().screenHeight * 0.05,
                  margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        trFunction!();
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Center(
                        child: Text(
                          trText!,
                          style: const TextStyle(
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/*
Container(
      decoration: BoxDecoration(
        // gradient: AppColors.mainLinarGradient,
        color: customBarColor,
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
                  if (customBackFunction == null) {
                    if (changeStatusbarColor) {
                      SystemChrome.setSystemUIOverlayStyle(
                        SystemUiOverlayStyle(
                          statusBarColor: statusBarColor,
                          statusBarIconBrightness: Brightness.light,
                        ),
                      );
                    }
                    Get.back();
                  } else {
                    customBackFunction!();
                  }
                },
                icon: Icon(
                  CupertinoIcons.back,
                  color: AppColors.secondaryColor,
                  size: AppDecoration().screenWidth * 0.1,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: AppDecoration().screenWidth * 0.075,
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
 */