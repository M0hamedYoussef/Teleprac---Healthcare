import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/main_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class UpperRow extends GetView<MainController> {
  const UpperRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    controller.myServices.sharedPreferences.getString('pfp') ??
                        '',
                    height: AppDecoration().screenHeight * 0.06,
                    width: AppDecoration().screenHeight * 0.06,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox();
                    },
                  ),
                ),
                SizedBox(width: AppDecoration().screenWidth * 0.03),
                Expanded(
                  child: Text(
                    controller.fullName,
                    style: TextStyle(
                      fontFamily: AppDecoration.cairo,
                      fontSize: AppDecoration().screenWidth * 0.045,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              // Container(
              //   height: AppDecoration().screenHeight * 0.05,
              //   width: AppDecoration().screenHeight * 0.05,
              //   margin: const EdgeInsets.fromLTRB(15, 5, 0, 5),
              //   child: Ink(
              //     decoration: BoxDecoration(
              //       color: AppColors.secondaryColor,
              //       border: Border.all(
              //         color: AppColors.greySplash,
              //       ),
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: InkWell(
              //       onTap: () {
              //         controller.notifications();
              //       },
              //       borderRadius: BorderRadius.circular(10),
              //       child: Padding(
              //         padding: const EdgeInsets.all(8),
              //         child: Image.asset(
              //           AppDecoration.bell,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                height: AppDecoration().screenHeight * 0.05,
                width: AppDecoration().screenHeight * 0.05,
                margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: Ink(
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    border: Border.all(
                      color: AppColors.greySplash,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {
                      controller.shoppingCart();
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(
                        AppDecoration.shoppingCart,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
/*

    Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                controller.currentLocation.isEmpty
                    ? 'Unavailable'
                    : controller.currentLocation,
                style: TextStyle(
                  fontSize: AppDecoration().screenWidth * 0.055,
                  color: AppColors.black,
                  fontFamily: AppDecoration.cairo,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                AppTexts.location,
                style: TextStyle(
                  fontSize: AppDecoration().screenWidth * 0.03,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  // controller.notifications();
                },
                child: Image.asset(
                  AppDecoration.bell,
                  width: AppDecoration().screenWidth * 0.08,
                ),
              ),
              SizedBox(
                width: AppDecoration().screenWidth * 0.03,
              ),
              GestureDetector(
                onTap: () {
                  controller.shoppingCart();
                },
                child: Image.asset(
                  AppDecoration.shoppingCart,
                  width: AppDecoration().screenWidth * 0.08,
                ),
              ),
            ],
          ),
        ],
      ),
    );

 */