import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard/my_patients/patient_profile/patient_profile_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/custom_text_form_field.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';
import 'package:teleprac/view/widgets/home/dashboard/my_patients/add_test/select_test.dart';
import 'package:teleprac/view/widgets/home/dashboard/my_patients/add_test/test_times.dart';

class AddTestScreen extends StatelessWidget {
  const AddTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PatientProfileController controller = Get.find();
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: WillPopScope(
        onWillPop: controller.addTestScreenWillPop,
        child: SafeArea(
          child: Column(
            children: [
              UpperPart(
                text: AppTexts.addTest,
                customBackFunction: controller.addTestScreenWillPop,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.secondaryColor,
                  ),
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(15),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: AppDecoration().screenHeight * 0.02,
                      ),
                      CustomTextFormField(
                        textEditingController: controller.chiefComplaintsCon,
                        focusNode: controller.chiefComplaintsFocus,
                        nextFocusNode: controller.heightFocus,
                        label: 'Chief Complaints',
                        startingHeight: 0.1,
                        oldDesign: false,
                        maxLines: null,
                      ),
                      SizedBox(
                        height: AppDecoration().screenHeight * 0.02,
                      ),
                      const SelectTest(),
                      SizedBox(
                        height: AppDecoration().screenHeight * 0.02,
                      ),
                      GetBuilder<PatientProfileController>(
                        builder: (_) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Add Test",
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            AppDecoration().screenWidth * 0.055,
                                        fontFamily: AppDecoration.cairo,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.tests.add(
                                          {
                                            'test_name': '',
                                            'prep_before_test': '',
                                            'time': '',
                                          },
                                        );
                                        controller.update();
                                      },
                                      child: const Icon(
                                        Icons.add,
                                        color: AppColors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ...List.generate(
                                controller.tests.length,
                                (index) {
                                  TextEditingController typeCon =
                                      TextEditingController();
                                  FocusNode typeFocus = FocusNode();
                                  TextEditingController testNameCon =
                                      TextEditingController(
                                          text: controller.tests[index]
                                              ['test_name']);
                                  FocusNode testNameFocus = FocusNode();
                                  TextEditingController testPreprationCon =
                                      TextEditingController(
                                          text: controller.tests[index]
                                              ['prep_before_test']);
                                  FocusNode testPreprationFocus = FocusNode();

                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          controller.tests
                                              .remove(controller.tests[index]);
                                          controller.update();
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.close,
                                            color: AppColors.grey,
                                          ),
                                        ),
                                      ),
                                      CustomTextFormField(
                                        textEditingController: testNameCon,
                                        focusNode: testNameFocus,
                                        nextFocusNode: testPreprationFocus,
                                        oldDesign: false,
                                        label: 'Test Name',
                                        onChanged: (val) {
                                          controller.tests[index]['test_name'] =
                                              testNameCon.text.trim();
                                        },
                                      ),
                                      SizedBox(
                                        height:
                                            AppDecoration().screenHeight * .02,
                                      ),
                                      CustomTextFormField(
                                        textEditingController:
                                            testPreprationCon,
                                        focusNode: testPreprationFocus,
                                        oldDesign: false,
                                        nextFocusNode: typeFocus,
                                        label: 'Test Prepration',
                                        onChanged: (val) {
                                          controller.tests[index]
                                                  ['prep_before_test'] =
                                              testNameCon.text.trim();
                                        },
                                      ),
                                      SizedBox(
                                        height:
                                            AppDecoration().screenHeight * .02,
                                      ),
                                      if (controller
                                          .tests[index]['time'].isNotEmpty)
                                        TestTimes(index: index),
                                      CustomTextFormField(
                                        textEditingController: typeCon,
                                        focusNode: typeFocus,
                                        oldDesign: false,
                                        label:
                                            'Time (morning , noon , evening , night)',
                                        onEditingComplete: () {
                                          if (typeCon.text.isNotEmpty) {
                                            if (typeCon.text.removeAllWhitespace
                                                    .toLowerCase()
                                                    .contains('morning') ||
                                                typeCon.text.removeAllWhitespace
                                                    .toLowerCase()
                                                    .contains('noon') ||
                                                typeCon.text.removeAllWhitespace
                                                    .toLowerCase()
                                                    .contains('evening') ||
                                                typeCon.text.removeAllWhitespace
                                                    .toLowerCase()
                                                    .contains('night')) {
                                              if (controller.tests[index]
                                                      ['time']
                                                  .toString()
                                                  .isNotEmpty) {
                                                if (!controller.tests[index]
                                                        ['time']
                                                    .toString()
                                                    .contains(typeCon
                                                        .text.capitalizeFirst!
                                                        .trim())) {
                                                  controller.tests[index]
                                                          ['time'] =
                                                      controller.tests[index]
                                                              ['time'] +
                                                          ',' +
                                                          typeCon.text
                                                              .capitalizeFirst!
                                                              .trim();
                                                } else {
                                                  Get.defaultDialog(
                                                      middleText:
                                                          'Already Added');
                                                }
                                              } else {
                                                controller.tests[index]
                                                        ['time'] =
                                                    typeCon
                                                        .text.capitalizeFirst!
                                                        .trim();
                                              }
                                              typeCon.clear();
                                              controller.update();
                                            } else {
                                              Get.defaultDialog(
                                                  middleText:
                                                      'You can only add \n "morning , noon , evening , night"');
                                            }
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height:
                                            AppDecoration().screenHeight * .02,
                                      ),
                                      const Divider(
                                        thickness: 0.5,
                                        color: AppColors.primaryColor,
                                      ),
                                      SizedBox(
                                        height:
                                            AppDecoration().screenHeight * .02,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: AppDecoration().screenHeight * .03,
                      ),
                      CustomButton(
                        function: controller.addTest,
                        text: AppTexts.addTest,
                        buttonColor: AppColors.primaryColor,
                        margin: const EdgeInsets.only(left: 8, right: 8),
                        circularRadius: 10,
                      ),
                      SizedBox(
                        height: AppDecoration().screenHeight * 0.04,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
