import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/doctors/doctor_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';

class LowerPart extends GetView<DoctorController> {
  const LowerPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 40, right: 8, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // if (controller.advancedDoctorModel.doctorDetails!.priceType!
          //         .toLowerCase() !=
          //     'free')
          //   Text(
          //     '${controller.advancedDoctorModel.doctorDetails!.currency!} ${controller.advancedDoctorModel.doctorDetails!.amount!}',
          //     style: TextStyle(
          //       color: AppColors.primaryColor,
          //       fontWeight: FontWeight.bold,
          //       fontSize: AppDecoration().screenWidth * 0.076,
          //     ),
          //   ),
          // if (controller.advancedDoctorModel.doctorDetails!.priceType!
          //         .toLowerCase() ==
          //     'free')
          //   Text(
          //     'Free',
          //     style: TextStyle(
          //       color: AppColors.primaryColor,
          //       fontWeight: FontWeight.bold,
          //       fontSize: AppDecoration().screenWidth * 0.07,
          //     ),
          //   ),
          Expanded(
            child: GetBuilder<DoctorController>(
              builder: (_) {
                return CustomButton(
                  function: () {
                    controller.addToFavourites();
                  },
                  margin: null,
                  customWidget: Icon(
                    controller.isFavourite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color: AppColors.primaryColor,
                  ),
                  elevation: 0,
                  buttonColor: const Color.fromARGB(255, 175, 228, 206),
                );
              },
            ),
          ),
          Expanded(
            flex: 4,
            child: CustomButton(
              function: controller.bookApp,
              margin: const EdgeInsets.only(left: 10, right: 10),
              text: AppTexts.bookAppointment0,
              fontSize: 0.045,
              buttonColor: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
