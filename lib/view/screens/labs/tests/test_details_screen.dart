import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/labs/tests_controller.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/model/labs/tests/advanced_test_model.dart';
import 'package:teleprac/view/widgets/global/custom_container.dart';
import 'package:teleprac/view/widgets/lab_screen/tests_screen/test_details_screen/lower_part.dart';
import 'package:teleprac/view/widgets/lab_screen/tests_screen/test_details_screen/test_description.dart';
import 'package:teleprac/view/widgets/lab_screen/tests_screen/test_details_screen/test_info.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class TestDetailsScreen extends StatelessWidget {
  const TestDetailsScreen({
    super.key,
    required this.advancedTestModel,
  });
  final AdvancedTestModel advancedTestModel;
  @override
  Widget build(BuildContext context) {
    TestsController controller = Get.put(TestsController());
    return Scaffold(
      body: WillPopScope(
        onWillPop: controller.testDetailsWillPop,
        child: SafeArea(
          child: Column(
            children: [
              UpperPart(
                text: AppTexts.testDetails,
                customBackFunction: controller.testDetailsWillPop,
              ),
              Expanded(
                child: CustomContainer(
                  margin: const EdgeInsets.only(left: 8, right: 8),
                  height: 1,
                  children: [
                    SizedBox(height: AppDecoration().screenHeight * .02),
                    TestInfo(
                      advancedTestModel: advancedTestModel,
                    ),
                    SizedBox(height: AppDecoration().screenHeight * .015),
                    TestDescription(
                      advancedTestModel: advancedTestModel,
                    ),
                    SizedBox(height: AppDecoration().screenHeight * .005),
                  ],
                ),
              ),
              LowerPart(
                bookTest: () {
                  controller.goToCheckoutScreen(
                    advancedTestModel: advancedTestModel,
                  );
                },
                advancedTestModel: advancedTestModel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
