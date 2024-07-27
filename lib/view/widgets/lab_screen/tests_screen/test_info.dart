import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/labs/tests/test_model.dart';

class TestDetails extends StatelessWidget {
  const TestDetails({super.key, required this.testModel});
  final TestModel testModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  testModel.labTestName!,
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppDecoration.cairo,
                    fontSize: AppDecoration().screenWidth * 0.045,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'LAB: ',
                        style: TextStyle(
                          color: AppColors.red,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppDecoration.cairo,
                          fontSize: AppDecoration().screenWidth * 0.042,
                        ),
                      ),
                      TextSpan(
                        text: testModel.labName!,
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppDecoration.cairo,
                          fontSize: AppDecoration().screenWidth * 0.042,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            if (testModel.discount != '0' &&
                testModel.discount != null &&
                testModel.discount!.isNotEmpty)
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    AppDecoration.discount,
                    width: AppDecoration().screenWidth * 0.14,
                  ),
                  Text(
                    '${testModel.discount}%\noff',
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.042,
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
