import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/doctors/doctor_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class DoctorEducation extends GetView<DoctorController> {
  const DoctorEducation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppTexts.education,
          style: TextStyle(
            color: AppColors.grey,
            fontWeight: FontWeight.w500,
            fontFamily: AppDecoration.cairo,
            fontSize: AppDecoration().screenWidth * 0.06,
          ),
        ),
        // Row(
        //   children: [
        //     Image.asset(
        //       AppDecoration.education,
        //       width: AppDecoration().screenWidth * 0.1,
        //     ),
        //     Expanded(
        //       child: Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Text(
        //           AppTexts.education,
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
          controller.advancedDoctorModel.education!.length,
          (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 3,
                    backgroundColor: AppColors.primaryColor,
                  ),
                  SizedBox(
                    width: AppDecoration().screenWidth * 0.025,
                  ),
                  SizedBox(
                    width: AppDecoration().screenWidth * 0.8,
                    child: Text(
                      '${controller.advancedDoctorModel.education![index].degree!} - ${controller.advancedDoctorModel.education![index].institute!}',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w300,
                        fontSize: AppDecoration().screenWidth * 0.04,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
