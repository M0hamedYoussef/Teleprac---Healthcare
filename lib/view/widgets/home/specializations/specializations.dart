import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/main_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/model/specializations/specializations_model.dart';
import 'package:teleprac/view/widgets/global/shimmer_placeholder.dart';
import 'package:teleprac/view/widgets/home/specializations/specialization_container.dart';

class Specializations extends GetView<MainController> {
  const Specializations({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppTexts.specializationText,
                style: TextStyle(
                  fontSize: AppDecoration().screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppDecoration.cairo,
                  color: AppColors.grey,
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: () {
                  controller.seeAllSpecializations();
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    AppTexts.seeAll,
                    style: TextStyle(
                      color: AppColors.grey,
                      fontFamily: AppDecoration.cairo,
                      fontSize: AppDecoration().screenWidth * 0.04,
                    ),
                  ),
                ),
              ),
              // CustomButton(
              //   function: controller.seeAllSpecializations,
              //   opacity: 0.45,
              //   margin: null,
              //   textColor: AppColors.black,
              //   fontSize: 12,
              //   height: 0.03,
              //   text: AppTexts.seeAll,
              // ),
            ],
          ),
          SizedBox(
            height: AppDecoration().screenHeight * 0.02,
          ),
          SizedBox(
            height: AppDecoration().screenHeight * 0.12,
            child: GetBuilder<MainController>(
              builder: (_) {
                if (controller.commonSpecializationsList.isEmpty) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return CustomShimmerPlaceHolder(
                        height: 0.12,
                        width: 0.12,
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemCount: controller.commonSpecializationsList.length,
                    itemBuilder: (context, index) {
                      SpecializationModel specializationModel =
                          SpecializationModel.fromJson(
                        controller.commonSpecializationsList[index],
                      );

                      return SpecializationContainer(
                        specializationModel: specializationModel,
                        selected: () {
                          controller.specializationSelected(
                            specializationModel: specializationModel,
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
          SizedBox(
            height: AppDecoration().screenHeight * 0.01,
          ),
        ],
      ),
    );
  }
}
