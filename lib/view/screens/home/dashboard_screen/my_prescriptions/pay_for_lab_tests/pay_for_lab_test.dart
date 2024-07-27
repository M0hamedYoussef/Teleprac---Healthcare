import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard/pay_for_lab_test/recommended_tests_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/model/home/dashboard/recommended_test_model.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';
import 'package:teleprac/view/widgets/global/user_image.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PayForLabTests extends StatelessWidget {
  const PayForLabTests({super.key});

  @override
  Widget build(BuildContext context) {
    PayForLabTestsController controller = Get.put(PayForLabTestsController());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: SafeArea(
        child: Column(
          children: [
            const UpperPart(
              text: AppTexts.myPrescriptions,
            ),
            SizedBox(
              height: AppDecoration().screenHeight * 0.02,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.recommendedTests.length,
                physics:
                    const BouncingScrollPhysics(parent: PageScrollPhysics()),
                itemBuilder: (context, index) {
                  RecommendedTestModel recommendedTestModel =
                      RecommendedTestModel.fromJson(
                    controller.recommendedTests.reversed.toList()[index],
                  );

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.secondaryColor,
                    ),
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            UserImage(
                              image: recommendedTestModel.doctorImage!,
                              withGradient: false,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Lab Test ID#${recommendedTestModel.id}',
                                    style: TextStyle(
                                      fontSize:
                                          AppDecoration().screenWidth * 0.04,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          AppDecoration().screenHeight * 0.01),
                                  SizedBox(
                                      width: AppDecoration().screenWidth * 0.4,
                                      child: const DottedLine()),
                                  SizedBox(
                                      height:
                                          AppDecoration().screenHeight * 0.01),
                                  SizedBox(
                                    width: AppDecoration().screenWidth * 0.5,
                                    child: Text(
                                      recommendedTestModel.doctorName!,
                                      style: TextStyle(
                                        fontSize:
                                            AppDecoration().screenWidth * 0.05,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: AppDecoration().screenHeight * 0.01,
                                  ),
                                  SizedBox(
                                    width: AppDecoration().screenWidth * 0.5,
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Test Date: ',
                                            style: TextStyle(
                                              fontSize:
                                                  AppDecoration().screenWidth *
                                                      0.035,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: recommendedTestModel
                                                .createdDate,
                                            style: TextStyle(
                                              fontSize:
                                                  AppDecoration().screenWidth *
                                                      0.035,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.blue,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: AppDecoration().screenHeight * 0.01,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (recommendedTestModel.labtestDetails!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 2),
                            child: Column(
                              children: [
                                CustomButton(
                                  buttonColor: AppColors.primaryColor,
                                  text: 'View',
                                  margin: const EdgeInsets.only(
                                    right: 10,
                                    bottom: 10,
                                  ),
                                  function: () {
                                    controller.viewTest(
                                      recommendedTestModel : recommendedTestModel,
                                    );
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: CustomButton(
                                        buttonColor: AppColors.primaryColor,
                                        text: 'Download',
                                        margin: null,
                                        function: () async {
                                          await launchUrlString(
                                            recommendedTestModel.pdfLink!,
                                          );
                                        },
                                      ),
                                    ),
                                    if (recommendedTestModel
                                        .labtestDetails!.isNotEmpty)
                                      Expanded(
                                        flex: 2,
                                        child: CustomButton(
                                          buttonColor: AppColors.primaryColor,
                                          text: recommendedTestModel
                                                          .labtestDetails![0]
                                                          .price
                                                          .toString() !=
                                                      '0' &&
                                                  recommendedTestModel
                                                          .labtestDetails![0]
                                                          .price
                                                          .toString() !=
                                                      'null' &&
                                                  recommendedTestModel
                                                      .labtestDetails![0].price
                                                      .toString()
                                                      .isNotEmpty
                                              ? 'Pay Now'
                                              : 'Awaiting Approval',
                                          margin: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                          ),
                                          function: () {
                                            if (recommendedTestModel
                                                        .labtestDetails![0]
                                                        .price
                                                        .toString() !=
                                                    '0' &&
                                                recommendedTestModel
                                                        .labtestDetails![0]
                                                        .price
                                                        .toString() !=
                                                    'null' &&
                                                recommendedTestModel
                                                    .labtestDetails![0].price
                                                    .toString()
                                                    .isNotEmpty) {
                                              controller.payNow(
                                                recommendedTestModel: recommendedTestModel,
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
