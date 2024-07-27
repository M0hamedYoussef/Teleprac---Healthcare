import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard/my_appointments/my_appointments_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/home/dashboard/my_appointments/appointments_list.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class MyAppointmentsScreen extends StatelessWidget {
  const MyAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyAppointmentsController());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: SafeArea(
        child: Column(
          children: [
            const UpperPart(
              text: AppTexts.myAppointments,
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.02),
            const MyAppointmentsList(),
          ],
        ),
      ),
    );
  }
}
