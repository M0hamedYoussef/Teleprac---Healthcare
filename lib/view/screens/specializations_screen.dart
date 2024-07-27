import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/specializations_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';
import 'package:teleprac/view/widgets/specializations_screen/specializations_list.dart';

class SpecialzationsScreen extends StatelessWidget {
  const SpecialzationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SpecializationsController());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: ListView(
        children: [
          const UpperPart(
            text: AppTexts.specializationsTitle,
            changeStatusbarColor: true,
          ),
          SizedBox(height: AppDecoration().screenHeight * 0.01),
          const SpecializationsList(),
        ],
      ),
    );
  }
}
