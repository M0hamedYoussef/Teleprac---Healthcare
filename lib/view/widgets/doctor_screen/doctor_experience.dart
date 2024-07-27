import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/doctors/doctor_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class DoctorExperience extends GetView<DoctorController> {
  const DoctorExperience({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.advancedDoctorModel.experience != null &&
        controller.advancedDoctorModel.experience!.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTexts.experience,
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
          //       AppDecoration.work,
          //       width: AppDecoration().screenWidth * 0.1,
          //     ),
          //     Expanded(
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Text(
          //           AppTexts.experience,
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
            controller.advancedDoctorModel.experience!.length,
            (index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 3,
                          backgroundColor: AppColors.primaryColor,
                        ),
                        SizedBox(
                          width: AppDecoration().screenWidth * .025,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: AppDecoration().screenWidth * .5,
                              child: Text(
                                controller.advancedDoctorModel
                                    .experience![index].designation!,
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.w300,
                                  fontSize: AppDecoration().screenWidth * 0.045,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: AppDecoration().screenWidth * .3,
                              child: Text(
                                '${controller.advancedDoctorModel.experience![index].from!}-${controller.advancedDoctorModel.experience![index].to!}',
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.w300,
                                  fontSize: AppDecoration().screenWidth * 0.04,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppDecoration().screenHeight * .01,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 3,
                            backgroundColor: AppColors.grey,
                          ),
                          SizedBox(
                            width: AppDecoration().screenWidth * .025,
                          ),
                          SizedBox(
                            width: AppDecoration().screenWidth * .45,
                            child: Text(
                              controller.advancedDoctorModel.experience![index]
                                  .hospitalName!,
                              style: TextStyle(
                                color: AppColors.grey,
                                fontWeight: FontWeight.w300,
                                fontSize: AppDecoration().screenWidth * 0.04,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
