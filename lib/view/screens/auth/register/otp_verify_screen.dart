import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/view/widgets/auth/register/otp_screen/otp_form.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: AppDecoration().screenHeight * 0.02),
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
                    Get.back();
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppColors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.01),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
              ),
              child: Text(
                'Verify OTP',
                style: TextStyle(
                  color: AppColors.grey,
                  fontFamily: AppDecoration.cairo,
                  fontSize: AppDecoration().screenWidth * 0.08,
                ),
              ),
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.02),
            const VerifyOtpForm(),
          ],
        ),
      ),
    );
  }
}
