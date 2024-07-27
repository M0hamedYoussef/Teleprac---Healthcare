import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard/my_patients/patient_profile/patient_profile_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class MedicineTimes extends GetView<PatientProfileController> {
  const MedicineTimes({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    List medicineTimes =
        controller.medicines[index]['time'].toString().split(',');

    return Container(
      width: AppDecoration().screenWidth * 0.9,
      height: AppDecoration().screenHeight * 0.045,
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: ListView.builder(
        itemCount: medicineTimes.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, typeIndex) {
          String thisSlot = medicineTimes[typeIndex];

          return GestureDetector(
            onTap: () {
              Get.defaultDialog(
                title: 'Alert',
                middleText:
                    'Do You Want To Delete "${controller.medicines[index]['time'].toString().split(',')[typeIndex]}" ?',
                titleStyle: const TextStyle(
                  color: AppColors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppDecoration.cairo,
                ),
                middleTextStyle: const TextStyle(
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppDecoration.cairo,
                ),
                actions: [
                  MaterialButton(
                    onPressed: () {
                      Get.back();
                    },
                    color: AppColors.primaryColor,
                    child: const Text(
                      'No',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppDecoration.cairo,
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (typeIndex == 0 && medicineTimes.length == 1) {
                        controller.medicines[index]['time'] = '';
                      } else if (medicineTimes.length == typeIndex + 1) {
                        controller.medicines[index]['time'] = controller
                            .medicines[index]['time']
                            .toString()
                            .replaceAll(',$thisSlot', '');
                      } else {
                        controller.medicines[index]['time'] = controller
                            .medicines[index]['time']
                            .toString()
                            .replaceAll('$thisSlot,', '');
                      }

                      controller.update();
                      Get.back();
                    },
                    color: AppColors.primaryColor,
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppDecoration.cairo,
                      ),
                    ),
                  ),
                ],
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.medicines[index]['time']
                        .toString()
                        .split(',')[typeIndex],
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: AppDecoration().screenWidth * 0.04,
                    ),
                  ),
                  SizedBox(width: AppDecoration().screenWidth * 0.01),
                  const Icon(
                    Icons.close,
                    color: AppColors.secondaryColor,
                    size: 15,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
