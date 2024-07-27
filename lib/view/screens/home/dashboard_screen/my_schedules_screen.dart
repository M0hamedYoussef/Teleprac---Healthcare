import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard/my_schedules_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/model/global/drop_down_model.dart';
import 'package:teleprac/model/home/dashboard/schedule_model.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/drop_down.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class MySchedulesScreen extends StatelessWidget {
  const MySchedulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MySchedulesController());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: SafeArea(
        child: Column(
          children: [
            const UpperPart(
              text: AppTexts.mySchedules,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(10),
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: [
                  GetBuilder<MySchedulesController>(
                    builder: (controller) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Time Slot Duration',
                              style: TextStyle(
                                color: AppColors.grey,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppDecoration.cairo,
                                fontSize: AppDecoration().screenWidth * 0.05,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                                height: AppDecoration().screenHeight * 0.02),
                            CustomDropDown(
                              dropdownList: controller.timeSlots,
                              value: controller.selectedTimeSlot,
                              label: 'Time Slot Duration',
                              oldDesign: false,
                              onChanged: (value) {
                                controller.changeSlotDuration(
                                    slotDuration: value!);
                              },
                            ),
                            SizedBox(
                              height: AppDecoration().screenHeight * 0.02,
                            ),
                            Text(
                              'Check Your Current Schedule',
                              style: TextStyle(
                                color: AppColors.grey,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppDecoration.cairo,
                                fontSize: AppDecoration().screenWidth * 0.05,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                                height: AppDecoration().screenHeight * 0.02),
                            CustomDropDown(
                              dropdownList: controller.days,
                              label: 'Day',
                              oldDesign: false,
                              value: controller.selectedDay,
                              onChanged: (value) {
                                controller.changeDay(newSelectedDay: value!);
                              },
                            ),
                            SizedBox(
                                height: AppDecoration().screenHeight * 0.02),
                            Text(
                              'Set Appointment Days',
                              style: TextStyle(
                                color: AppColors.grey,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppDecoration.cairo,
                                fontSize: AppDecoration().screenWidth * 0.05,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                                height: AppDecoration().screenHeight * 0.02),
                            GridView(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 2.5,
                              ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                ...List.generate(
                                  controller.days.length,
                                  (index) {
                                    DropDownItemModel dayModel =
                                        DropDownItemModel.fromJson(
                                            controller.days[index]);

                                    return GetBuilder<MySchedulesController>(
                                      builder: (_) {
                                        bool isAdded = controller.selectedDays
                                            .contains(dayModel.value);
                                        return GestureDetector(
                                          onTap: () {
                                            if (isAdded) {
                                              controller.selectedDays
                                                  .remove(dayModel.value);
                                              controller.update();
                                            } else {
                                              controller.selectedDays
                                                  .add(dayModel.value);
                                              controller.update();
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Transform.scale(
                                                  scale: 0.8,
                                                  child: Checkbox(
                                                    activeColor:
                                                        AppColors.primaryColor,
                                                    value: isAdded,
                                                    visualDensity:
                                                        const VisualDensity(
                                                      horizontal: -4.0,
                                                      vertical: -4.0,
                                                    ),
                                                    onChanged: (_) {
                                                      if (isAdded) {
                                                        controller.selectedDays
                                                            .remove(
                                                                dayModel.value);
                                                        controller.update();
                                                      } else {
                                                        controller.selectedDays
                                                            .add(
                                                                dayModel.value);
                                                        controller.update();
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                dayModel.label!,
                                                style: TextStyle(
                                                  fontSize: AppDecoration()
                                                          .screenWidth *
                                                      0.032,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                GetBuilder<MySchedulesController>(
                                  builder: (_) {
                                    bool isAdded =
                                        controller.selectedDays.length == 7;
                                    return GestureDetector(
                                      onTap: () {
                                        if (isAdded) {
                                          controller.selectedDays = [];
                                          controller.update();
                                        } else {
                                          for (var element in controller.days) {
                                            if (!controller.selectedDays
                                                .contains(element['value'])) {
                                              controller.selectedDays
                                                  .add(element['value']);
                                            }
                                          }
                                          controller.update();
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Transform.scale(
                                              scale: 0.8,
                                              child: Checkbox(
                                                activeColor:
                                                    AppColors.primaryColor,
                                                value: isAdded,
                                                visualDensity:
                                                    const VisualDensity(
                                                  horizontal: -4.0,
                                                  vertical: -4.0,
                                                ),
                                                onChanged: (_) {
                                                  if (isAdded) {
                                                    controller.selectedDays =
                                                        [];
                                                    controller.update();
                                                  } else {
                                                    for (var element
                                                        in controller.days) {
                                                      if (!controller
                                                          .selectedDays
                                                          .contains(element[
                                                              'value'])) {
                                                        controller.selectedDays
                                                            .add(element[
                                                                'value']);
                                                      }
                                                    }
                                                    controller.update();
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'All Days',
                                            style: TextStyle(
                                              fontSize:
                                                  AppDecoration().screenWidth *
                                                      0.032,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                                height: AppDecoration().screenHeight * 0.02),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Add Sessions (Time Slots)',
                                    style: TextStyle(
                                      color: AppColors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppDecoration.cairo,
                                      fontSize:
                                          AppDecoration().screenWidth * 0.05,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (controller.schedulesList.isEmpty) {
                                      controller.schedulesList.add({
                                        'session_id': controller
                                            .schedulesList.length
                                            .toString(),
                                        'slot': controller.selectedTimeSlot,
                                        'token': '',
                                        'type': 'online',
                                        'end_time_label': null,
                                        'end_time_value': null,
                                        'start_time_value': null,
                                        'start_time_label': null,
                                      });
                                      controller.update();
                                    } else if (controller.schedulesList[
                                                controller
                                                        .schedulesList.length -
                                                    1]['end_time_value'] ==
                                            '23:${60 - int.parse(controller.selectedTimeSlot)}' ||
                                        (controller.schedulesList[controller
                                                        .schedulesList.length -
                                                    1]['end_time_value'] ==
                                                '23:00' &&
                                            controller.selectedTimeSlot ==
                                                '60')) {
                                      Get.defaultDialog(
                                          middleText:
                                              'Can\'t add more schedules');
                                    } else if (controller.schedulesList[
                                            controller.schedulesList.length -
                                                1]['end_time_value'] ==
                                        null) {
                                      Get.defaultDialog(
                                          middleText:
                                              'Please fill all schedules first');
                                    } else {
                                      controller.schedulesList.add({
                                        'session_id': controller
                                            .schedulesList.length
                                            .toString(),
                                        'slot': controller.selectedTimeSlot,
                                        'token': '',
                                        'type': 'online',
                                        'end_time_label': null,
                                        'end_time_value': null,
                                        'start_time_value': null,
                                        'start_time_label': null,
                                      });
                                      controller.update();
                                    }
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.grey,
                                    size: AppDecoration().screenWidth * 0.07,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height: AppDecoration().screenHeight * 0.02),
                            ...List.generate(
                              controller.schedulesList.length,
                              (index) {
                                ScheduleModel scheduleModel =
                                    ScheduleModel.fromJson(
                                  controller.schedulesList[index],
                                );

                                int startHour = scheduleModel.startTimeValue !=
                                        null
                                    ? int.parse(scheduleModel.startTimeValue!
                                        .split(':')[0])
                                    : 0;
                                int startMinute =
                                    scheduleModel.startTimeValue != null
                                        ? int.parse(scheduleModel
                                            .startTimeValue!
                                            .split(':')[1])
                                        : 0;
                                String selectedStartTime = scheduleModel
                                            .startTimeValue !=
                                        null
                                    ? '${scheduleModel.startTimeValue!.split(':')[0]}:${scheduleModel.startTimeValue!.split(':')[1]}'
                                    : '';
                                String selectedEndTime = scheduleModel
                                            .endTimeValue !=
                                        null
                                    ? '${scheduleModel.endTimeValue!.split(':')[0]}:${scheduleModel.endTimeValue!.split(':')[1]}'
                                    : '';
                                List endTimes = controller.claculateEndTimes(
                                  selectedStartTime: TimeOfDay(
                                    hour: startHour,
                                    minute: startMinute,
                                  ),
                                );

                                List customStartTimes;

                                if (index != 0) {
                                  ScheduleModel lastSchedule =
                                      ScheduleModel.fromJson(
                                    controller.schedulesList[index - 1],
                                  );

                                  int lastEndHour =
                                      lastSchedule.endTimeValue != null
                                          ? int.parse(lastSchedule.endTimeValue!
                                              .split(':')[0])
                                          : 0;
                                  int lastEndMinute =
                                      lastSchedule.endTimeValue != null
                                          ? int.parse(lastSchedule.endTimeValue!
                                              .split(':')[1])
                                          : 0;

                                  if (controller.selectedTimeSlot != '60') {
                                    customStartTimes =
                                        controller.claculateEndTimes(
                                      selectedStartTime: TimeOfDay(
                                        hour: lastEndHour,
                                        minute: lastEndMinute -
                                            int.parse(
                                                controller.selectedTimeSlot),
                                      ),
                                    );
                                  } else {
                                    customStartTimes =
                                        controller.claculateEndTimes(
                                      selectedStartTime: TimeOfDay(
                                        hour: lastEndHour - 1,
                                        minute: 0,
                                      ),
                                    );
                                  }
                                } else {
                                  customStartTimes = controller.startTimes;
                                }
                                int tokensNumber;
                                if (selectedEndTime.isNotEmpty &&
                                    scheduleModel.startTimeValue != null) {
                                  TimeOfDay startTime = TimeOfDay(
                                      hour: int.parse(scheduleModel
                                          .startTimeValue!
                                          .split(':')[0]),
                                      minute: int.parse(scheduleModel
                                          .startTimeValue!
                                          .split(':')[1]));
                                  TimeOfDay endTime = TimeOfDay(
                                      hour: int.parse(scheduleModel
                                          .endTimeValue!
                                          .split(':')[0]),
                                      minute: int.parse(scheduleModel
                                          .endTimeValue!
                                          .split(':')[1]));
                                  tokensNumber = controller
                                      .calculateTimeSlots(
                                          startTime: startTime,
                                          endTime: endTime)
                                      .length;
                                } else {
                                  tokensNumber = 0;
                                }
                                controller.schedulesList[index]['token'] =
                                    tokensNumber.toString();

                                if (selectedStartTime.isNotEmpty) {
                                  bool contains = false;

                                  for (var element in customStartTimes) {
                                    if (element['value'] == selectedStartTime) {
                                      contains = true;
                                      break;
                                    }
                                  }
                                  if (!contains) {
                                    String label = '';
                                    for (var element in controller.startTimes) {
                                      if (element['value'] ==
                                          selectedStartTime) {
                                        label = element['label'];
                                        break;
                                      }
                                    }
                                    List fixedList = [
                                      {
                                        'value': selectedStartTime,
                                        'label': label,
                                      },
                                    ];
                                    fixedList.addAll(customStartTimes);
                                    customStartTimes = fixedList;
                                  }
                                }

                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          controller.schedulesList.remove(
                                              controller.schedulesList[index]);
                                          controller.update();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.close,
                                            color: AppColors.grey,
                                            size: AppDecoration().screenWidth *
                                                0.06,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'No. of Tokens',
                                            style: TextStyle(
                                              color: AppColors.grey,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: AppDecoration.cairo,
                                              fontSize:
                                                  AppDecoration().screenWidth *
                                                      0.04,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '$tokensNumber',
                                          style: TextStyle(
                                            color: AppColors.grey,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: AppDecoration.cairo,
                                            fontSize:
                                                AppDecoration().screenWidth *
                                                    0.04,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height: AppDecoration().screenHeight *
                                            0.02),
                                    Text(
                                      'Start Time',
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: AppDecoration.cairo,
                                        fontSize:
                                            AppDecoration().screenWidth * 0.055,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(
                                        height: AppDecoration().screenHeight *
                                            0.02),
                                    CustomDropDown(
                                      dropdownList: customStartTimes,
                                      value: selectedStartTime,
                                      label: 'Select Start Time',
                                      padding: EdgeInsets.zero,
                                      onChanged: (value) {
                                        controller.selectStartTime(
                                          index: index,
                                          value: value!,
                                        );
                                      },
                                    ),
                                    SizedBox(
                                        height: AppDecoration().screenHeight *
                                            0.02),
                                    Text(
                                      'End Time',
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: AppDecoration.cairo,
                                        fontSize:
                                            AppDecoration().screenWidth * 0.055,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(
                                        height: AppDecoration().screenHeight *
                                            0.02),
                                    CustomDropDown(
                                      dropdownList: endTimes,
                                      value: selectedEndTime,
                                      padding: EdgeInsets.zero,
                                      label: 'Select End Time',
                                      onChanged: (value) {
                                        controller.selectEndTime(
                                          index: index,
                                          value: value!,
                                          endTimes: endTimes,
                                        );
                                      },
                                    ),
                                    SizedBox(
                                        height: AppDecoration().screenHeight *
                                            0.02),
                                    const Divider(
                                      color: AppColors.black,
                                    ),
                                  ],
                                );
                              },
                            ),
                            SizedBox(
                                height: controller.schedulesList.isEmpty
                                    ? AppDecoration().screenHeight * 0.2
                                    : AppDecoration().screenHeight * 0.02),
                            CustomButton(
                              function: () {
                                controller.updateSchedule();
                              },
                              buttonColor: AppColors.primaryColor,
                              text: controller.schedulesList.isNotEmpty
                                  ? 'Add Schedules'
                                  : 'Delete All Schedules',
                              circularRadius: 10,
                            ),
                            SizedBox(
                                height: AppDecoration().screenHeight * 0.02),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
