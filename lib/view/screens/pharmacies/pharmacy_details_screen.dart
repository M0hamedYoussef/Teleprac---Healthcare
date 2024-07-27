import 'package:flutter/material.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/global/custom_container.dart';
import 'package:teleprac/view/widgets/pharmacies/pharmacy_details_screen/lower_part.dart';
import 'package:teleprac/view/widgets/pharmacies/pharmacy_details_screen/pharmacy_name_row.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';
import 'package:teleprac/view/widgets/pharmacies/pharmacy_details_screen/pharmacy_image.dart';
import 'package:teleprac/view/widgets/pharmacies/pharmacy_details_screen/pharmacy_info.dart';

class PharmacyDetailsScreen extends StatelessWidget {
  const PharmacyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UpperPart(
              text: AppTexts.pharmacyProfile,
            ),
            Expanded(
              child: CustomContainer(
                margin: const EdgeInsets.only(left: 8, right: 8),
                height: 1,
                children: [
                  SizedBox(height: AppDecoration().screenHeight * .02),
                  const PharmacyImage(),
                  SizedBox(height: AppDecoration().screenHeight * .02),
                  const PharmacyNameRow(),
                  SizedBox(height: AppDecoration().screenHeight * .015),
                  const PharmacyInfo(),
                  SizedBox(height: AppDecoration().screenHeight * .015),
                ],
              ),
            ),
            const LowerPart(),
          ],
        ),
      ),
    );
  }
}
