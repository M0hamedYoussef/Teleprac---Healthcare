import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/doctors/appointment_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';

class BookButton extends GetView<AppointmentController> {
  const BookButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      function: () {
        controller.bookAppointment();
      },
      text: 'Continue',
      fontSize: 0.05,
      buttonColor: AppColors.primaryColor,
      circularRadius: 10,
      // text: AppTexts.bookSelected,
      // buttonIcon: const Padding(
      //   padding: EdgeInsets.only(left: 15),
      //   child: Icon(
      //     Icons.calendar_today_outlined,
      //     color: AppColors.secondaryColor,
      //   ),
      // ),
    );
  }
}
