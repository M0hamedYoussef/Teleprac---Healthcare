import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:teleprac/controller/home/dashboard/my_appointments/my_appointments_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/model/home/dashboard/appointment/appointment_model.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/global/user_image.dart';

class MyAppointmentsList extends GetView<MyAppointmentsController> {
  const MyAppointmentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: controller.myAppointments.length,
        physics: const BouncingScrollPhysics(parent: PageScrollPhysics()),
        itemBuilder: (context, index) {
          AppointmentModel appointmentModel =
              AppointmentModel.fromJson(controller.myAppointments[index]);

          return Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    UserImage(
                      image: appointmentModel.profileimage!,
                      withGradient: false,
                    ),
                    FittedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: AppDecoration().screenWidth * 0.5,
                            child: Text(
                              controller.myRole == '1'
                                  ? appointmentModel.fullName!
                                  : 'Dr. ${appointmentModel.fullName!}',
                              style: TextStyle(
                                fontSize: AppDecoration().screenWidth * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: AppDecoration().screenHeight * 0.02,
                          ),
                          SizedBox(
                            width: AppDecoration().screenWidth * 0.5,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Appnt. Date: ',
                                    style: TextStyle(
                                      fontSize:
                                          AppDecoration().screenWidth * 0.04,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: appointmentModel.date!,
                                    style: TextStyle(
                                      fontSize:
                                          AppDecoration().screenWidth * 0.04,
                                      color: AppColors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: AppDecoration().screenWidth * 0.5,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Appnt. Time: ',
                                    style: TextStyle(
                                      fontSize:
                                          AppDecoration().screenWidth * 0.04,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '${appointmentModel.startTime!.replaceAll('AM', '').replaceAll('PM', '')}- ${appointmentModel.endTime!}',
                                    style: TextStyle(
                                      fontSize:
                                          AppDecoration().screenWidth * 0.04,
                                      color: AppColors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                GetBuilder<MyAppointmentsController>(builder: (_) {
                  String currentDate =
                      DateFormat('yyyy-MM-dd').format(controller.now);

                  String appointmentDate = controller.formatAppointmentDate(
                    date: appointmentModel.date!,
                  );

                  String comparison = controller.appointmentDateToNowCompare(
                    currentDate: currentDate,
                    appointmentDate: appointmentDate,
                  );
                  if (comparison == '$currentDate < $appointmentDate') {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 5),
                      child: Column(
                        children: [
                          SizedBox(
                            width: AppDecoration().screenWidth * 0.7,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Appointment Status: ',
                                    style: TextStyle(
                                      fontSize:
                                          AppDecoration().screenWidth * 0.04,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Up-Coming',
                                    style: TextStyle(
                                      fontSize:
                                          AppDecoration().screenWidth * 0.04,
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (comparison == '$currentDate = $appointmentDate') {
                    return GetBuilder<MyAppointmentsController>(
                      builder: (_) {
                        bool soon = false;
                        bool completed = false;
                        int appointmentHour = int.parse(
                            appointmentModel.startTime!.split(':')[0]);
                        int appointmentMinutes = int.parse(appointmentModel
                            .startTime!
                            .split(':')[1]
                            .split(' ')[0]);

                        int currentHour =
                            int.parse(controller.currentTime.split(':')[0]);
                        int currentMinutes = int.parse(
                            controller.currentTime.split(':')[1].split(' ')[0]);

                        int remainingHours = 0;
                        int remainingMinutes = 0;
                        int newRemaingTime = 0;
                        int runningFrom = 0;

                        calculateTime() {
                          remainingHours = appointmentHour - currentHour;
                          remainingMinutes =
                              appointmentMinutes - currentMinutes;
                          if (remainingHours == 1 &&
                              remainingMinutes.isNegative) {
                            newRemaingTime =
                                (remainingHours * 60) - remainingMinutes.abs();
                          } else if (remainingHours != 0 &&
                              remainingMinutes.isNegative) {
                            double decimalTime = ((remainingHours * 60) -
                                    remainingMinutes.abs()) /
                                60;
                            int hours = decimalTime.toInt();
                            double decimalMinutes = (decimalTime - hours) * 60;
                            int minutes = decimalMinutes.toInt();

                            remainingHours = hours;
                            remainingMinutes = minutes;
                          } else if (remainingHours == 0 &&
                              remainingMinutes.isNegative) {
                            runningFrom = remainingMinutes.abs();
                          } else if (remainingHours == 0 &&
                              !remainingMinutes.isNegative) {
                            newRemaingTime = remainingMinutes;
                          }
                          soon = true;
                        }

                        if (controller.currentTime.contains('AM') &&
                            appointmentModel.startTime!.contains('AM') &&
                            appointmentHour >= currentHour) {
                          calculateTime();
                        } else if (controller.currentTime.contains('PM') &&
                            appointmentModel.startTime!.contains('PM') &&
                            appointmentHour >= currentHour) {
                          calculateTime();
                        } else if ((controller.currentTime.contains('PM') &&
                                appointmentModel.startTime!.contains('AM')) ||
                            (controller.currentTime.contains('PM') &&
                                appointmentModel.startTime!.contains('PM') &&
                                appointmentHour < currentHour) ||
                            (controller.currentTime.contains('AM') &&
                                appointmentModel.startTime!.contains('AM') &&
                                appointmentHour < currentHour)) {
                          completed = true;
                        }

                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 8,
                            bottom: 5,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                width: AppDecoration().screenWidth * 0.8,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: soon
                                            ? runningFrom == 0
                                                ? 'Remaining Time '
                                                : runningFrom < 15
                                                    ? 'Running For '
                                                    : 'Appointment Status: '
                                            : 'Appointment Status: ',
                                        style: TextStyle(
                                          fontSize:
                                              AppDecoration().screenWidth *
                                                  0.04,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: soon
                                            ? ''
                                            : completed
                                                ? 'Completed'
                                                : 'Today ',
                                        style: TextStyle(
                                          fontSize:
                                              AppDecoration().screenWidth *
                                                  0.04,
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (soon)
                                        TextSpan(
                                          text: runningFrom == 0
                                              ? newRemaingTime != 0
                                                  ? '$newRemaingTime minutes'
                                                  : (remainingHours == 0 &&
                                                          remainingMinutes == 0)
                                                      ? 'now'
                                                      : '$remainingHours ${remainingHours > 1 ? 'hours' : 'hour'} and $remainingMinutes ${remainingMinutes > 1 ? 'minutes' : 'minute'}'
                                              : runningFrom < 15
                                                  ? '$runningFrom ${runningFrom > 1 ? 'minutes' : 'minutes'}'
                                                  : 'Completed',
                                          style: TextStyle(
                                            fontSize:
                                                AppDecoration().screenWidth *
                                                    0.04,
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              if (remainingHours == 0 &&
                                  (remainingMinutes.isNegative ||
                                      remainingMinutes == 0) &&
                                  (currentMinutes.abs() <
                                      appointmentMinutes + 15) &&
                                  soon)
                                // CustomButton(
                                //   function: () {
                                //     controller.appointmentDetails();
                                //   },
                                //   text: 'View',
                                //   buttonColor: AppColors.primaryColor,
                                //   textColor: AppColors.secondaryColor,
                                // ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 10, 8, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        CustomButton(
                                          function: () async {
                                            controller.call(
                                              appointmentModel: appointmentModel,
                                              callType: 'video',
                                            );
                                          },
                                          customWidget: const Icon(
                                            Icons.camera_alt_sharp,
                                            color: AppColors.secondaryColor,
                                          ),
                                          margin: const EdgeInsets.only(
                                            left: 5,
                                            right: 8,
                                          ),
                                          buttonColor: AppColors.primaryColor,
                                        ),
                                        CustomButton(
                                          function: () {
                                            controller.call(
                                              appointmentModel: appointmentModel,
                                              callType: 'voice',
                                            );
                                          },
                                          margin: EdgeInsets.zero,
                                          customWidget: const Icon(
                                            Icons.phone,
                                            color: AppColors.secondaryColor,
                                          ),
                                          buttonColor: AppColors.primaryColor,
                                        ),
                                      ],
                                    ),
                                  ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 5),
                      child: Column(
                        children: [
                          SizedBox(
                            width: AppDecoration().screenWidth * 0.7,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Appointment Status: ',
                                    style: TextStyle(
                                      fontSize:
                                          AppDecoration().screenWidth * 0.04,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Completed',
                                    style: TextStyle(
                                      fontSize:
                                          AppDecoration().screenWidth * 0.04,
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: AppDecoration().screenWidth * 0.01),
                        Image.asset(
                          AppDecoration.appointment,
                          width: AppDecoration().screenWidth * 0.06,
                        ),
                        SizedBox(width: AppDecoration().screenWidth * 0.01),
                        SizedBox(
                          width: AppDecoration().screenWidth * 0.5,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Booking Date: ',
                                  style: TextStyle(
                                    fontSize:
                                        AppDecoration().screenWidth * 0.04,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: appointmentModel.createdDate,
                                  style: TextStyle(
                                    fontSize:
                                        AppDecoration().screenWidth * 0.04,
                                    color: AppColors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppDecoration().screenWidth * 0.3,
                      child: Text(
                        '${AppTexts.indianRupee} ${appointmentModel.amount!}',
                        style: TextStyle(
                          fontSize: AppDecoration().screenWidth * 0.05,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
