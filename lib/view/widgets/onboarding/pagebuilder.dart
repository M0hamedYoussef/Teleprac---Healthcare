import 'package:teleprac/controller/onboarding_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/const/on_boarding_data.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/onboarding/custombutton.dart';
import 'package:teleprac/view/widgets/onboarding/dots.dart';

class CustomPageBuilder extends StatelessWidget {
  const CustomPageBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingCon>(
      builder: (controller) {
        return Stack(
          children: [
            PageView.builder(
              onPageChanged: (index) {
                controller.onPageChanged(index: index);
              },
              controller: controller.pageController,
              itemCount: onBoardingData.length,
              itemBuilder: (context, index) {
                if (index == onBoardingData.length - 1) {
                  return Column(
                    children: [
                      SizedBox(
                        height: AppDecoration().screenHeight * .2,
                      ),
                      Image.asset(
                        onBoardingData[index].image!,
                        height: AppDecoration().screenHeight * 0.2,
                        fit: BoxFit.fill,
                      ),
                      Center(
                        child: Text(
                          onBoardingData[index].title!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.grey,
                            fontFamily: AppDecoration.cairo,
                            fontSize: AppDecoration().screenWidth * 0.05,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: AppDecoration().screenHeight * .07,
                      ),
                      Center(
                        child: Text(
                          onBoardingData[index].body!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.grey,
                            fontFamily: AppDecoration.cairo,
                            fontSize: AppDecoration().screenWidth * 0.07,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: AppDecoration().screenHeight * .07,
                      ),
                      CustomButton(
                        function: () {
                          controller.createAccount();
                        },
                        buttonColor: AppColors.primaryColor,
                        circularRadius: 10,
                        height: 0.06,
                        width: 0.8,
                        text: 'Create account',
                      ),
                      SizedBox(
                        height: AppDecoration().screenHeight * .03,
                      ),
                      CustomButton(
                        function: () {
                          controller.signIn();
                        },
                        buttonColor: AppColors.secondaryColor,
                        textColor: AppColors.primaryColor,
                        circularRadius: 10,
                        height: 0.06,
                        width: 0.8,
                        elevation: 0,
                        text: 'Sign in',
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      SizedBox(
                        height: AppDecoration().screenHeight * .02,
                      ),
                      Image.asset(
                        onBoardingData[index].image!,
                        fit: BoxFit.cover,
                      ),
                    ],
                  );
                }
              },
            ),
            if (controller.currentPageIndex != onBoardingData.length - 1)
              Positioned(
                width: AppDecoration().screenWidth,
                top: AppDecoration().screenHeight * 0.57,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  // height: AppDecoration().screenHeight * 0.35,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: AppDecoration().screenHeight * .02,
                      ),
                      Center(
                        child: Text(
                          onBoardingData[controller.currentPageIndex].title!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppDecoration().screenWidth * 0.05,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: AppDecoration().screenHeight * .005,
                      ),
                      Container(
                        height: AppDecoration().screenHeight * 0.17,
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        child: Center(
                          child: Text(
                            onBoardingData[controller.currentPageIndex].body!,
                            style: TextStyle(
                              fontSize: AppDecoration().screenWidth * 0.045,
                              fontFamily: AppDecoration.cairo,
                              fontWeight: FontWeight.w700,
                              color: AppColors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppDecoration().screenHeight * .01,
                      ),
                      const DotsOnBoarding(),
                      SizedBox(
                        height: AppDecoration().screenHeight * .04,
                      ),
                      const CustomButtonOnBoarding(),
                      SizedBox(
                        height: AppDecoration().screenHeight * .005,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            controller.skip();
                          },
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              fontSize: AppDecoration().screenWidth * 0.035,
                              fontFamily: AppDecoration.cairo,
                              fontWeight: FontWeight.w700,
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppDecoration().screenHeight * .02,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
