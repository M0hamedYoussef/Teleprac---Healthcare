import 'package:get/get.dart';
import 'package:teleprac/controller/home/bottom_bar_controller.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:flutter/material.dart';

class HomeBottomBar extends GetView<BottomBarController> {
  const HomeBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDecoration().screenWidth * 0.85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.secondaryColor,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.home,
              color: AppColors.primaryColor,
              size: AppDecoration().screenWidth * 0.09,
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.notificationsScreen();
            },
            child: Icon(
              Icons.notifications,
              color: AppColors.primaryColor,
              size: AppDecoration().screenWidth * 0.09,
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.dashboardScreen();
            },
            child:
                // FittedBox(
                // child: Column(
                // children: [
                // SizedBox(height: AppDecoration().screenHeight * .01),
                Hero(
              tag: AppDecoration.dashboard,
              child: Icon(
                Icons.dashboard,
                color: AppColors.primaryColor,
                size: AppDecoration().screenWidth * 0.09,
              ),
            ),
            // const Text(
            //   AppTexts.dashboard,
            //   textAlign: TextAlign.center,
            // ),
            // ],
            // ),
            // ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     controller.doctor();
          //   },
          //   child:
          //       //  FittedBox(
          //       // child: Column(
          //       // children: [
          //       Image.asset(
          //     AppDecoration.doctor,
          //     width: AppDecoration().screenWidth * 0.1,
          // ),
          // const Text(
          //   AppTexts.doctorLabel,
          //   textAlign: TextAlign.center,
          // ),
          // ],
          // ),
          // ),
          // ),
          // GestureDetector(
          //   onTap: () {
          //     controller.pharmacy();
          //   },
          //   child:
          //       //  FittedBox(
          //       // child: Column(
          //       // children: [
          //       Image.asset(
          //     AppDecoration.medicine,
          //     width: AppDecoration().screenWidth * 0.1,
          //   ),
          // const Text(
          //   AppTexts.pharmacyLabel,
          //   textAlign: TextAlign.center,
          // ),
          // ],
          // ),
          // ),
          // ),
          // GestureDetector(
          // onTap: () {
          //   controller.labTest();
          // },
          // child:
          //     //  FittedBox(
          //     // child: Column(
          //     // children: [
          //     Image.asset(
          //   AppDecoration.flask,
          //   width: AppDecoration().screenWidth * 0.1,
          // ),
          // const Text(
          //   AppTexts.labTestsLabel,
          //   textAlign: TextAlign.center,
          // ),
          // ],
          // ),
          // ),
          // ),
          GestureDetector(
            onTap: () {
              controller.account();
            },
            child:
                //  FittedBox(
                // child: Column(
                // children: [
                Hero(
              tag: AppDecoration.account,
              child: Icon(
                Icons.person,
                color: AppColors.primaryColor,
                size: AppDecoration().screenWidth * 0.09,
              ),
            ),
            // const Text(
            //   AppTexts.accountLabel,
            //   textAlign: TextAlign.center,
            // ),
            // ],
            // ),
            // ),
          ),
        ],
      ),
    );
  }
}

/*
Container(
      color: AppColors.lightGreenSecond,
      height: AppDecoration().screenHeight * 0.08,
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              controller.dashboardScreen();
            },
            child: FittedBox(
              child: Column(
                children: [
                  SizedBox(height: AppDecoration().screenHeight * .01),
                  Hero(
                    tag: AppDecoration.dashboard,
                    child: Image.asset(
                      AppDecoration.dashboard,
                      width: AppDecoration().screenWidth * 0.08,
                    ),
                  ),
                  const Text(
                    AppTexts.dashboard,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.doctor();
            },
            child: FittedBox(
              child: Column(
                children: [
                  Image.asset(
                    AppDecoration.doctor,
                    width: AppDecoration().screenWidth * 0.1,
                  ),
                  const Text(
                    AppTexts.doctorLabel,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.pharmacy();
            },
            child: FittedBox(
              child: Column(
                children: [
                  Image.asset(
                    AppDecoration.medicine,
                    width: AppDecoration().screenWidth * 0.1,
                  ),
                  const Text(
                    AppTexts.pharmacyLabel,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.labTest();
            },
            child: FittedBox(
              child: Column(
                children: [
                  Image.asset(
                    AppDecoration.flask,
                    width: AppDecoration().screenWidth * 0.1,
                  ),
                  const Text(
                    AppTexts.labTestsLabel,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.account();
            },
            child: FittedBox(
              child: Column(
                children: [
                  Hero(
                    tag: AppDecoration.account,
                    child: Image.asset(
                      AppDecoration.account,
                      width: AppDecoration().screenWidth * 0.1,
                    ),
                  ),
                  const Text(
                    AppTexts.accountLabel,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

 */