import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/auth/register_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class UpperPart extends GetView<RegisterCon> {
  const UpperPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
        color: AppColors.lightGreenSecond,
      ),
      child: Column(
        children: [
          SizedBox(height: AppDecoration().screenHeight * 0.02),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  controller.willPop();
                },
                icon: const Icon(
                  CupertinoIcons.back,
                  color: AppColors.secondaryColor,
                  size: 38,
                ),
              ),
              SizedBox(width: AppDecoration().screenWidth * 0.05),
              const Icon(
                Icons.person_add_alt_1,
                color: AppColors.secondaryColor,
                size: 30,
              ),
              const Text(
                AppTexts.createAcc0,
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppDecoration.cairo,
                  height: 2,
                ),
              ),
            ],
          ),
          SizedBox(height: AppDecoration().screenHeight * 0.02),
        ],
      ),
    );
  }
}
