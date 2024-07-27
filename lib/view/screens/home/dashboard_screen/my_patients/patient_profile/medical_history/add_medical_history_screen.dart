import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard/my_patients/patient_profile/medical_history_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/custom_text_form_field.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class AddMedicalHistoryScreen extends GetView<MedicalHistoryController> {
  const AddMedicalHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: WillPopScope(
        onWillPop: controller.addScreenWillPop,
        child: SafeArea(
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            children: [
              UpperPart(
                text: AppTexts.addMedicalHistory,
                customBackFunction: controller.addScreenWillPop,
              ),
              SizedBox(height: AppDecoration().screenHeight * 0.04),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.secondaryColor,
                ),
                margin: const EdgeInsets.only(left: 20, right: 20),
                height: AppDecoration().screenHeight * 0.5,
                child: GetBuilder<MedicalHistoryController>(
                  builder: (_) {
                    return Column(
                      children: [
                        CustomTextFormField(
                          textEditingController: controller.descriptionCon,
                          label: 'Description',
                          startingHeight: 0.2,
                          maxHeight: 0.7,
                          maxLines: null,
                        ),
                        SizedBox(height: AppDecoration().screenHeight * 0.02),
                        SizedBox(
                          height: AppDecoration().screenHeight * 0.04,
                          child: controller.medicalHistoryFile != null
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.check_circle_rounded,
                                            color: AppColors.primaryColor,
                                          ),
                                          SizedBox(
                                              width:
                                                  AppDecoration().screenWidth *
                                                      0.02),
                                          Container(
                                            constraints: BoxConstraints(
                                              maxWidth:
                                                  AppDecoration().screenWidth *
                                                      0.6,
                                            ),
                                            child: Text(
                                              'File Selected',
                                              style: TextStyle(
                                                color: AppColors.primaryColor,
                                                fontSize: AppDecoration()
                                                        .screenWidth *
                                                    0.045,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controller.medicalHistoryFile = null;
                                          controller.update();
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: AppColors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : null,
                        ),
                        SizedBox(height: AppDecoration().screenHeight * 0.15),
                        CustomButton(
                          circularRadius: 10,
                          text: 'Upload Medical History File',
                          buttonColor: AppColors.primaryColor,
                          function: () {
                            controller.chooseMedicalHistoryFile();
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: AppDecoration().screenHeight * 0.25),
              CustomButton(
                circularRadius: 10,
                text: 'Confirm',
                buttonColor: AppColors.primaryColor,
                function: () {
                  controller.uploadMedicalHistory();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
