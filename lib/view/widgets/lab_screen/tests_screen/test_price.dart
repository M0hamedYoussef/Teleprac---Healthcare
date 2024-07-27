import 'package:flutter/material.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/model/labs/tests/test_model.dart';

class TestsPrice extends StatelessWidget {
  const TestsPrice({
    super.key,
    required this.testModel,
  });
  final TestModel testModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          if (testModel.discount == '0' ||
              testModel.discount == null ||
              testModel.discount!.isEmpty)
            SizedBox(
              width: AppDecoration().screenWidth * 0.5,
              child: Text(
                'Total Price : ${AppTexts.indianRupee} ${testModel.amount!.split('.')[0]}',
                style: TextStyle(
                  fontSize: AppDecoration().screenWidth * 0.045,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppDecoration.cairo,
                ),
              ),
            ),
          if (testModel.discount != '0' &&
              testModel.discount != null &&
              testModel.discount!.isNotEmpty)
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
                    testModel.mrp!.split('.')[0],
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
                    testModel.amount!.split('.')[0],
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
    );
  }
}
