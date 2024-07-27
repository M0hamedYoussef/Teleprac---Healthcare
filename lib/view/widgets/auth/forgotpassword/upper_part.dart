import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/auth/forgot_password_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class UpperPart extends GetView<ForgotPassCon> {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    controller.willPop();
                  },
                  icon: const Icon(
                    CupertinoIcons.back,
                    color: AppColors.secondaryColor,
                    size: 50,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppDecoration().screenHeight * 0.04),
          Center(
            child: Text(
              AppTexts.forgotPass,
              style: TextStyle(
                fontSize: AppDecoration().screenWidth * 0.087,
                color: AppColors.secondaryColor,
                fontWeight: FontWeight.bold,
                fontFamily: AppDecoration.cairo,
                height: 1.2,
              ),
            ),
          ),
          SizedBox(height: AppDecoration().screenHeight * 0.06),
        ],
      ),
    );
  }
}
