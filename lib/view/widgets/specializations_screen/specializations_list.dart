import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/specializations_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/specializations/specializations_model.dart';
import 'package:teleprac/view/widgets/home/specializations/specialization_container.dart';

class SpecializationsList extends StatelessWidget {
  const SpecializationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: GetBuilder<SpecializationsController>(
        builder: (controller) {
          return SizedBox(
            height: AppDecoration().screenHeight * 0.88,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
              ),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemCount: controller.specializationsList.length,
              itemBuilder: (context, index) {
                SpecializationModel specializationModel =
                    SpecializationModel.fromJson(
                        controller.specializationsList[index]);

                return Column(
                  children: [
                    SpecializationContainer(
                      specializationModel: specializationModel,
                      selected: () {
                        controller.specializationSelected(
                          specializationModel: specializationModel,
                        );
                      },
                    ),
                    Text(
                      specializationModel.specialization!.length > 15
                          ? specializationModel.specialization!.replaceRange(12,
                              specializationModel.specialization!.length, '...')
                          : specializationModel.specialization!,
                      style: TextStyle(
                        fontSize: AppDecoration().screenWidth * 0.033,
                        color: AppColors.black,
                        fontFamily: AppDecoration.cairo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
