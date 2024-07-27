import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/global/custom_container.dart';
import 'package:teleprac/view/widgets/lab_screen/lab_details_screen/lab_info.dart';
import 'package:teleprac/view/widgets/lab_screen/lab_details_screen/lab_bio.dart';
import 'package:teleprac/view/widgets/lab_screen/lab_details_screen/lab_image.dart';
import 'package:teleprac/view/widgets/lab_screen/lab_details_screen/lab_name_row.dart';
import 'package:teleprac/view/widgets/lab_screen/lab_details_screen/lower_part.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class LabDetailsScreen extends StatelessWidget {
  const LabDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: SafeArea(
        child: Column(
          children: [
            const UpperPart(
              text: AppTexts.labProfile,
            ),
            Expanded(
              child: CustomContainer(
                margin: const EdgeInsets.only(left: 8, right: 8),
                height: 1,
                children: [
                  SizedBox(height: AppDecoration().screenHeight * .02),
                  const LabImage(),
                  SizedBox(height: AppDecoration().screenHeight * .02),
                  const LabNameRow(),
                  SizedBox(height: AppDecoration().screenHeight * .015),
                  const LabInfo(),
                  SizedBox(height: AppDecoration().screenHeight * .015),
                  const LabBio(),
                  SizedBox(height: AppDecoration().screenHeight * .005),
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
