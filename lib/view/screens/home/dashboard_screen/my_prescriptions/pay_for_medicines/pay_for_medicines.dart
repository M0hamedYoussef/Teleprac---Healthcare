import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard/my_prescriptions_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/model/home/dashboard/prescriptions/prescriprtion_model.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';
import 'package:teleprac/view/widgets/global/user_image.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PayForMedicines extends StatelessWidget {
  const PayForMedicines({super.key});

  @override
  Widget build(BuildContext context) {
    MyPrescriptionsController controller = Get.put(MyPrescriptionsController());
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
                itemCount: controller.myPrescriptions.length,
                physics:
                    const BouncingScrollPhysics(parent: PageScrollPhysics()),
                itemBuilder: (context, index) {
                  PrescriptionModel prescriptionModel =
                      PrescriptionModel.fromJson(
                    controller.myPrescriptions.reversed.toList()[index],
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
                              image: prescriptionModel.doctorImage!,
                              withGradient: false,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Prescription PCN#${prescriptionModel.id}',
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
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: prescriptionModel.doctorName!,
                                            style: TextStyle(
                                              fontSize:
                                                  AppDecoration().screenWidth *
                                                      0.05,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                ' (${prescriptionModel.specialization!})',
                                            style: TextStyle(
                                              fontSize:
                                                  AppDecoration().screenWidth *
                                                      0.04,
                                              fontWeight: FontWeight.bold,
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
                                  SizedBox(
                                    width: AppDecoration().screenWidth * 0.5,
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Prescription Date: ',
                                            style: TextStyle(
                                              fontSize:
                                                  AppDecoration().screenWidth *
                                                      0.035,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: prescriptionModel.createdDate,
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: CustomButton(
                                  buttonColor: AppColors.primaryColor,
                                  text: 'Download',
                                  margin: null,
                                  function: () async {
                                    await launchUrlString(
                                      prescriptionModel.pdfLink!,
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: CustomButton(
                                  buttonColor: AppColors.primaryColor,
                                  text: prescriptionModel
                                                  .prescriptionDetails![0].price
                                                  .toString() !=
                                              '0' &&
                                          prescriptionModel
                                                  .prescriptionDetails![0].price
                                                  .toString() !=
                                              'null' &&
                                          prescriptionModel
                                              .prescriptionDetails![0].price
                                              .toString()
                                              .isNotEmpty
                                      ? 'Pay Now'
                                      : 'Awaiting Approval',
                                  margin: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                  ),
                                  function: () {
                                    if (prescriptionModel
                                                .prescriptionDetails![0].price
                                                .toString() !=
                                            '0' &&
                                        prescriptionModel
                                                .prescriptionDetails![0].price
                                                .toString() !=
                                            'null' &&
                                        prescriptionModel
                                            .prescriptionDetails![0].price
                                            .toString()
                                            .isNotEmpty) {
                                      controller.payNow(
                                        prescriptionModel: prescriptionModel,
                                      );
                                    }
                                  },
                                ),
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
