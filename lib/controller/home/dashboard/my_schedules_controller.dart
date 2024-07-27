import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/model/global/response_model.dart';

class MySchedulesController extends GetxController {
  late List schedulesList;
  late String selectedTimeSlot;
  late String selectedDay;
  late List startTimes;
  MyServices myServices = Get.find();
  Crud crud = Crud();
  List days = [
    {
      'value': '1',
      'label': 'Sunday',
    },
    {
      'value': '2',
      'label': 'Monday',
    },
    {
      'value': '3',
      'label': 'Tuesday',
    },
    {
      'value': '4',
      'label': 'Wednesday',
    },
    {
      'value': '5',
      'label': 'Thursday',
    },
    {
      'value': '6',
      'label': 'Friday',
    },
    {
      'value': '7',
      'label': 'Saturday',
    },
  ];
  List timeSlots = [
    {
      'value': '15',
      'label': '15 Minutes',
    },
    {
      'value': '20',
      'label': '20 Minutes',
    },
    {
      'value': '30',
      'label': '30 Minutes',
    },
    {
      'value': '45',
      'label': '45 Minutes',
    },
    {
      'value': '60',
      'label': '1 Hour',
    },
  ];
  List selectedDays = [];

  @override
  void onInit() {
    schedulesList = Get.arguments['schedulesList'];
    selectedTimeSlot = Get.arguments['slotDuration'];
    selectedDay = '1';

    if (selectedTimeSlot.isNotEmpty) {
      timeCalculate(
        startHour: 00,
        startMinutes: 00,
        endHour: 24,
        endMinutes: 00,
      );
    } else {
      selectedTimeSlot = '15';
      timeCalculate(
        startHour: 00,
        startMinutes: 00,
        endHour: 24,
        endMinutes: 00,
      );
    }

    super.onInit();
  }

  selectStartTime({
    required int index,
    required String value,
  }) {
    String? startTime;

    if (schedulesList[index]['start_time_value'] != null) {
      startTime = schedulesList[index]['start_time_value'].split(':')[0] +
          ':' +
          schedulesList[index]['start_time_value'].split(':')[1];
    }
    if (startTime != value) {
      if (index == 0) {
        schedulesList[index]['end_time_value'] = null;
        schedulesList[index]['start_time_value'] = value;
        for (var element in startTimes) {
          if (element['value'] == value) {
            schedulesList[index]['start_time_label'] = element['label'];
            break;
          }
        }
      } else {
        int selectedStartHour = int.parse(value.split(':')[0]);
        int selectedStartMinute = int.parse(value.split(':')[1]);

        int lastHour =
            int.parse(schedulesList[index - 1]['end_time_value'].split(':')[0]);
        int lastMinute =
            int.parse(schedulesList[index - 1]['end_time_value'].split(':')[1]);

        if (selectedStartHour > lastHour ||
            (selectedStartHour == lastHour &&
                selectedStartMinute >= lastMinute)) {
          schedulesList[index]['end_time_value'] = null;
          schedulesList[index]['start_time_value'] = value;
          for (var element in startTimes) {
            if (element['value'] == value) {
              schedulesList[index]['start_time_label'] = element['label'];
              break;
            }
          }
        } else {
          Get.defaultDialog(
            middleText: 'You already have an appointment at this time',
          );
        }
      }
    }
    update();
  }

  selectEndTime({
    required int index,
    required String value,
    required List endTimes,
  }) {
    if (index == 0 || index == schedulesList.length - 1) {
      schedulesList[index]['end_time_value'] = value;
      for (var element in endTimes) {
        if (element['value'] == value) {
          schedulesList[index]['end_time_label'] = element['label'];
          break;
        }
      }
    } else {
      schedulesList[index + 1]['start_time_value'] = null;
      schedulesList[index]['end_time_value'] = value;
      for (var element in endTimes) {
        if (element['value'] == value) {
          schedulesList[index]['end_time_label'] = element['label'];
          break;
        }
      }
    }
    if (value == endTimes[endTimes.length - 1]['value']) {
      for (int i = 0; i < schedulesList.length; i++) {
        if (i > index) {
          schedulesList.removeRange(i, schedulesList.length);
          break;
        }
      }
    }

    update();
  }

  timeCalculate({
    required int startHour,
    required int startMinutes,
    required int endHour,
    required int endMinutes,
  }) {
    TimeOfDay startTime = TimeOfDay(hour: startHour, minute: startMinutes);
    TimeOfDay endTime = TimeOfDay(hour: endHour, minute: endMinutes);

    startTimes = calculateTimeSlots(
      startTime: startTime,
      endTime: endTime,
    );
    update();
  }

