import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/global/download_controller.dart';
import 'package:teleprac/controller/home/dashboard/my_patients/patient_profile/medical_history_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/home/dashboard/medical_history_model.dart';
import 'package:teleprac/view/widgets/global/user_image.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class MedicalHistoryList extends StatelessWidget {
  const MedicalHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    DownloadController downloadController = Get.put(DownloadController());
    return GetBuilder<MedicalHistoryController>(
      builder: (controller) {
        return Expanded(
          child: ListView.builder(
            itemCount: controller.medicalHistory.length,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            itemBuilder: (context, index) {
              MedicalHistoryItemModel medicalHistoryItemModel =
                  MedicalHistoryItemModel.fromJson(
                controller.medicalHistory.reversed.toList()[index],
              );
              if (medicalHistoryItemModel.id != null) {
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          UserImage(
                            image:
                                medicalHistoryItemModel.patientImage.toString(),
                            withGradient: false,
                            circularRadius: 10,
                            scale: 0.7,
                            padding: const EdgeInsets.only(left: 8),
                          ),
                          SizedBox(
                            width: AppDecoration().screenWidth * 0.5,
                            child: Text(
                              medicalHistoryItemModel.patientName!,
                              style: TextStyle(
                                fontSize: AppDecoration().screenWidth * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          (medicalHistoryItemModel.doctorName!.isNotEmpty &&
                                  medicalHistoryItemModel
                                      .specialization!.isNotEmpty)
                              ? 'Doctor:'
                              : 'Added By Patient',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: AppDecoration().screenWidth * 0.04,
                          ),
                        ),
                      ),
                      if (!(medicalHistoryItemModel.doctorName!.isNotEmpty &&
                          medicalHistoryItemModel.specialization!.isNotEmpty))
                        SizedBox(height: AppDecoration().screenHeight * 0.01),
                      if (medicalHistoryItemModel.doctorName!.isNotEmpty &&
                          medicalHistoryItemModel.specialization!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25, top: 8, bottom: 2),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: medicalHistoryItemModel.doctorName!,
                                  style: TextStyle(
                                    fontSize:
                                        AppDecoration().screenWidth * 0.05,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (medicalHistoryItemModel.doctorName!.isNotEmpty &&
                          medicalHistoryItemModel.specialization!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 25, bottom: 8),
                          child: Text(
                            '(${medicalHistoryItemModel.specialization!})',
                            style: TextStyle(
                              fontSize: AppDecoration().screenWidth * 0.04,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blue,
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Description:',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: AppDecoration().screenWidth * 0.04,
                          ),
                        ),
                      ),
                      SizedBox(height: AppDecoration().screenHeight * 0.01),
                      Row(
                        children: [
                          SizedBox(width: AppDecoration().screenWidth * 0.1),
                          SizedBox(
                            width: AppDecoration().screenWidth * 0.7,
                            child: HtmlWidget(
                              medicalHistoryItemModel.description!,
                            ),
                          ),
                        ],
                      ),
                      if (medicalHistoryItemModel.filename
                          .toString()
                          .replaceAll('null', '')
                          .isNotEmpty)
                        SizedBox(height: AppDecoration().screenHeight * 0.01),
                      if (medicalHistoryItemModel.filename
                          .toString()
                          .replaceAll('null', '')
                          .isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Attachments:',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: AppDecoration().screenWidth * 0.04,
                            ),
                          ),
                        ),
                      SizedBox(height: AppDecoration().screenHeight * 0.01),
                      if (medicalHistoryItemModel.filename
                          .toString()
                          .replaceAll('null', '')
                          .isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth: AppDecoration().screenWidth * 0.6,
                                ),
                                child: Text(
                                  medicalHistoryItemModel.filename!
                                              .split('/')
                                              .last
                                              .length >
                                          20
                                      ? medicalHistoryItemModel.filename!
                                          .split('/')
                                          .last
                                          .replaceRange(
                                              20,
                                              medicalHistoryItemModel.filename!
                                                  .split('/')
                                                  .last
                                                  .length,
                                              '...')
                                      : medicalHistoryItemModel.filename!
                                          .split('/')
                                          .last,
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize:
                                        AppDecoration().screenWidth * 0.045,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  downloadController.downloadFile(
                                    url: medicalHistoryItemModel.filename!,
                                  );
                                },
                                child: const Icon(
                                  Icons.attachment_outlined,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (medicalHistoryItemModel.filename
                          .toString()
                          .replaceAll('null', '')
                          .isNotEmpty)
                        SizedBox(height: AppDecoration().screenHeight * 0.01),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.date_range,
                              color: AppColors.primaryColor,
                              size: AppDecoration().screenWidth * 0.05,
                            ),
                            SizedBox(width: AppDecoration().screenWidth * 0.01),
                            SizedBox(
                              width: AppDecoration().screenWidth * 0.4,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Date: ',
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            AppDecoration().screenWidth * 0.04,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          medicalHistoryItemModel.createdDate!,
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            AppDecoration().screenWidth * 0.04,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        );
      },
    );
  }
}
