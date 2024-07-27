import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/doctors/doctor_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/view/widgets/doctor_screen/doctor_address.dart';
import 'package:teleprac/view/widgets/doctor_screen/doctor_bio.dart';
import 'package:teleprac/view/widgets/doctor_screen/doctor_degrees.dart';
import 'package:teleprac/view/widgets/doctor_screen/doctor_education.dart';
import 'package:teleprac/view/widgets/doctor_screen/doctor_experience.dart';
import 'package:teleprac/view/widgets/doctor_screen/doctor_image.dart';
import 'package:teleprac/view/widgets/doctor_screen/doctor_name_row.dart';
import 'package:teleprac/view/widgets/doctor_screen/doctor_services.dart';
import 'package:teleprac/view/widgets/doctor_screen/lower_part.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DoctorController controller = Get.put(DoctorController());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: WillPopScope(
        onWillPop: controller.willPop,
        child: SafeArea(
          child: Column(
            children: [
              UpperPart(
                // text: AppTexts.doctorProfile,
                text: '',
                customBackFunction: controller.willPop,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    DoctorImage(),
                    DoctorName(),
                  ],
                ),
              ),
              SizedBox(height: AppDecoration().screenHeight * 0.02),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadiusDirectional.vertical(
                        top: Radius.circular(35),
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    width: AppDecoration().screenWidth,
                    height: AppDecoration().screenHeight * 0.65,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: AppDecoration().screenWidth * 0.5,
                          ),
                          child: Text(
                            '${controller.advancedDoctorModel.expYears ?? ''} Years Experiences',
                            style: TextStyle(
                              color: AppColors.secondaryColor,
                              fontWeight: FontWeight.w300,
                              fontFamily: AppDecoration.cairo,
                              fontSize: AppDecoration().screenWidth * 0.05,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColors.amber,
                              size: AppDecoration().screenWidth * 0.062,
                            ),
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: AppDecoration().screenWidth * 0.2,
                              ),
                              child: Text(
                                '${controller.advancedDoctorModel.doctorDetails!.ratingValue!} (${controller.advancedDoctorModel.doctorDetails!.ratingCount!})',
                                style: TextStyle(
                                  color: AppColors.amber,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppDecoration.cairo,
                                  fontSize: AppDecoration().screenWidth * 0.05,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.greyDesign,
                      borderRadius: BorderRadiusDirectional.vertical(
                        top: Radius.circular(40),
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    width: AppDecoration().screenWidth,
                    height: AppDecoration().screenHeight * 0.55,
                    child: ListView(
                      children: const [
                        DoctorBio(),
                        DoctorAddress(),
                        DoctorDegreesWithRating(),
                        DoctorEducation(),
                        DoctorExperience(),
                        DoctorServices(),
                      ],
                    ),
                  ),
                ],
              ),
              const LowerPart(),
            ],
          ),
        ),
      ),
    );
  }
}
/**
 *  SizedBox(height: AppDecoration().screenHeight * .02),
                    const DoctorImage(),
                    SizedBox(height: AppDecoration().screenHeight * .02),
                    const DoctorAddress(),
                    SizedBox(height: AppDecoration().screenHeight * .005),
                    const DoctorNameRow(),
                    SizedBox(height: AppDecoration().screenHeight * .005),
                    const DoctorSpeciality(),
                    SizedBox(height: AppDecoration().screenHeight * .01),
                    const DoctorDegreesWithRating(),
                    SizedBox(height: AppDecoration().screenHeight * .005),
                    const DoctorBio(),
                    SizedBox(height: AppDecoration().screenHeight * .005),
                    const DoctorEducation(),
                    SizedBox(height: AppDecoration().screenHeight * .005),
                    const DoctorExperience(),
                    SizedBox(height: AppDecoration().screenHeight * .005),
                    const DoctorServices(),
 */