  List<Map<String, dynamic>> calculateTimeSlots({
    required TimeOfDay startTime,
    required TimeOfDay endTime,
  }) {
    List<TimeOfDay> timeSlots = [];
    TimeOfDay currentTime = startTime;

    while (currentTime.hour < endTime.hour ||
        (currentTime.hour == endTime.hour &&
            currentTime.minute <= endTime.minute)) {
      timeSlots.add(currentTime);
      int nextMinute = currentTime.minute + int.parse(selectedTimeSlot);
      int nextHour = currentTime.hour + (nextMinute ~/ 60);
      nextMinute %= 60;
      // int newStartMinutes = nextMinute;
      // newStartMinutes %= 60;
      // if (nextMinute != 0 && newStartMinutes == 0) {
      //   nextMinute = 0;
      //   nextHour++;
      // } else {
      //   nextMinute = newStartMinutes;
      // }
      currentTime = TimeOfDay(hour: nextHour, minute: nextMinute);
    }

    List<Map<String, dynamic>> slots = [];
    String time;
    for (TimeOfDay element in timeSlots) {
      String hour;
      String minute;
      if (element.hour < 10) {
        hour = '0${element.hour}';
      } else {
        hour = '${element.hour}';
      }
      if (element.minute < 10) {
        minute = '0${element.minute}';
      } else {
        minute = '${element.minute}';
      }
      if (element.hour < 12) {
        if (element.hour == 0) {
          time = '12:$minute AM';
        } else {
          time = '$hour:$minute AM';
        }
      } else {
        if (int.parse(hour) < 10) {
          time = '0${int.parse(hour) - 12}:$minute PM';
        } else {
          time = int.parse(hour) == 12
              ? '$hour:$minute PM'
              : '${int.parse(hour) - 12}:$minute PM';
        }
      }

      Map<String, dynamic> slot = {
        'value': '$hour:$minute',
        'label': time,
      };
      slots.add(slot);
    }
    slots.removeLast();

    return slots;
  }

  List<Map<String, dynamic>> claculateEndTimes({
    required TimeOfDay selectedStartTime,
  }) {
    int startHour = selectedStartTime.hour + (selectedStartTime.minute ~/ 60);
    int startMinute = selectedStartTime.minute + int.parse(selectedTimeSlot);
    int newStartMinutes = startMinute;
    newStartMinutes %= 60;
    if (startMinute != 0 && newStartMinutes == 0) {
      startMinute = 0;
      startHour++;
    } else {
      startMinute = newStartMinutes;
    }
    TimeOfDay startTime = TimeOfDay(hour: startHour, minute: startMinute);
    TimeOfDay endTime = const TimeOfDay(hour: 24, minute: 00);
    List<Map<String, dynamic>> slots = [];

    slots = calculateTimeSlots(
      startTime: startTime,
      endTime: endTime,
    );
    return slots;
  }

  getSchedule() async {
    var res = await getScheduleRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200' ||
          responseModel.responseCode == '201') {
        schedulesList = responseModel.scheduleList!;
        update();
      }
    }
  }

  updateSchedule() async {
    if (selectedDays.isEmpty) {
      Get.defaultDialog(
        middleText: 'Please select days',
      );
    } else {
      loading();
      var res = await updateScheduleRequest();
      if (res is RequsetStatus == false) {
        ResponseModel responseModel = ResponseModel.fromJson(res);
        if (responseModel.responseCode == '200') {
          Get.back();
          Fluttertoast.showToast(
            msg: 'Added Successfully',
            textColor: AppColors.black,
            backgroundColor: AppColors.secondaryColor,
          );
        } else if (responseModel.responseCode == '500') {
          await getSchedule();
          Fluttertoast.showToast(
            msg: 'Deleted Successfully',
            textColor: AppColors.black,
            backgroundColor: AppColors.secondaryColor,
          );
        }
      }
      Get.back();
    }
  }

  changeSlotDuration({required String slotDuration}) {
    if (schedulesList.isNotEmpty) {
      Get.defaultDialog(
        middleText: 'All schedules will be removed',
        actions: [
          MaterialButton(
            onPressed: () {
              Get.back();
            },
            color: AppColors.primaryColor,
            child: Text(
              'Cancel',
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontSize: AppDecoration().screenWidth * 0.04,
                fontWeight: FontWeight.bold,
                fontFamily: AppDecoration.cairo,
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              selectedTimeSlot = slotDuration;
              timeCalculate(
                startHour: 00,
                startMinutes: 00,
                endHour: 24,
                endMinutes: 0,
              );
              schedulesList.clear();
              Get.back();
            },
            color: AppColors.primaryColor,
            child: Text(
              'Continue',
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontSize: AppDecoration().screenWidth * 0.04,
                fontWeight: FontWeight.bold,
                fontFamily: AppDecoration.cairo,
              ),
            ),
          ),
        ],
      );
    } else {
      selectedTimeSlot = slotDuration;
      timeCalculate(
        startHour: 00,
        startMinutes: 00,
        endHour: 24,
        endMinutes: 0,
      );
      schedulesList.clear();
    }
  }

  changeDay({required String newSelectedDay}) async {
    selectedDay = newSelectedDay;
    loading();
    await getSchedule();
    Get.back();
    update();
  }

  getScheduleRequest() async {
    var res = await crud.connect(
      link: AppLinks.getSchedule,
      data: {
        'day_id': selectedDay,
      },
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  updateScheduleRequest() async {
    var res = await crud.connect(
      link: AppLinks.addSchedule,
      data: {
        'booking_details': jsonEncode(schedulesList),
        'day_id': selectedDays.toString(),
      },
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
        'timezone': 'Asia/Kolkata',
      },
    );
    return res.fold((l) => l, (r) => r);
  }
}
