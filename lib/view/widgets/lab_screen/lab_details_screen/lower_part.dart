import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/labs/labs_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';

class LowerPart extends GetView<LabsController> {
  const LowerPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: CustomButton(
        function: controller.bookTest,
        text: AppTexts.bookTests,
        fontSize: 0.04,
        buttonColor: AppColors.primaryColor,
        circularRadius: 10,
      ),
    );
  }
}
