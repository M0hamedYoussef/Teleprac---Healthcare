import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard/my_patients/my_patients_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/home/dashboard/my_patients/patients_list.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class MyPatientsScreen extends StatelessWidget {
  const MyPatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyPatientsController());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: SafeArea(
        child: Column(
          children: [
            const UpperPart(
              text: AppTexts.myPatients,
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.02),
            const MyPatientsList(),
          ],
        ),
      ),
    );
  }
}
