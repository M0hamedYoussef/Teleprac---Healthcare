import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:teleprac/controller/doctors/appointment_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class AppointmentDetails extends GetView<AppointmentController> {
  const AppointmentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GetBuilder<AppointmentController>(
            builder: (_) {
              return Expanded(
                child: Text(
                  Jiffy(controller.appointmentDate).yMMMMEEEEd,
                  style: TextStyle(
                    fontFamily: AppDecoration.cairo,
                    fontSize: AppDecoration().screenWidth * 0.04,
                    fontWeight: FontWeight.w600,
                    color: AppColors.grey,
                  ),
                ),
              );
            },
          ),
          IconButton(
            onPressed: () {
              controller.selectDate(context: context);
            },
            icon: const Icon(
              Icons.edit_calendar,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

/**
 * Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GetBuilder<AppointmentController>(
            builder: (_) {
              if (controller.appointmentType == 'Online') {
                return Column(
                  children: [
                    Image.asset(
                      AppDecoration.onlineAppointment,
                      width: AppDecoration().screenWidth * 0.15,
                    ),
                    SizedBox(
                      width: AppDecoration().screenWidth * 0.32,
                      child: Text(
                        AppTexts.onlineAppointment,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: AppDecoration().screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    Image.asset(
                      AppDecoration.clinic,
                      width: AppDecoration().screenWidth * 0.15,
                    ),
                    SizedBox(
                      width: AppDecoration().screenWidth * 0.32,
                      child: Text(
                        AppTexts.inClinicAppointment,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: AppDecoration().screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          SizedBox(
            width: AppDecoration().screenWidth * 0.1,
          ),
          GestureDetector(
            onTap: () {
              controller.selectDate(context: context);
            },
            child: Column(
              children: [
                Image.asset(
                  AppDecoration.calendar,
                  width: AppDecoration().screenWidth * 0.13,
                ),
                const Text(
                  'Select Date',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
 */