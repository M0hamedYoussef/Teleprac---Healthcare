import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/doctors/doctor_controller.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/view/widgets/global/shimmer_placeholder.dart';

class DoctorImage extends GetView<DoctorController> {
  const DoctorImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // border: Border.all(
          // width: 1,
          // color: AppColors.grey,
          // ),
        ),
        width: AppDecoration().screenHeight * 0.12,
        height: AppDecoration().screenHeight * 0.12,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CachedNetworkImage(
            imageUrl:
                controller.advancedDoctorModel.doctorDetails!.profileimage!,
            placeholder: (context, _) {
              return const CustomShimmerPlaceHolder(
                width: 0.12,
                height: 0.12,
                margin: null,
              );
            },
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
