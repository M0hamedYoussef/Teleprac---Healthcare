import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/main_controller.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/home/design/design_image_container.dart';

class DesignImages extends GetView<MainController> {
  const DesignImages({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DesignImageContainer(
              onTap: controller.onlineConsultation,
              imagePath: AppDecoration.homeConsult,
              text: AppTexts.onlineCosultationLabel,
            ),
            SizedBox(width: AppDecoration().screenWidth * 0.05),
            DesignImageContainer(
              onTap: controller.onlinePharmacy,
              imagePath: AppDecoration.homePharmacy,
              text: AppTexts.onlinePharmacyLabel,
            ),
          ],
        ),
        SizedBox(height: AppDecoration().screenHeight * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DesignImageContainer(
              onTap: controller.diagnosticTests,
              imagePath: AppDecoration.homeDia,
              text: AppTexts.diagnosticTestLabel,
            ),
            SizedBox(width: AppDecoration().screenWidth * 0.05),
            DesignImageContainer(
              onTap: controller.goToHomeSample,
              imagePath: AppDecoration.homeSample,
              text: AppTexts.homeCollectionLabel,
            ),
          ],
        ),
      ],
    );
  }
}
    //  SizedBox(
        //   height: AppDecoration().screenHeight * 0.15,
        //   child: ListView(
        //     scrollDirection: Axis.horizontal,
        //     shrinkWrap: true,
        //     children: [
        //       SizedBox(width: AppDecoration().screenWidth * 0.01),
        //       DesignImageContainer(
        //         onTap: controller.onlineConsultation,
        //         imagePath: AppDecoration.homeConsult,
        //         text: AppTexts.onlineCosultationLabel,
        //       ),
        //       DesignImageContainer(
        //         onTap: controller.onlinePharmacy,
        //         imagePath: AppDecoration.homePharmacy,
        //         text: AppTexts.onlinePharmacyLabel,
        //       ),
        //       DesignImageContainer(
        //         onTap: controller.diagnosticTests,
        //         imagePath: AppDecoration.homeDia,
        //         text: AppTexts.diagnosticTestLabel,
        //       ),
        //       DesignImageContainer(
        //         onTap: controller.goToHomeSample,
        //         imagePath: AppDecoration.homeSample,
        //         text: AppTexts.homeCollectionLabel,
        //       ),
        //       SizedBox(width: AppDecoration().screenWidth * 0.01),
        //     ],
        //   ),
        // );
