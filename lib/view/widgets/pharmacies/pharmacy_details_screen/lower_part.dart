import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/pharmacies/pharmacies_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';

class LowerPart extends GetView<PharmaciesController> {
  const LowerPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: CustomButton(
        function: () {
          controller.pharmacyProducts(pharmacyModel: controller.pharmacyModel!);
        },
        text: AppTexts.viewProducts,
        buttonColor: AppColors.primaryColor,
        width: 1,
        circularRadius: 10,
      ),
    );
  }
}
