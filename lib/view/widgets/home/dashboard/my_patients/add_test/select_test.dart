import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard/my_patients/patient_profile/patient_profile_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/global/drop_down_model.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/custom_text_form_field.dart';

class SelectTest extends StatelessWidget {
  const SelectTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDecoration().screenHeight * 0.07,
      width: AppDecoration().screenHeight * 0.8,
      padding: const EdgeInsets.only(left: 20, right: 20),
      // decoration: BoxDecoration(
      //   color: AppColors.lightGreen,
      //   borderRadius: BorderRadius.circular(14),
      // ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              TextEditingController testNameCon = TextEditingController();
              Get.bottomSheet(
                GetBuilder<PatientProfileController>(
                  builder: (controller) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25),
                        ),
                      ),
                      height: AppDecoration().screenHeight * 0.5,
                      child: Column(
                        children: [
                          SizedBox(
                            height: AppDecoration().screenHeight * 0.01,
                          ),
                          CustomTextFormField(
                            textEditingController: testNameCon,
                            label: 'Search Test',
                            oldDesign: false,
                            onChanged: (val) {
                              controller.update();
                            },
                          ),
                          Expanded(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              itemCount: controller.allTests.length,
                              itemBuilder: (context, index) {
                                DropDownItemModel dropDownItemModel =
                                    DropDownItemModel.fromJson(
                                  controller.allTests[index],
                                );
                                if (dropDownItemModel.label
                                    .toString()
                                    .toLowerCase()
                                    .replaceAll('_', '')
                                    .replaceAll('-', '')
                                    .replaceAll('|', '')
                                    .replaceAll('(', '')
                                    .replaceAll(')', '')
                                    .replaceAll('@', '')
                                    .replaceAll(' x ', '')
                                    .removeAllWhitespace
                                    .contains(
                                      testNameCon.text
                                          .toLowerCase()
                                          .replaceAll('_', '')
                                          .replaceAll('-', '')
                                          .replaceAll('|', '')
                                          .replaceAll('(', '')
                                          .replaceAll(')', '')
                                          .replaceAll('@', '')
                                          .replaceAll(' x ', '')
                                          .removeAllWhitespace,
                                    )) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    child: ListTile(
                                      onTap: () {
                                        Get.back();
                                        controller.tests.add(
                                          {
                                            'test_name':
                                                dropDownItemModel.label!,
                                            'prep_before_test': '',
                                            'time': '',
                                          },
                                        );
                                        controller.update();
                                      },
                                      title: Text(
                                        dropDownItemModel.label!,
                                      ),
                                    ),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
            child: Row(
              children: const [
                Expanded(
                  child: Text(
                    'Select Test',
                    style: TextStyle(
                      color: AppColors.grey,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_up,
                  color: AppColors.grey,
                ),
              ],
            ),
          ),
          const Divider(
            color: AppColors.black,
            thickness: 0.3,
          ),
        ],
      ),
    );
  }
}
