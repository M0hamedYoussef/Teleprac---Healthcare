import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard/my_favourites_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/doctors/doctors_model.dart';
import 'package:teleprac/view/widgets/global/user_image.dart';
import 'package:teleprac/view/widgets/search_screen/doctor_info.dart';
import 'package:teleprac/view/widgets/search_screen/doctor_options.dart';

class MyFavouritesList extends StatelessWidget {
  const MyFavouritesList({super.key});

  @override
  Widget build(BuildContext context) {
    MyFavouritesController controller = Get.find();
    return Expanded(
      child: ListView.builder(
        itemCount: controller.myFavourites.length,
        physics: const BouncingScrollPhysics(parent: PageScrollPhysics()),
        itemBuilder: (context, index) {
          DoctorModel doctorModel = DoctorModel.fromJson(
            controller.myFavourites[index],
          );
          if (doctorModel.id != null) {
            return Column(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.primaryColor),
                      height: AppDecoration().screenHeight * 0.18 + 10,
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
                      height: AppDecoration().screenHeight * 0.18,
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
      ),
    );
  }
}
