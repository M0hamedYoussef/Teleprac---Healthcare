import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard/my_patients/my_patients_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/home/dashboard/patient_model.dart';
import 'package:teleprac/view/widgets/global/user_image.dart';

class MyPatientsList extends GetView<MyPatientsController> {
  const MyPatientsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: controller.myPatients.length,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemBuilder: (context, index) {
          PatientModel patientModel =
              PatientModel.fromJson(controller.myPatients[index]);
          if (patientModel.id != null) {
            return IntrinsicHeight(
              child: GestureDetector(
                onTap: () {
                  controller.viewPatientProfile(patientModel: patientModel);
                },
                child: Container(
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
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Hero(
                          tag: patientModel.id! +
                              patientModel.profileimage.toString(),
                          child: UserImage(
                            image: patientModel.profileimage.toString(),
                            withGradient: false,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: AppDecoration().screenHeight * 0.03,
                            ),
                            SizedBox(
                              width: AppDecoration().screenWidth * 0.5,
                              child: Text(
                                patientModel.fullName!,
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppDecoration.cairo,
                                  height: 1,
                                  fontSize: AppDecoration().screenWidth * 0.05,
                                ),
                              ),
                            ),
                            SizedBox(
                                height: AppDecoration().screenHeight * 0.01),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: AppColors.primaryColor,
                                  size: AppDecoration().screenWidth * 0.045,
                                ),
                                SizedBox(
                                    width: AppDecoration().screenWidth * 0.01),
                                SizedBox(
                                  width: AppDecoration().screenWidth * 0.4,
                                  child: Text(
                                    patientModel.fullAddress!,
                                    style: TextStyle(
                                      color: AppColors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppDecoration.cairo,
                                      fontSize:
                                          AppDecoration().screenWidth * 0.04,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height: AppDecoration().screenHeight * 0.01),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: AppColors.primaryColor,
                                  size: AppDecoration().screenWidth * 0.045,
                                ),
                                SizedBox(
                                    width: AppDecoration().screenWidth * 0.01),
                                SizedBox(
                                  width: AppDecoration().screenWidth * 0.4,
                                  child: Text(
                                    '+91${patientModel.mobileno}',
                                    style: TextStyle(
                                      color: AppColors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppDecoration.cairo,
                                      fontSize:
                                          AppDecoration().screenWidth * 0.04,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: AppDecoration().screenHeight * 0.02,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
