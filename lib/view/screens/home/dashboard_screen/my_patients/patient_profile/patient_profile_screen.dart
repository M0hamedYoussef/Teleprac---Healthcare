import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard/my_patients/patient_profile/patient_profile_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class PatientProfileScreen extends StatelessWidget {
  const PatientProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    PatientProfileController controller = Get.put(PatientProfileController());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: SafeArea(
        child: Column(
          children: [
            const UpperPart(
              text: AppTexts.patientProfile,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.secondaryColor,
                ),
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.all(15),
                child: ListView(
                  children: [
                    SizedBox(height: AppDecoration().screenHeight * .02),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 1,
                            color: AppColors.grey,
                          ),
                        ),
                        width: AppDecoration().screenHeight * 0.25,
                        height: AppDecoration().screenHeight * 0.25,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Hero(
                            tag: controller.patientModel.id! +
                                controller.patientModel.profileimage!,
                            child: CachedNetworkImage(
                              imageUrl: controller.patientModel.profileimage!,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: AppDecoration().screenHeight * .02),
                    Text(
                      controller.patientModel.fullName!,
                      style: TextStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppDecoration.cairo,
                        fontSize: AppDecoration().screenWidth * 0.07,
                      ),
                    ),
                    SizedBox(height: AppDecoration().screenHeight * .02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColors.primaryColor,
                          size: AppDecoration().screenWidth * 0.05,
                        ),
                        SizedBox(width: AppDecoration().screenWidth * 0.01),
                        Expanded(
                          child: Text(
                            controller.patientModel.fullAddress!,
                            style: TextStyle(
                              color: AppColors.grey,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppDecoration.cairo,
                              fontSize: AppDecoration().screenWidth * 0.045,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppDecoration().screenHeight * .02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.phone,
                          color: AppColors.primaryColor,
                          size: AppDecoration().screenWidth * 0.05,
                        ),
                        SizedBox(width: AppDecoration().screenWidth * 0.01),
                        Expanded(
                          child: Text(
                            '+91 ${controller.patientModel.mobileno}',
                            style: TextStyle(
                              color: AppColors.grey,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppDecoration.cairo,
                              fontSize: AppDecoration().screenWidth * 0.045,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppDecoration().screenHeight * .02),
                    if (controller.patientModel.age != null)
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Age : ',
                              style: TextStyle(
                                color: AppColors.grey,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppDecoration.cairo,
                                fontSize: AppDecoration().screenWidth * 0.05,
                              ),
                            ),
                            TextSpan(
                              text: controller.patientModel.age!,
                              style: TextStyle(
                                color: AppColors.grey,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppDecoration.cairo,
                                fontSize: AppDecoration().screenWidth * 0.05,
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: AppDecoration().screenHeight * .02),
                    if (controller.patientModel.dob != null)
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Date Of Birth : ',
                              style: TextStyle(
                                color: AppColors.grey,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppDecoration.cairo,
                                fontSize: AppDecoration().screenWidth * 0.05,
                              ),
                            ),
                            TextSpan(
                              text: controller.patientModel.dob!,
                              style: TextStyle(
                                color: AppColors.grey,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppDecoration.cairo,
                                fontSize: AppDecoration().screenWidth * 0.05,
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: AppDecoration().screenHeight * .02),
                    if (controller.patientModel.bloodGroup != null)
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Blood Group : ',
                              style: TextStyle(
                                color: AppColors.grey,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppDecoration.cairo,
                                fontSize: AppDecoration().screenWidth * 0.05,
                              ),
                            ),
                            TextSpan(
                              text: controller.patientModel.bloodGroup!,
                              style: TextStyle(
                                color: AppColors.grey,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppDecoration.cairo,
                                fontSize: AppDecoration().screenWidth * 0.05,
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: AppDecoration().screenHeight * .02),
                    if (controller.patientModel.gender != null)
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Gender : ',
                              style: TextStyle(
                                color: AppColors.grey,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppDecoration.cairo,
                                fontSize: AppDecoration().screenWidth * 0.05,
                              ),
                            ),
                            TextSpan(
                              text: controller.patientModel.gender!,
                              style: TextStyle(
                                color: AppColors.grey,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppDecoration.cairo,
                                fontSize: AppDecoration().screenWidth * 0.05,
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: AppDecoration().screenHeight * 0.1),
                    CustomButton(
                      function: controller.bookFollowUp,
                      text: 'Book Follow Up Appointment',
                      buttonColor: AppColors.primaryColor,
                      circularRadius: 10,
                      margin: const EdgeInsets.only(left: 8, right: 8),
                      // buttonIcon: Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Image.asset(AppDecoration.appointment),
                      // ),
                      // iconAlignment: Alignment.centerLeft,
                    ),
                    SizedBox(height: AppDecoration().screenHeight * 0.03),
                    CustomButton(
                      function: controller.goToAddPrescription,
                      text: AppTexts.addPrescription,
                      buttonColor: AppColors.primaryColor,
                      // buttonIcon: Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Image.asset(AppDecoration.writePrescription),
                      // ),
                      // iconAlignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 8, right: 8),
                      circularRadius: 10,
                    ),
                    SizedBox(height: AppDecoration().screenHeight * 0.03),
                    CustomButton(
                      function: controller.goToAddTest,
                      text: AppTexts.addTest,
                      buttonColor: AppColors.primaryColor,
                      // buttonIcon: Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Image.asset(AppDecoration.payForLabTests),
                      // ),
                      // iconAlignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 8, right: 8),
                      circularRadius: 10,
                    ),
                    SizedBox(height: AppDecoration().screenHeight * 0.03),
                    CustomButton(
                      function: controller.goToMedicalHistory,
                      text: AppTexts.medicalHistory,
                      buttonColor: AppColors.primaryColor,
                      // buttonIcon: const Padding(
                      //   padding: EdgeInsets.all(8.0),
                      //   child: Icon(
                      //     Icons.local_hospital,
                      //     color: AppColors.black,
                      //   ),
                      // ),
                      // iconAlignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 8, right: 8),
                      circularRadius: 10,
                    ),
                    SizedBox(height: AppDecoration().screenHeight * 0.03),
                    CustomButton(
                      function: controller.goToLabReports,
                      text: AppTexts.labReports,
                      buttonColor: AppColors.primaryColor,
                      // buttonIcon: const Padding(
                      //   padding: EdgeInsets.all(8.0),
                      //   child: Icon(
                      //     Icons.history,
                      //     color: AppColors.black,
                      //   ),
                      // ),
                      // iconAlignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 8, right: 8),
                      circularRadius: 10,
                    ),
                    SizedBox(height: AppDecoration().screenHeight * 0.03),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
