import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/account_settings/profile_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/functions/replace.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/custom_text_form_field.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/drop_down.dart';

class SpecializationAndServices extends StatelessWidget {
  const SpecializationAndServices({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Specialization",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            CustomDropDown(
              dropdownList: controller.specializationsList,
              validationText: controller.specializationValidationText,
              value: controller.specialization,
              label: 'Speciality',
              onChanged: (val) {
                controller.specialization = val!;
                controller.update();
              },
            ),
            Column(
              children: [
                if (controller.services.isNotEmpty)
                  SizedBox(
                    width: AppDecoration().screenWidth * 0.9,
                    height: AppDecoration().screenHeight * 0.055,
                    child: ListView.builder(
                      itemCount: controller.services.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return FittedBox(
                          child: GestureDetector(
                            onTap: () {
                              Get.defaultDialog(
                                title: 'Alert',
                                middleText:
                                    'Do You Want To Delete "${controller.services[index]}" ?',
                                titleStyle: TextStyle(
                                  color: AppColors.black,
                                  fontSize: AppDecoration().screenWidth * 0.04,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: AppDecoration.cairo,
                                ),
                                middleTextStyle: TextStyle(
                                  color: AppColors.black,
                                  fontSize: AppDecoration().screenWidth * 0.04,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppDecoration.cairo,
                                ),
                                actions: [
                                  MaterialButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    color: AppColors.primaryColor,
                                    child: Text(
                                      'No',
                                      style: TextStyle(
                                        color: AppColors.secondaryColor,
                                        fontSize:
                                            AppDecoration().screenWidth * 0.04,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: AppDecoration.cairo,
                                      ),
                                    ),
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      controller.services
                                          .remove(controller.services[index]);
                                      controller.servicesString = replace(
                                          text: controller.services,
                                          replace: {
                                            '[': '',
                                            ']': '',
                                          });
                                      controller.update();
                                      Get.back();
                                    },
                                    color: AppColors.primaryColor,
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(
                                        color: AppColors.secondaryColor,
                                        fontSize:
                                            AppDecoration().screenWidth * 0.04,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: AppDecoration.cairo,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(left: 8, right: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.services[index],
                                    style: TextStyle(
                                      color: AppColors.secondaryColor,
                                      fontSize:
                                          AppDecoration().screenWidth * 0.045,
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          AppDecoration().screenWidth * 0.01),
                                  Icon(
                                    Icons.close,
                                    color: AppColors.secondaryColor,
                                    size: AppDecoration().screenWidth * 0.04,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                CustomTextFormField(
                  textEditingController: controller.servicesCon,
                  focusNode: controller.servicesFocus,
                  label: 'Services',
                  onEditingComplete: () {
                    if (controller.servicesCon.text.isNotEmpty) {
                      controller.services.add(controller.servicesCon.text);
                      controller.servicesCon.clear();
                      controller.servicesString =
                          replace(text: controller.services, replace: {
                        '[': '',
                        ']': '',
                      });
                      controller.update();
                    }
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
