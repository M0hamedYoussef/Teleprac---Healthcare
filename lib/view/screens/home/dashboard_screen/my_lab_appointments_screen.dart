import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:teleprac/controller/global/download_controller.dart';
import 'package:teleprac/controller/home/dashboard/my_lab_appointments_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/model/home/dashboard/appointment/lab_appointment_model.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class MyLabAppointmentsScreen extends StatelessWidget {
  const MyLabAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyLabAppointmentsController controller =
        Get.put(MyLabAppointmentsController());
    DownloadController downloadController = Get.put(DownloadController());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: SafeArea(
        child: Column(
          children: [
            const UpperPart(
              text: AppTexts.labReports,
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.02),
            Expanded(
              child: ListView.builder(
                itemCount: controller.myLabAppointments.length,
                physics:
                    const BouncingScrollPhysics(parent: PageScrollPhysics()),
                itemBuilder: (context, index) {
                  LabAppointmentModel labAppointmentModel =
                      LabAppointmentModel.fromJson(
                          controller.myLabAppointments[index]);

                  return Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.secondaryColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            labAppointmentModel.testName!,
                                            style: TextStyle(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: AppDecoration.cairo,
                                              fontSize:
                                                  AppDecoration().screenWidth *
                                                      0.045,
                                            ),
                                          ),
                                        ),
                                        if (labAppointmentModel.documents !=
                                            null)
                                          GestureDetector(
                                            onTap: () {
                                              Get.defaultDialog(
                                                title: 'Download',
                                                content: SizedBox(
                                                  width: AppDecoration()
                                                          .screenWidth *
                                                      0.6,
                                                  height: AppDecoration()
                                                          .screenHeight *
                                                      0.15,
                                                  child: labAppointmentModel
                                                          .documents!.isNotEmpty
                                                      ? ListView.builder(
                                                          physics:
                                                              const BouncingScrollPhysics(
                                                            parent:
                                                                AlwaysScrollableScrollPhysics(),
                                                          ),
                                                          itemCount:
                                                              labAppointmentModel
                                                                  .documents!
                                                                  .length,
                                                          itemBuilder: (context,
                                                              docIndex) {
                                                            Documents
                                                                documents =
                                                                labAppointmentModel
                                                                        .documents![
                                                                    docIndex];

                                                            return Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                if (documents
                                                                        .file !=
                                                                    null)
                                                                  Expanded(
                                                                    child: Text(documents
                                                                        .file!
                                                                        .split(
                                                                            '/')
                                                                        .last),
                                                                  ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    downloadController
                                                                        .downloadFile(
                                                                      url: documents
                                                                          .file!,
                                                                    );
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .download,
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        )
                                                      : const Center(
                                                          child: Text(
                                                            'Awaiting Test Results',
                                                          ),
                                                        ),
                                                ),
                                              );
                                            },
                                            child: const Icon(
                                              Icons.attachment_outlined,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          AppDecoration().screenHeight * 0.01,
                                    ),
                                    SizedBox(
                                      width: AppDecoration().screenWidth * 0.6,
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Lab : ',
                                              style: TextStyle(
                                                color: AppColors.red,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: AppDecoration.cairo,
                                                fontSize: AppDecoration()
                                                        .screenWidth *
                                                    0.04,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  labAppointmentModel.fullName,
                                              style: TextStyle(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: AppDecoration.cairo,
                                                fontSize: AppDecoration()
                                                        .screenWidth *
                                                    0.04,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height: AppDecoration().screenHeight *
                                            0.02),
                                    SizedBox(
                                      width: AppDecoration().screenWidth * 0.6,
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Booking Date : ',
                                              style: TextStyle(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: AppDecoration.cairo,
                                                fontSize: AppDecoration()
                                                        .screenWidth *
                                                    0.038,
                                              ),
                                            ),
                                            TextSpan(
                                              text: Jiffy(
                                                      labAppointmentModel.date)
                                                  .yMMMMd,
                                              style: TextStyle(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: AppDecoration.cairo,
                                                fontSize: AppDecoration()
                                                        .screenWidth *
                                                    0.038,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: AppDecoration().screenWidth * 0.6,
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Booking Status : ',
                                              style: TextStyle(
                                                color: AppColors.black,
                                                fontFamily: AppDecoration.cairo,
                                                fontWeight: FontWeight.bold,
                                                fontSize: AppDecoration()
                                                        .screenWidth *
                                                    0.038,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  labAppointmentModel.status ==
                                                          '1'
                                                      ? 'Success'
                                                      : '',
                                              style: TextStyle(
                                                color: AppColors.black,
                                                fontFamily: AppDecoration.cairo,
                                                fontWeight: FontWeight.w400,
                                                fontSize: AppDecoration()
                                                        .screenWidth *
                                                    0.038,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 8.0,
                            right: 8.0,
                          ),
                          child: Divider(
                            thickness: 0.4,
                            color: AppColors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: AppDecoration().screenWidth * 0.5,
                            child: Text(
                              'Total Price : ${AppTexts.indianRupee} ${labAppointmentModel.amount}',
                              style: TextStyle(
                                fontSize: AppDecoration().screenWidth * 0.043,
                                fontWeight: FontWeight.bold,
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
        ),
      ),
    );
  }
}
