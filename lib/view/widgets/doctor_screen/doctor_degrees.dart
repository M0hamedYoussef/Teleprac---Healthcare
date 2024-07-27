import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/doctors/doctor_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class DoctorDegreesWithRating extends GetView<DoctorController> {
  const DoctorDegreesWithRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Degrees',
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
            controller.advancedDoctorModel.educationDegrees!.toString(),
            style: TextStyle(
              color: AppColors.grey,
              fontWeight: FontWeight.w300,
              fontSize: AppDecoration().screenWidth * 0.04,
            ),
          ),
        ),
      ],
    );
  }
}

/**
 *  if (controller.advancedDoctorModel.registrations != null &&
            controller.advancedDoctorModel.registrations!.isNotEmpty)
          Text(
            'Reg. No. ${controller.advancedDoctorModel.registrations![0].registrations!}',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w500,
              fontFamily: AppDecoration.cairo,
              fontSize: AppDecoration().screenWidth * 0.06,
            ),
          ),
 */
/**
 *  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                controller.advancedDoctorModel.educationDegrees!.toString(),
                style: const TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: AppColors.amber,
                      size: 28,
                    ),
                    Text(
                      '${controller.advancedDoctorModel.doctorDetails!.ratingValue!}(${controller.advancedDoctorModel.doctorDetails!.ratingCount!})',
                      style: const TextStyle(
                        color: AppColors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppDecoration().screenHeight * .005),
        if (controller.advancedDoctorModel.registrations != null &&
            controller.advancedDoctorModel.registrations!.isNotEmpty)
          Text(
            'Reg. No. ${controller.advancedDoctorModel.registrations![0].registrations!}',
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        SizedBox(height: AppDecoration().screenHeight * .01),
        const DottedLine(),
 */
