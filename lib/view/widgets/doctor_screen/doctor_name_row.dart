import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/doctors/doctor_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class DoctorName extends GetView<DoctorController> {
  const DoctorName({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: SizedBox(
        width: AppDecoration().screenWidth * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.advancedDoctorModel.doctorDetails!.fullName!,
              style: TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.w600,
                fontFamily: AppDecoration.cairo,
                fontSize: AppDecoration().screenWidth * 0.05,
              ),
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.004),
            Text(
              controller.advancedDoctorModel.doctorDetails!.speciality!,
              style: TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.w400,
                fontFamily: AppDecoration.cairo,
                fontSize: AppDecoration().screenWidth * 0.042,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/**
 *  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            controller.advancedDoctorModel.doctorDetails!.fullName!,
            style: const TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.addToFavourites();
          },
          child: GetBuilder<DoctorController>(
            builder: (_) {
              return Icon(
                controller.isFavourite
                    ? Icons.favorite_sharp
                    : Icons.favorite_outline_sharp,
                color: controller.isFavourite ? AppColors.red : null,
              );
            },
          ),
        ),
      ],
    );
 */