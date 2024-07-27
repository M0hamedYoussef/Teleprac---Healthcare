import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/pharmacies/pharmacies_controller.dart';
import 'package:teleprac/core/const/colors.dart';

class PharmacyNameRow extends GetView<PharmaciesController> {
  const PharmacyNameRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      controller.pharmacyModel!.pharmacyName!,
      style: const TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    );
  }
}
