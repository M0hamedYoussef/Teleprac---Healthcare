import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/doctors/appointment_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class AppointmentType extends StatelessWidget {
  const AppointmentType({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.changeType(type: 'Online');
                  },
                  child: Container(
                    decoration: controller.appointmentType == 'Online'
                        ? BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 2,
                            ),
                          )
                        : null,
                    child: Column(
                      children: [
                        Image.asset(
                          AppDecoration.onlineAppointment,
                          width: AppDecoration().screenWidth * 0.15,
                        ),
                        SizedBox(
                          width: AppDecoration().screenWidth * 0.32,
                          child: const Text(
                            AppTexts.onlineAppointment,
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: AppDecoration().screenWidth * 0.01,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.changeType(type: 'Clinic');
                  },
                  child: Container(
                    decoration: controller.appointmentType == 'Clinic'
                        ? BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 2,
                            ),
                          )
                        : null,
                    child: Column(
                      children: [
                        Image.asset(
                          AppDecoration.clinic,
                          width: AppDecoration().screenWidth * 0.15,
                        ),
                        SizedBox(
                          width: AppDecoration().screenWidth * 0.32,
                          child: const Text(
                            AppTexts.inClinicAppointment,
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
