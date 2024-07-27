import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/main_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/model/specializations/specializations_model.dart';
import 'package:teleprac/routes.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';
import 'package:teleprac/view/widgets/global/custom_container.dart';

class PlanYourSurgery extends StatelessWidget {
  const PlanYourSurgery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomContainer(
        margin: null,
        height: 1,
        children: [
          const UpperPart(
            text: 'Surgery Planning',
          ),
          SizedBox(height: AppDecoration().screenHeight * 0.01),
          Center(
            child: Text(
              AppTexts.planTitle,
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: AppDecoration().screenWidth * .06,
                wordSpacing: 2,
                height: 1.4,
              ),
            ),
          ),
          SizedBox(height: AppDecoration().screenHeight * 0.02),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Text(
              AppTexts.planText,
              style: TextStyle(
                color: AppColors.black.withOpacity(0.8),
                fontWeight: FontWeight.w400,
                fontSize: AppDecoration().screenWidth * .047,
                wordSpacing: 2,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: AppDecoration().screenHeight * 0.02),
          CustomButton(
            text: AppTexts.contactUs,
            buttonColor: AppColors.primaryColor,
            function: () {
              Get.toNamed(
                AppRoutes.contactUs,
              );
            },
          ),
          SizedBox(height: AppDecoration().screenHeight * 0.01),
          Center(
            child: Text(
              AppTexts.orText,
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: AppDecoration().screenWidth * .06,
                wordSpacing: 2,
                height: 1.4,
              ),
            ),
          ),
          SizedBox(height: AppDecoration().screenHeight * 0.01),
          CustomButton(
            text: AppTexts.planButtonText,
            buttonColor: AppColors.primaryColor,
            function: () {
              MainController mainController = Get.find();
              mainController.specializationSelected(
                specializationModel: SpecializationModel.fromJson(
                  {
                    'specialization': 'General Surgery',
                  },
                ),
              );
            },
          ),
          SizedBox(height: AppDecoration().screenHeight * 0.02),
        ],
      ),
    );
  }
}
