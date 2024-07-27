import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/pharmacies/pharmacies_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class PharmacyInfo extends GetView<PharmaciesController> {
  const PharmacyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (controller.pharmacyModel!.address1!.isNotEmpty)
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: AppColors.primaryColor,
              ),
              SizedBox(width: AppDecoration().screenWidth * .01),
              Expanded(
                flex: 0,
                child: Text(
                  controller.pharmacyModel!.address1!,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        SizedBox(height: AppDecoration().screenHeight * .01),
        if (controller.pharmacyModel!.address2!.isNotEmpty)
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: AppColors.primaryColor,
              ),
              SizedBox(width: AppDecoration().screenWidth * .01),
              Expanded(
                flex: 0,
                child: Text(
                  controller.pharmacyModel!.address2!,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        SizedBox(height: AppDecoration().screenHeight * .01),
        Row(
          children: [
            const Icon(
              Icons.location_on,
              color: AppColors.primaryColor,
            ),
            SizedBox(width: AppDecoration().screenWidth * .01),
            Expanded(
              flex: 0,
              child: Text(
                '${controller.pharmacyModel!.city!}, ${controller.pharmacyModel!.country!}',
                style: const TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppDecoration().screenHeight * .01),
        Row(
          children: [
            const Icon(
              Icons.watch_later_outlined,
              color: AppColors.primaryColor,
            ),
            SizedBox(width: AppDecoration().screenWidth * .01),
            Expanded(
              flex: 0,
              child: Text(
                'Opens At: ${controller.pharmacyModel!.pharmacyOpensAt!}',
                style: const TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppDecoration().screenHeight * .01),
        Row(
          children: [
            const Icon(
              Icons.phone,
              color: AppColors.primaryColor,
            ),
            SizedBox(width: AppDecoration().screenWidth * .01),
            Expanded(
              flex: 0,
              child: Text(
                '+91 ${controller.pharmacyModel!.mobileno!}',
                style: const TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
