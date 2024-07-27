import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/search_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/specializations/specializations_model.dart';

class SearchFilter extends StatelessWidget {
  const SearchFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchCon>(
      builder: (controller) {
        return Align(
          alignment: Alignment.topRight,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: AppDecoration().screenHeight * controller.filteringHeight,
            width: AppDecoration().screenWidth * 0.6,
            color: AppColors.bg,
            padding: const EdgeInsets.all(8),
            child: controller.filteringHeight != 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 7),
                        child: Text(
                          'Speciality Filters',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          itemCount: controller.allSpecializationsList.length,
                          itemBuilder: (context, index) {
                            SpecializationModel specializationModel =
                                SpecializationModel.fromJson(
                                    controller.allSpecializationsList[index]);
                            RxBool checked = controller.specialityFilters
                                .contains(specializationModel.specialization!)
                                .obs;
                            return Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Row(
                                children: [
                                  Obx(
                                    () => Transform.scale(
                                      scale: 0.8,
                                      child: Checkbox(
                                        value: checked.value,
                                        checkColor: AppColors.secondaryColor,
                                        activeColor: AppColors.grey,
                                        onChanged: (_) {
                                          controller.checkFilter(
                                            checked: checked,
                                            specializationModel:
                                                specializationModel,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.checkFilter(
                                        checked: checked,
                                        specializationModel:
                                            specializationModel,
                                      );
                                    },
                                    child: SizedBox(
                                      width: AppDecoration().screenWidth * 0.4,
                                      child: Text(
                                        specializationModel.specialization!,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.blackLighted,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ),
        );
      },
    );
  }
}
