import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/labs/tests_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/model/labs/tests/advanced_test_model.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/global/custom_container.dart';
import 'package:teleprac/view/widgets/global/user_image.dart';
import 'package:teleprac/view/widgets/lab_screen/tests_screen/test_details_screen/test_info.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class TestCheckoutScreen extends StatelessWidget {
  const TestCheckoutScreen({
    super.key,
    required this.advancedTestModel,
  });
  final AdvancedTestModel advancedTestModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<TestsController>(
          builder: (controller) {
            int homeSampleTaxes = controller.homeSample == '1' ? 100 : 0;
            int totalPrice = (homeSampleTaxes +
                    double.parse(advancedTestModel.testDetails!.amount!))
                .round();
            return Column(
              children: [
                const UpperPart(
                  text: AppTexts.checkout,
                ),
                Expanded(
                  child: CustomContainer(
                    margin: const EdgeInsets.only(left: 8, right: 8),
                    height: 1,
                    children: [
                      UserImage(
                        image: advancedTestModel.labDetails!.profileimage!,
                        height: 0.3,
                        width: 0.3,
                        withGradient: false,
                        circularRadius: 10,
                      ),
                      SizedBox(height: AppDecoration().screenHeight * .02),
                      TestInfo(
                        advancedTestModel: advancedTestModel,
                      ),
                      SizedBox(height: AppDecoration().screenHeight * .015),
                      RadioListTile(
                        title: Text(
                          'Without Home  Sample',
                          style: TextStyle(
                            fontSize: AppDecoration().screenWidth * 0.04,
                            fontWeight: controller.homeSample == '0'
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                        value: '0',
                        activeColor: AppColors.primaryColor,
                        groupValue: controller.homeSample,
                        onChanged: (value) {
                          controller.homeSample = value!;
                          controller.update();
                        },
                      ),
                      RadioListTile(
                        title: Text(
                          'With Home Sample',
                          style: TextStyle(
                            fontSize: AppDecoration().screenWidth * 0.04,
                            fontWeight: controller.homeSample == '1'
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                        activeColor: AppColors.primaryColor,
                        value: '1',
                        groupValue: controller.homeSample,
                        onChanged: (value) {
                          controller.homeSample = value!;
                          controller.update();
                        },
                      ),
                      SizedBox(height: AppDecoration().screenHeight * .005),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: AppDecoration().screenWidth * 0.6,
                            ),
                            child: Text(
                              'Home Sample Taxes : ${AppTexts.indianRupee} $homeSampleTaxes',
                              style: TextStyle(
                                fontSize: AppDecoration().screenWidth * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          if (advancedTestModel.testDetails!.discount == '0' ||
                              advancedTestModel.testDetails!.discount == null ||
                              advancedTestModel.testDetails!.discount!.isEmpty)
                            SizedBox(
                              width: AppDecoration().screenWidth * 0.5,
                              child: Text(
                                'Test Price : ${AppTexts.indianRupee} ${advancedTestModel.testDetails!.amount}',
                                style: TextStyle(
                                  fontSize: AppDecoration().screenWidth * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          if (advancedTestModel.testDetails!.discount != '0' &&
                              advancedTestModel.testDetails!.discount != null &&
                              advancedTestModel
                                  .testDetails!.discount!.isNotEmpty)
                            Row(
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        AppDecoration().screenWidth * 0.45,
                                  ),
                                  child: Text(
                                    'Test Price : ${AppTexts.indianRupee} ',
                                    style: TextStyle(
                                      fontSize:
                                          AppDecoration().screenWidth * 0.045,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth: AppDecoration().screenWidth * 0.2,
                                    maxHeight:
                                        AppDecoration().screenHeight * 0.03,
                                  ),
                                  child: Text(
                                    advancedTestModel.testDetails!.mrp!,
                                    style: TextStyle(
                                      fontSize:
                                          AppDecoration().screenWidth * 0.03,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.lineThrough,
                                      decorationThickness: 2.5,
                                      height: 0.5,
                                    ),
                                  ),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth: AppDecoration().screenWidth * 0.3,
                                    maxHeight:
                                        AppDecoration().screenHeight * 0.03,
                                  ),
                                  child: Text(
                                    advancedTestModel.testDetails!.amount!,
                                    style: TextStyle(
                                      fontSize:
                                          AppDecoration().screenWidth * 0.05,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: AppDecoration().screenWidth * 0.6,
                            ),
                            child: Text(
                              'Total Price : ${AppTexts.indianRupee} $totalPrice',
                              style: TextStyle(
                                fontSize: AppDecoration().screenWidth * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomButton(
                        function: () {
                          controller.bookTest(
                            advancedTestModel: advancedTestModel,
                            context: context,
                          );
                        },
                        text: 'Checkout',
                        fontSize: 0.045,
                        buttonColor: AppColors.primaryColor,
                        circularRadius: 10,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
