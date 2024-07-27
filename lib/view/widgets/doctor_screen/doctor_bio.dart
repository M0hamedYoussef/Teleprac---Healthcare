import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/doctors/doctor_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class DoctorBio extends GetView<DoctorController> {
  const DoctorBio({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.advancedDoctorModel.doctorDetails!.biography != null &&
        controller.advancedDoctorModel.doctorDetails!.biography!.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTexts.about,
            style: TextStyle(
              color: AppColors.grey,
              fontWeight: FontWeight.w500,
              fontFamily: AppDecoration.cairo,
              fontSize: AppDecoration().screenWidth * 0.06,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              controller.advancedDoctorModel.doctorDetails!.biography!,
              style: TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.w300,
                fontSize: AppDecoration().screenWidth * 0.04,
              ),
            ),
          ),
          // Row(
          //   children: [
          //     Image.asset(
          //       AppDecoration.info,
          //       width: AppDecoration().screenWidth * 0.1,
          //     ),
          //     Expanded(
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Text(
          //           AppTexts.about,
          //           style: TextStyle(
          //             color: AppColors.black,
          //             fontWeight: FontWeight.bold,
          //             fontSize: AppDecoration().screenWidth * 0.07,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20),
          //   child: Text(
          //     controller.advancedDoctorModel.doctorDetails!.biography!,
          //     style: const TextStyle(
          //       color: AppColors.black,
          //       fontWeight: FontWeight.w500,
          //       fontSize: 18,
          //       height: 1.4,
          //     ),
          //   ),
          // ),
          // SizedBox(height: AppDecoration().screenHeight * 0.01),
          // const DottedLine(),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
