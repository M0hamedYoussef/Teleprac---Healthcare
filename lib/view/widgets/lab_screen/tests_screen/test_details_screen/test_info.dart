import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/labs/tests/advanced_test_model.dart';

class TestInfo extends StatelessWidget {
  const TestInfo({super.key, required this.advancedTestModel});
  final AdvancedTestModel advancedTestModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            advancedTestModel.testDetails!.labTestName!,
            style: TextStyle(
              fontSize: AppDecoration().screenWidth * 0.08,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w400,
              height: 1.5,
              // fontFamily: AppDecoration.cairo,
            ),
          ),
          SizedBox(
            width: AppDecoration().screenWidth,
            child: Text(
              advancedTestModel.labDetails!.fullName!,
              style: TextStyle(
                fontSize: AppDecoration().screenWidth * 0.06,
                fontWeight: FontWeight.w100,
                fontFamily: AppDecoration.cairo,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
