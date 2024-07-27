import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/model/labs/tests/advanced_test_model.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';

class LowerPart extends StatelessWidget {
  const LowerPart({
    super.key,
    required this.advancedTestModel,
    required this.bookTest,
    this.buttonText = AppTexts.bookTest,
  });
  final AdvancedTestModel advancedTestModel;
  final String buttonText;
  final Function() bookTest;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              if (advancedTestModel.testDetails!.discount == '0' ||
                  advancedTestModel.testDetails!.discount == null ||
                  advancedTestModel.testDetails!.discount!.isEmpty)
                SizedBox(
                  width: AppDecoration().screenWidth * 0.5,
                  child: Text(
                    'Total Price : ${AppTexts.indianRupee} ${advancedTestModel.testDetails!.amount}',
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.045,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppDecoration.cairo,
                    ),
                  ),
                ),
              if (advancedTestModel.testDetails!.discount != '0' &&
                  advancedTestModel.testDetails!.discount != null &&
                  advancedTestModel.testDetails!.discount!.isNotEmpty)
                Row(
                  children: [
                    Text(
                      'Total Price : ${AppTexts.indianRupee} ',
                      style: TextStyle(
                        fontSize: AppDecoration().screenWidth * 0.045,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppDecoration.cairo,
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: AppDecoration().screenWidth * 0.2,
                      ),
                      child: Text(
                        advancedTestModel.testDetails!.mrp!,
                        style: TextStyle(
                          fontSize: AppDecoration().screenWidth * 0.04,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.lineThrough,
                          decorationThickness: 2.5,
                          height: 1,
                        ),
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: AppDecoration().screenWidth * 0.3,
                      ),
                      margin: const EdgeInsets.only(left: 5),
                      child: Text(
                        advancedTestModel.testDetails!.amount!,
                        style: TextStyle(
                          fontSize: AppDecoration().screenWidth * 0.05,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                          fontFamily: AppDecoration.cairo,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: CustomButton(
            function: bookTest,
            text: buttonText,
            fontSize: 0.045,
            buttonColor: AppColors.primaryColor,
            circularRadius: 10,
          ),
        ),
      ],
    );
  }
}
