import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/doctors/appointment_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/appointment_screen/appointment_details.dart';
import 'package:teleprac/view/widgets/appointment_screen/appointments_list.dart';
import 'package:teleprac/view/widgets/appointment_screen/book_button.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppointmentController controller = Get.put(AppointmentController());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: WillPopScope(
        onWillPop: controller.willPop,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UpperPart(
                text: AppTexts.appointment,
                customBackFunction: controller.willPop,
              ),
              SizedBox(height: AppDecoration().screenHeight * 0.02),
              const AppointmentDetails(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Appointment Price :  ${controller.amount} ${AppTexts.indianRupee}',
                  style: TextStyle(
                    fontFamily: AppDecoration.cairo,
                    fontSize: AppDecoration().screenWidth * 0.045,
                    fontWeight: FontWeight.w600,
                    color: AppColors.grey,
                  ),
                ),
              ),
              const AppointmentsList(),
              SizedBox(height: AppDecoration().screenHeight * 0.02),
              const BookButton(),
              // SizedBox(height: AppDecoration().screenHeight * 0.02),
              // const LowerPart(),
              // SizedBox(height: AppDecoration().screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
