import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/doctors/doctor_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class DoctorSpeciality extends GetView<DoctorController> {
  const DoctorSpeciality({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.advancedDoctorModel.doctorDetails!.speciality!.isNotEmpty) {
      return Row(
        children: [
          CachedNetworkImage(
            imageUrl: controller
                .advancedDoctorModel.doctorDetails!.specializationImg!,
            width: AppDecoration().screenWidth * 0.08,
          ),
          SizedBox(width: AppDecoration().screenWidth * 0.02),
          SizedBox(
            width: AppDecoration().screenWidth * 0.5,
            child: GestureDetector(
              onTap: () {
                controller.specializationSelected();
              },
              child: Text(
                controller.advancedDoctorModel.doctorDetails!.speciality!,
                style: const TextStyle(
                  color: AppColors.boldBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
