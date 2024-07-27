import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';

class PharmacyOptions extends StatelessWidget {
  const PharmacyOptions(
      {super.key, required this.details, required this.viewProducts});
  final void Function() details;
  final void Function() viewProducts;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomButton(
              function: details,
              text: AppTexts.details,
              opacity: 0.45,
              margin: null,
              textColor: AppColors.secondaryColor,
              buttonColor: AppColors.primaryColor,
            ),
          ),
          SizedBox(width: AppDecoration().screenWidth * 0.035),
          Expanded(
            child: CustomButton(
              function: viewProducts,
              opacity: 0.45,
              margin: null,
              buttonColor: AppColors.primaryColor,
              textColor: AppColors.secondaryColor,
              text: AppTexts.viewProducts,
            ),
          ),
        ],
      ),
    );
  }
}
