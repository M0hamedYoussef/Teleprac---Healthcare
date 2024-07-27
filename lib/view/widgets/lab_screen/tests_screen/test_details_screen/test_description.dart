import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/model/labs/tests/advanced_test_model.dart';

class TestDescription extends StatelessWidget {
  const TestDescription({super.key, required this.advancedTestModel});
  final AdvancedTestModel advancedTestModel;
  @override
  Widget build(BuildContext context) {
    if (advancedTestModel.testDetails!.description != null &&
        advancedTestModel.testDetails!.description!.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Image.asset(
              //   AppDecoration.info,
              //   width: AppDecoration().screenWidth * 0.1,
              // ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppTexts.testDescription,
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.08,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                      fontFamily: AppDecoration.cairo,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20),
          //   child: RichText(
          //     text: TextSpan(
          //       children: [
          //         ...List.generate(
          //           advancedTestModel.testDetails!.description!
          //               .split('\n')
          //               .length,
          //           (index) {
          //             return TextSpan(
          //               text:
          //                   '\n${advancedTestModel.testDetails!.description!.split('\n')[index].trim()}',
          //               style: TextStyle(
          //                 color: AppColors.black,
          //                 fontWeight: FontWeight.w500,
          //                 fontSize: AppDecoration().screenWidth * .05,
          //                 wordSpacing: 1,
          //                 height: 1.4,
          //               ),
          //             );
          //           },
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: HtmlWidget(
              advancedTestModel.testDetails!.description!,
              textStyle: TextStyle(
                color: AppColors.black.withOpacity(0.8),
                fontWeight: FontWeight.w300,
                fontSize: AppDecoration().screenWidth * .047,
                wordSpacing: 2,
                height: 1.4,
              ),
            ),
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
