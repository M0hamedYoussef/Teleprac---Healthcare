import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard/my_patients/patient_profile/medical_history_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/view/widgets/home/dashboard/my_patients/medical_history/medical_history_list.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class MedicalHistoryScreen extends StatelessWidget {
  const MedicalHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MedicalHistoryController controller = Get.put(MedicalHistoryController());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: SafeArea(
        child: Column(
          children: [
            UpperPart(
              text: 'Medical History',
              trFunction: controller.goToAddMedicalHistory,
              trIcon: CupertinoIcons.cloud_upload,
              trIconColor: AppColors.primaryColor,
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.02),
            const MedicalHistoryList(),
          ],
        ),
      ),
    );
  }
}
