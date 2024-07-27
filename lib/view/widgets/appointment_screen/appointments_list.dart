import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/doctors/appointment_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/model/doctors/session_model.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';

class AppointmentsList extends StatelessWidget {
  const AppointmentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        physics: const BouncingScrollPhysics(
          parent: PageScrollPhysics(),
        ),
        padding: const EdgeInsets.only(
          left: 20,
          top: 15,
          right: 20,
        ),
        children: [
          GetBuilder<AppointmentController>(
            builder: (controller) {
              if (controller.sessions.isEmpty ||
                  (controller.sessions.length == 1 &&
                      controller.sessions[0].tokenDetails!.isEmpty)) {
                return Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: AppDecoration().screenHeight * 0.2,
                      ),
                      SizedBox(
                        height: AppDecoration().screenHeight * 0.05,
                        child: Text(
                          AppTexts.noAppointments,
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: AppDecoration().screenWidth * 0.053,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppDecoration.cairo,
                            height: 1,
                          ),
                        ),
                      ),
                      if (controller.nextAvailable != null)
                        SizedBox(
                          height: AppDecoration().screenHeight * 0.065,
                          child: Text(
                            'Available On ${controller.nextAvailable}',
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: AppDecoration().screenWidth * 0.05,
                              fontWeight: FontWeight.w300,
                              fontFamily: AppDecoration.cairo,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      CustomButton(
                        function: () {
                          controller.notifyMe();
                        },
                        buttonColor: AppColors.primaryColor,
                        circularRadius: 10,
                        text: 'Notify Me When Available',
                      ),
                      SizedBox(
                        height: controller.nextAvailable == null
                            ? AppDecoration().screenHeight * 0.25
                            : AppDecoration().screenHeight * 0.2,
                      ),
                    ],
                  ),
                );
              } else {
                return SizedBox(
                  height: AppDecoration().screenHeight * 0.07,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(
                      parent: PageScrollPhysics(),
                    ),
                    itemCount: controller.sessions.length,
                    itemBuilder: (context, sessionIndex) {
                      if (controller
                          .sessions[sessionIndex].tokenDetails!.isEmpty) {
                        return const SizedBox();
                      } else {
                        return GetBuilder<AppointmentController>(
                          builder: (_) {
                            return FittedBox(
                              child: GestureDetector(
                                onTap: () {
                                  controller.selectedSessionIndex =
                                      sessionIndex;
                                  controller.selectedTokenIndex = null;
                                  controller.update();
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: controller.selectedSessionIndex ==
                                            sessionIndex
                                        ? AppColors.primaryColor
                                        : AppColors.secondaryColor,
                                  ),
                                  padding: const EdgeInsets.all(20),
                                  margin:
                                      const EdgeInsets.only(left: 6, right: 6),
                                  child: Text(
                                    'SESSION ${sessionIndex + 1} ',
                                    style: TextStyle(
                                      fontFamily: AppDecoration.cairo,
                                      fontWeight: FontWeight.w400,
                                      color: controller.selectedSessionIndex ==
                                              sessionIndex
                                          ? AppColors.secondaryColor
                                          : AppColors.grey,
                                      fontSize:
                                          AppDecoration().screenWidth * 0.06,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                );
              }
            },
          ),
          SizedBox(
            height: AppDecoration().screenHeight * 0.01,
          ),
          GetBuilder<AppointmentController>(
            builder: (controller) {
              if (controller.selectedSessionIndex != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SESSIONS',
                      style: TextStyle(
                        fontFamily: AppDecoration.cairo,
                        fontSize: AppDecoration().screenWidth * 0.04,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey,
                      ),
                    ),
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.5,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller
                          .sessions[controller.selectedSessionIndex!]
                          .tokenDetails!
                          .length,
                      itemBuilder: (context, index) {
                        TokenDetailsModel tokenDetailsModel = controller
                            .sessions[controller.selectedSessionIndex!]
                            .tokenDetails![index];
                        bool notAvailable = tokenDetailsModel.tokenType == '1';
                        bool available = !notAvailable;

                        return GestureDetector(
                          onTap: () {
                            if (available) {
                              controller.selectSlot(
                                token: index,
                              );
                            } else {
                              Get.defaultDialog(
                                middleText: 'This Appointment Isn\'t Available',
                              );
                            }
                          },
                          child: FittedBox(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: available
                                    ? controller.selectedTokenIndex == index
                                        ? AppColors.primaryColor
                                        : AppColors.secondaryColor
                                    : AppColors.red,
                              ),
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(8),
                              child: Text(
                                tokenDetailsModel.tokenStartTime!,
                                style: TextStyle(
                                  fontFamily: AppDecoration.cairo,
                                  fontWeight: FontWeight.w400,
                                  color: available
                                      ? controller.selectedTokenIndex == index
                                          ? AppColors.secondaryColor
                                          : AppColors.grey
                                      : AppColors.secondaryColor,
                                  fontSize: AppDecoration().screenWidth * 0.035,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          SizedBox(
            height: AppDecoration().screenHeight * 0.01,
          ),
        ],
      ),
    );
  }
}
/**
 * 
 *       // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       AppTexts.session,
          //       style: TextStyle(
          //         color: AppColors.primaryColor,
          //         fontSize: AppDecoration().screenWidth * 0.044,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //     GetBuilder<AppointmentController>(
          //       builder: (controller) {
          //         return Text(
          //           DateFormat('dd/MM/yyyy')
          //               .format(DateTime.parse(controller.appointmentDate)),
          //           style: TextStyle(
          //             color: AppColors.primaryColor,
          //             fontSize: AppDecoration().screenWidth * 0.044,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         );
          //       },
          //     ),
          //   ],
          // ),
          /////////////////////
          ///  //   return SizedBox(
                //     height: AppDecoration().screenHeight * 0.57,
                //     child: ListView.builder(
                //       physics: const BouncingScrollPhysics(
                //         parent: PageScrollPhysics(),
                //       ),
                //       itemCount: controller.sessions.length,
                //       itemBuilder: (context, sessionIndex) {
                //         if (controller
                //             .sessions[sessionIndex].tokenDetails!.isEmpty) {
                //           return const SizedBox();
                //         } else {
                //           return Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               SizedBox(
                //                 height: AppDecoration().screenHeight * 0.01,
                //               ),
                //               Text(
                //                 'SESSION ${sessionIndex + 1}',
                //                 style: TextStyle(
                //                   color: AppColors.primaryColor,
                //                   fontSize: AppDecoration().screenWidth * 0.044,
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //               ),
                //               GridView.builder(
                //                 gridDelegate:
                //                     const SliverGridDelegateWithFixedCrossAxisCount(
                //                   crossAxisCount: 3,
                //                   childAspectRatio: 1.5,
                //                 ),
                //                 shrinkWrap: true,
                //                 physics: const NeverScrollableScrollPhysics(),
                //                 itemCount: controller
                //                     .sessions[sessionIndex].tokenDetails!.length,
                //                 itemBuilder: (context, index) {
                //                   TokenDetailsModel tokenDetailsModel = controller
                //                       .sessions[sessionIndex]
                //                       .tokenDetails![index];
                //                   Color? available;

                //                   available = tokenDetailsModel.tokenType == '1'
                //                       ? AppColors.red
                //                       : AppColors.primaryColor;

                //                   return Row(
                //                     children: [
                //                       Container(
                //                         width: AppDecoration().screenWidth * 0.05,
                //                         decoration: BoxDecoration(
                //                           color: available,
                //                           border: (controller
                //                                           .selectedSessionIndex ==
                //                                       sessionIndex &&
                //                                   controller.selectedTokenIndex ==
                //                                       index)
                //                               ? Border.all(
                //                                   color: AppColors.primaryColor,
                //                                 )
                //                               : null,
                //                         ),
                //                         padding: const EdgeInsets.only(
                //                           top: 10,
                //                           bottom: 10,
                //                         ),
                //                         child: const Text(''),
                //                       ),
                //                       GestureDetector(
                //                         onTap: () {
                //                           if (available ==
                //                               AppColors.primaryColor) {
                //                             controller.selectSlot(
                //                               token: index,
                //                               session: sessionIndex,
                //                             );
                //                           }
                //                         },
                //                         child: Container(
                //                           width:
                //                               AppDecoration().screenWidth * 0.2,
                //                           decoration: BoxDecoration(
                //                             color: AppColors.secondaryColor,
                //                             border: (controller
                //                                             .selectedSessionIndex ==
                //                                         sessionIndex &&
                //                                     controller
                //                                             .selectedTokenIndex ==
                //                                         index)
                //                                 ? Border.all(
                //                                     color: AppColors.primaryColor,
                //                                   )
                //                                 : null,
                //                           ),
                //                           padding: const EdgeInsets.only(
                //                             top: 10,
                //                             bottom: 10,
                //                           ),
                //                           child: Text(
                //                             tokenDetailsModel.tokenStartTime!,
                //                             style: const TextStyle(
                //                               color: AppColors.blue,
                //                               fontWeight: FontWeight.w700,
                //                             ),
                //                             textAlign: TextAlign.center,
                //                           ),
                //                         ),
                //                       ),
                //                     ],
                //                   );
                //                 },
                //               ),
                //             ],
                //           );
                //         }
                //       },
                //     ),
                //   );
 */