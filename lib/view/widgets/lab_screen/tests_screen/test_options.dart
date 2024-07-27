import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';

class TestOptions extends StatelessWidget {
  const TestOptions({
    super.key,
    required this.details,
    this.width = 0.8,
    this.buttonColor = AppColors.primaryColor,
    this.textColor = AppColors.secondaryColor,
  });
  final void Function() details;
  final double width;
  final Color buttonColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: CustomButton(
          function: details,
          opacity: 0.45,
          margin: null,
          textColor: textColor,
          buttonColor: buttonColor,
          fontSize: 0.048,
          circularRadius: 10,
          width: width,
          text: AppTexts.details,
        ),
      ),
    );
  }
}
