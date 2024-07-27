import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/doctors/notify_me_controller.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';
import 'package:teleprac/view/widgets/appointment_screen/notify_me_screen/fields.dart';
import 'package:teleprac/core/const/colors.dart';

class NotifyMeScreen extends StatelessWidget {
  const NotifyMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NotifyMeController controller = Get.put(NotifyMeController());

    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            const UpperPart(
              text: AppTexts.notifyMe,
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.1),
            const NotifyMeFields(),
            SizedBox(height: AppDecoration().screenHeight * 0.1),
            CustomButton(
              function: () {
                controller.notifyNext();
              },
              text: 'Confirm',
              textColor: AppColors.secondaryColor,
              buttonColor: AppColors.primaryColor,
              circularRadius: 10,
              width: 0.7,
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.02),
          ],
        ),
      ),
    );
  }
}
