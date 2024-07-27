import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/notifications_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/home/notification_model.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';
import 'package:teleprac/view/widgets/global/user_image.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationsController controller = Get.put(NotificationsController());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: SafeArea(
        child: Column(
          children: [
            const UpperPart(
              text: 'Notifications',
            ),
            SizedBox(
              height: AppDecoration().screenHeight * 0.02,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.notifications.length,
                physics:
                    const BouncingScrollPhysics(parent: PageScrollPhysics()),
                itemBuilder: (context, index) {
                  NotificationModel notificationModel =
                      NotificationModel.fromJson(
                    controller.notifications.reversed.toList()[index],
                  );

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
                    child: Row(
                      children: [
                        if (notificationModel.image != null)
                          UserImage(
                            image: notificationModel.image!,
                            withGradient: false,
                          ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: notificationModel.image != null
                                    ? AppDecoration().screenWidth * 0.5
                                    : AppDecoration().screenWidth * 0.8,
                                child: Text(
                                  notificationModel.title!,
                                  style: TextStyle(
                                    fontSize:
                                        AppDecoration().screenWidth * 0.05,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black,
                                    fontFamily: AppDecoration.cairo,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: notificationModel.image != null
                                    ? AppDecoration().screenWidth * 0.5
                                    : AppDecoration().screenWidth * 0.8,
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize:
                                          AppDecoration().screenWidth * 0.042,
                                      fontWeight: FontWeight.w200,
                                      color: AppColors.black.withOpacity(0.8),
                                      fontFamily: AppDecoration.cairo,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: notificationModel.user != null
                                            ? '${notificationModel.user!} '
                                            : '',
                                      ),
                                      TextSpan(
                                        text: notificationModel.message != null
                                            ? '${notificationModel.message!} '
                                            : '',
                                      ),
                                      TextSpan(
                                        text: notificationModel.userTo != null
                                            ? notificationModel.userTo!
                                            : '',
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
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
