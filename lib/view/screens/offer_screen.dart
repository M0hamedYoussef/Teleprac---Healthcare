import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/offers_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/home/offers/offer_screen/offer_content.dart';
import 'package:teleprac/view/widgets/home/offers/offer_screen/offer_image.dart';
import 'package:teleprac/view/widgets/home/offers/offer_screen/offer_name.dart';
import 'package:teleprac/view/widgets/home/offers/offer_screen/offer_middle_text.dart';
import 'package:teleprac/view/widgets/home/offers/offer_screen/offer_products_list.dart';
import 'package:teleprac/view/widgets/home/offers/offer_screen/offer_tests_list.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OffersController controller = Get.put(OffersController());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: WillPopScope(
        onWillPop: controller.willPop,
        child: SafeArea(
          child: Column(
            children: [
              const UpperPart(
                text: AppTexts.offerScreen,
                changeStatusbarColor: true,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      SizedBox(height: AppDecoration().screenHeight * .02),
                      const OfferImage(),
                      SizedBox(height: AppDecoration().screenHeight * .02),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.secondaryColor,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            const OfferName(),
                            SizedBox(
                                height: AppDecoration().screenHeight * .015),
                            const OfferContent(),
                            SizedBox(
                                height: AppDecoration().screenHeight * .01),
                          ],
                        ),
                      ),
                      SizedBox(height: AppDecoration().screenHeight * .01),
                      const OfferMiddleText(),
                      SizedBox(height: AppDecoration().screenHeight * .01),
                      if (controller.offerTests.isEmpty)
                        const OfferProductsList(),
                      if (controller.offerTests.isNotEmpty)
                        const OfferTestsList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
