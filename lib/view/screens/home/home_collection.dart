import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/routes.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class HomeCollectionScreen extends StatelessWidget {
  const HomeCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: SafeArea(
        child: Column(
          children: [
            const UpperPart(
              text: 'Home Sample',
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.secondaryColor,
                ),
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(15),
                child: ListView(
                  children: [
                    // SizedBox(height: AppDecoration().screenHeight * 0.01),
                    // Center(
                    //   child: Text(
                    //     'Home Sample Collection',
                    //     style: TextStyle(
                    //       color: AppColors.black,
                    //       fontWeight: FontWeight.w600,
                    //       fontSize: AppDecoration().screenWidth * .06,
                    //       wordSpacing: 2,
                    //       height: 1.4,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: AppDecoration().screenHeight * 0.02),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                      child: Text(
                        AppTexts.homeCollectionText,
                        style: TextStyle(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: AppDecoration().screenWidth * .047,
                          wordSpacing: 2,
                          fontFamily: AppDecoration.cairo,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: AppDecoration().screenHeight * 0.02),
                    CustomButton(
                      text: AppTexts.contactUs,
                      buttonColor: AppColors.primaryColor,
                      function: () {
                        Get.toNamed(
                          AppRoutes.contactUs,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
