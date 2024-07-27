import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/doctors/doctor_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class DoctorServices extends GetView<DoctorController> {
  const DoctorServices({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.advancedDoctorModel.doctorDetails!.services != null &&
        controller.advancedDoctorModel.doctorDetails!.services!.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTexts.services,
            style: TextStyle(
              color: AppColors.grey,
              fontWeight: FontWeight.w500,
              fontFamily: AppDecoration.cairo,
              fontSize: AppDecoration().screenWidth * 0.06,
            ),
          ),
          // const DottedLine(),
          // Row(
          //   children: [
          //     Image.asset(
          //       AppDecoration.checkUp,
          //       width: AppDecoration().screenWidth * 0.1,
          //     ),
          //     Expanded(
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Text(
          //           AppTexts.services,
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
          ...List.generate(
              controller.advancedDoctorModel.doctorDetails!.services!
                  .split(',')
                  .length, (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: AppDecoration().screenWidth * 0.8,
                child: Row(
                  children: [
                    // const Icon(Icons.check),
                    // SizedBox(width: AppDecoration().screenWidth * 0.01),
                    const CircleAvatar(
                      radius: 3,
                      backgroundColor: AppColors.primaryColor,
                    ),
                    SizedBox(
                      width: AppDecoration().screenWidth * .025,
                    ),
                    Expanded(
                      child: Text(
                        controller.advancedDoctorModel.doctorDetails!.services!
                            .split(',')[index],
                        style: TextStyle(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w300,
                          fontFamily: AppDecoration.cairo,
                          fontSize: AppDecoration().screenWidth * 0.045,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          })
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
