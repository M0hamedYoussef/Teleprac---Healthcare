import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/main_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/model/doctors/doctors_model.dart';
import 'package:teleprac/view/widgets/global/shimmer_placeholder.dart';
import 'package:teleprac/view/widgets/home/doctors/doctor_container.dart';

class TopDoctors extends GetView<MainController> {
  const TopDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppTexts.topRated,
                style: TextStyle(
                  fontSize: AppDecoration().screenWidth * 0.045,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppDecoration.cairo,
                  color: AppColors.grey,
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: () {
                  controller.seeAllDoctors();
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    AppTexts.seeAll,
                    style: TextStyle(
                      color: AppColors.grey,
                      fontFamily: AppDecoration.cairo,
                      fontSize: AppDecoration().screenWidth * 0.04,
                    ),
                  ),
                ),
              ),
              // CustomButton(
              //   function: controller.seeAllDoctors,
              //   opacity: 0.45,
              //   margin: null,
              //   textColor: AppColors.black,
              //   fontSize: 12,
              //   height: 0.03,
              //   text: AppTexts.seeAll,
              // ),
            ],
          ),
          SizedBox(
            height: AppDecoration().screenHeight * 0.02,
          ),
          SizedBox(
            height: AppDecoration().screenHeight * 0.23,
            child: GetBuilder<MainController>(
              builder: (_) {
                if (controller.topDoctors.isEmpty) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const CustomShimmerPlaceHolder(
                        height: 0.23,
                        width: 0.16,
                        margin: EdgeInsets.only(left: 10, right: 10),
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemCount: controller.topDoctors.length,
                    itemBuilder: (context, index) {
                      DoctorModel doctorModel =
                          DoctorModel.fromJson(controller.topDoctors[index]);
                      return DoctorContainer(
                        doctorModel: doctorModel,
                        viewFunction: () {
                          controller.viewDoctor(
                            doctorModel: doctorModel,
                          );
                        },
                        consultFunction: () {
                          controller.bookNow(doctorModel: doctorModel);
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
