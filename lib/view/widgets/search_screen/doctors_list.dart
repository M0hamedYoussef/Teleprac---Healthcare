import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/main_controller.dart';
import 'package:teleprac/controller/search_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/doctors/doctors_model.dart';
import 'package:teleprac/view/widgets/search_screen/doctor_info.dart';
import 'package:teleprac/view/widgets/global/user_image.dart';
import 'package:teleprac/view/widgets/search_screen/doctor_options.dart';

class DoctorsList extends GetView<MainController> {
  const DoctorsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<SearchCon>(
        builder: (searchCon) {
          return ListView.builder(
            itemCount: controller.allDoctors.length,
            physics: const BouncingScrollPhysics(parent: PageScrollPhysics()),
            itemBuilder: (context, index) {
              DoctorModel doctorModel = DoctorModel.fromJson(
                controller.allDoctors[index],
              );

              if (searchCon.doctorSearchValidate(doctorModel: doctorModel)) {
                return Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.primaryColor),
                          height: AppDecoration().screenHeight * 0.2 + 10,
                          margin: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                            color: AppColors.secondaryColor,
                          ),
                          height: AppDecoration().screenHeight * 0.2,
                          margin: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          padding: const EdgeInsets.only(
                            top: 8,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: AppDecoration().screenHeight * 0.02,
                              ),
                              UserImage(
                                image: doctorModel.profileimage!,
                                withGradient: false,
                                padding: EdgeInsets.zero,
                              ),
                              SizedBox(
                                width: AppDecoration().screenHeight * 0.01,
                              ),
                              DoctorDetails(
                                doctorModel: doctorModel,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 20,
                      ),
                      child: DoctorOptions(
                        viewProfile: () {
                          controller.viewDoctor(
                            doctorModel: doctorModel,
                          );
                        },
                        bookNow: () {
                          controller.bookNow(
                            doctorModel: doctorModel,
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          );
        },
      ),
    );
  }
}
/* NEW V1
Container(
                  margin: const EdgeInsets.fromLTRB(25, 8, 25, 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.secondaryColor,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      controller.viewDoctor(
                        doctorModel: doctorModel,
                      );
                    },
                    child: Row(
                      children: [
                        UserImage(
                          image: doctorModel.profileimage!,
                          withGradient: false,
                          circularRadius: 10,
                          height: 0.1,
                          width: 0.1,
                        ),
                        Expanded(
                          child: DoctorDetails(doctorModel: doctorModel),
                        ),
                      ],
                    ),
                  ),
                );
 *
*/
/* OLD
Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.secondaryColor,
                  ),
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width:
                                          AppDecoration().screenHeight * 0.01,
                                    ),
                                    UserImage(
                                      image: doctorModel.profileimage!,
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: AppDecoration().screenHeight * 0.012,
                                top: AppDecoration().screenHeight * 0.025,
                                child: DoctorDetails(
                                  doctorModel: doctorModel,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AppDecoration().screenHeight * 0.01,
                      ),
                      DoctorOptions(
                        viewProfile: () {
                          controller.viewDoctor(
                            doctorModel: doctorModel,
                          );
                        },
                        bookNow: () {
                          controller.bookNow(
                            doctorModel: doctorModel,
                          );
                        },
                      ),
                      SizedBox(
                        height: AppDecoration().screenHeight * 0.01,
                      ),
                    ],
                  ),
                );
 */
