import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/pharmacies/pharmacies_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/pharmacies/pharmacies_list.dart';
import 'package:teleprac/view/widgets/pharmacies/search_bar.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class PharmaciesScreen extends StatelessWidget {
  const PharmaciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PharmaciesController controller = Get.find();
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: WillPopScope(
        onWillPop: controller.pharmacyClosed,
        child: SafeArea(
          child: Column(
            children: [
              UpperPart(
                text: AppTexts.onlinePharmacyLabel,
                customBackFunction: controller.pharmacyClosed,
              ),
              SizedBox(height: AppDecoration().screenHeight * 0.02),
              const PharmaciesSearchBar(),
              SizedBox(height: AppDecoration().screenHeight * 0.02),
              const PharmaciesList(),
            ],
          ),
        ),
      ),
    );
  }
}
