import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/doctors/doctors_model.dart';
import 'package:teleprac/view/widgets/global/shimmer_placeholder.dart';

class DoctorContainer extends StatelessWidget {
  const DoctorContainer({
    super.key,
    required this.doctorModel,
    required this.viewFunction,
    required this.consultFunction,
  });
  final DoctorModel doctorModel;
  final void Function() viewFunction;
  final void Function() consultFunction;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              viewFunction();
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: doctorModel.profileimage!,
                        placeholder: (context, _) {
                          return const CustomShimmerPlaceHolder(
                            // width: 0.36,
                            height: 0.13,
                            margin: null,
                          );
                        },
                        // width: AppDecoration().screenWidth * 0.3,
                        height: AppDecoration().screenHeight * 0.13,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text(
                    doctorModel.fullName!.length >= 16
                        ? '${doctorModel.fullName!.substring(0, 15)}...'
                        : doctorModel.fullName!,
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: AppDecoration().screenWidth * 0.04,
                      fontWeight: FontWeight.w700,
                      fontFamily: AppDecoration.cairo,
                    ),
                  ),
                  Text(
                    doctorModel.speciality!.length >= 16
                        ? '${doctorModel.speciality!.substring(0, 15)}...'
                        : doctorModel.speciality!,
                    style: TextStyle(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: AppDecoration().screenWidth * 0.035,
                      fontFamily: AppDecoration.cairo,
                    ),
                  ),
                  // SizedBox(
                  //   height: AppDecoration().screenHeight * 0.01,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //     left: 8.0,
                  //     top: 6,
                  //     bottom: 6,
                  //     right: 8.0,
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       CustomButton(
                  //         function: viewFunction,
                  //         opacity: 0.45,
                  //         margin: null,
                  //         textColor: AppColors.black,
                  //         fontSize: 12,
                  //         height: 0.03,
                  //         text: AppTexts.view,
                  //       ),
                  //       SizedBox(
                  //         width: AppDecoration().screenWidth * 0.01,
                  //       ),
                  //       CustomButton(
                  //         function: consultFunction,
                  //         opacity: 0.45,
                  //         margin: null,
                  //         textColor: AppColors.black,
                  //         fontSize: 12,
                  //         height: 0.03,
                  //         text: AppTexts.consult,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
