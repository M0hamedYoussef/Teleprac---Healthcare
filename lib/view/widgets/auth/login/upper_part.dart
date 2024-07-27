import 'package:flutter/material.dart';
import 'package:teleprac/core/const/decoration.dart';

class UpperPart extends StatelessWidget {
  const UpperPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Align(
          //   alignment: Alignment.topRight,
          //   child: Container(
          //     width: AppDecoration().screenWidth * 0.15,
          //     height: AppDecoration().screenHeight * 0.05,
          //     decoration: BoxDecoration(
          //       color: AppColors.greenAccent,
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     child: GestureDetector(
          //       onTap: () {},
          //       child: Center(
          //         child: Text(
          //           AppTexts.loginSkipButton,
          //           style: TextStyle(
          //             color: AppColors.primaryColor,
          //             fontWeight: FontWeight.bold,
          //             fontSize: AppDecoration().screenWidth * 0.035,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Image.asset(
            AppDecoration.appIcon,
            height: AppDecoration().screenHeight * 0.2,
          ),
        ],
      ),
    );
  }
}
