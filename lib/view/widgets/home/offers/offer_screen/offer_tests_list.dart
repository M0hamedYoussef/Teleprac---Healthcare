import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/offers_controller.dart';
import 'package:teleprac/controller/labs/tests_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/model/labs/tests/test_model.dart';
import 'package:teleprac/view/widgets/lab_screen/tests_screen/test_options.dart';
import 'package:teleprac/view/widgets/lab_screen/tests_screen/test_info.dart';
import 'package:teleprac/view/widgets/lab_screen/tests_screen/test_price.dart';

class OfferTestsList extends GetView<OffersController> {
  const OfferTestsList({super.key});

  @override
  Widget build(BuildContext context) {
    TestsController testsController = Get.put(TestsController());
    return Column(
      children: [
        ...List.generate(
          controller.offerTests.length,
          (index) {
            TestModel testModel = controller.offerTests[index];
            return Container(
              margin: const EdgeInsets.only(
                bottom: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.secondaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TestDetails(testModel: testModel),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                    ),
                    child: Divider(
                      thickness: 1.2,
                    ),
                  ),
                  TestsPrice(testModel: testModel),
                  TestOptions(
                    width: 1,
                    details: () {
                      testsController.testDetails(
                        testModel: testModel,
                        context: context,
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
