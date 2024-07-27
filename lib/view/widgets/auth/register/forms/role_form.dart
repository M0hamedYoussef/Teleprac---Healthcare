import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/auth/register_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/model/global/drop_down_model.dart';

class RoleForm extends GetView<RegisterCon> {
  const RoleForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            height: AppDecoration().screenHeight * 0.07,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              // color: AppColors.lightGreen,
            ),
            child: Column(
              // Row(
              children: [
                // SizedBox(width: AppDecoration().screenWidth * 0.01),
                // Image.asset(
                //   AppDecoration.admin,
                //   height: AppDecoration().screenHeight * 0.035,
                // ),
                // SizedBox(width: AppDecoration().screenWidth * 0.02),
                Expanded(
                  child: GetBuilder<RegisterCon>(
                    builder: (_) {
                      return DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: const Text(
                            AppTexts.roleLabel,
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 15,
                            ),
                          ),
                          items: [
                            ...List.generate(
                              controller.roles.length,
                              (index) {
                                DropDownItemModel dropDownItemModel =
                                    DropDownItemModel.fromJson(
                                  controller.roles[index],
                                );
                                return DropdownMenuItem<String>(
                                  value: dropDownItemModel.value!,
                                  child: Text(
                                    dropDownItemModel.label!,
                                    style: TextStyle(
                                      fontSize:
                                          AppDecoration().screenWidth * 0.04,
                                      fontWeight: FontWeight.bold,
                                      color: controller.role ==
                                              dropDownItemModel.value!
                                          ? AppColors.black
                                          : AppColors.black.withOpacity(0.5),
                                    ),
                                  ),
                                );
                              },
                            ),
                            // DropdownMenuItem<String>(
                            //   value: '1',
                            //   child: Text(
                            //     'Doctor',
                            //     style: TextStyle(
                            //       fontSize: 14,
                            //       fontWeight: FontWeight.bold,
                            //       color: controller.role == '1'
                            //           ? AppColors.darkGreen
                            //           : AppColors.black,
                            //     ),
                            //   ),
                            // ),
                            // DropdownMenuItem<String>(
                            //   value: '2',
                            //   child: Text(
                            //     'Patient',
                            //     style: TextStyle(
                            //       fontSize: 14,
                            //       fontWeight: FontWeight.bold,
                            //       color: controller.role == '2'
                            //           ? AppColors.darkGreen
                            //           : AppColors.black,
                            //     ),
                            //   ),
                            // ),
                            // DropdownMenuItem<String>(
                            //   value: '4',
                            //   child: Text(
                            //     'Lab',
                            //     style: TextStyle(
                            //       fontSize: 14,
                            //       fontWeight: FontWeight.bold,
                            //       color: controller.role == '4'
                            //           ? AppColors.grey
                            //           : AppColors.black,
                            //     ),
                            //   ),
                            // ),
                            // DropdownMenuItem<String>(
                            //   value: '5',
                            //   child: Text(
                            //     'Pharmacy',
                            //     style: TextStyle(
                            //       fontSize: 14,
                            //       fontWeight: FontWeight.bold,
                            //       color: controller.role == '5'
                            //           ? AppColors.grey
                            //           : AppColors.black,
                            //     ),
                            //   ),
                            // ),
                            // DropdownMenuItem<String>(
                            //   value: '6',
                            //   child: Text(
                            //     'Clinic',
                            //     style: TextStyle(
                            //       fontSize: 14,
                            //       fontWeight: FontWeight.bold,
                            //       color: controller.role == '6'
                            //           ? AppColors.grey
                            //           : AppColors.black,
                            //     ),
                            //   ),
                            // ),
                            // DropdownMenuItem<String>(
                            //   value: '7',
                            //   child: Text(
                            //     'Nurse',
                            //     style: TextStyle(
                            //       fontSize: 14,
                            //       fontWeight: FontWeight.bold,
                            //       color: controller.role == '7'
                            //           ? AppColors.grey
                            //           : AppColors.black,
                            //     ),
                            //   ),
                            // ),
                          ],
                          value: controller.role == '' ? null : controller.role,
                          onChanged: (String? value) {
                            controller.role = value!;
                            controller.update();
                          },
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down,
                            ),
                            iconSize: 25,
                            iconEnabledColor: AppColors.grey,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            width: AppDecoration().screenWidth,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: AppColors.secondaryColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Divider(
                  color: AppColors.grey,
                  thickness: 0.7,
                ),
              ],
            ),
          ),
          GetBuilder<RegisterCon>(
            builder: (_) {
              return Text(
                controller.roleValidationText,
                style: const TextStyle(
                  color: AppColors.red,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
