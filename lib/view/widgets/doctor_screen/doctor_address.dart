import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/doctors/doctor_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class DoctorAddress extends GetView<DoctorController> {
  const DoctorAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Address',
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
            controller.advancedDoctorModel.doctorDetails!.fullAddress!,
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

/** Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(
          Icons.location_on,
          color: AppColors.primaryColor,
        ),
        Expanded(
          flex: 0,
          child: Text(
            controller.advancedDoctorModel.doctorDetails!.fullAddress!,
            style: const TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ),
      ],
    ); */