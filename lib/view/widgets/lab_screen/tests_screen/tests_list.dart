import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/labs/tests_controller.dart';
import 'package:teleprac/controller/search_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/model/labs/tests/test_model.dart';
import 'package:teleprac/view/widgets/lab_screen/tests_screen/test_options.dart';
import 'package:teleprac/view/widgets/lab_screen/tests_screen/test_info.dart';
import 'package:teleprac/view/widgets/lab_screen/tests_screen/test_price.dart';

class TestsList extends GetView<TestsController> {
  const TestsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<SearchCon>(
        builder: (searchCon) {
          return ListView.builder(
            itemCount: searchCon.testCategorieFilter.isEmpty
                ? controller.allTests.length
                : searchCon.testCategorieFilter == '0'
                    ? controller.imagingTests.length
                    : searchCon.testCategorieFilter == '1'
                        ? controller.labTests.length
                        : controller.packages.length,
            physics: const BouncingScrollPhysics(parent: PageScrollPhysics()),
            itemBuilder: (context, index) {
              TestModel testModel = TestModel.fromJson(
                searchCon.testCategorieFilter.isEmpty
                    ? controller.allTests[index]
                    : searchCon.testCategorieFilter == '0'
                        ? controller.imagingTests[index]
                        : searchCon.testCategorieFilter == '1'
                            ? controller.labTests[index]
                            : controller.packages[index],
              );

              if (searchCon.testsSearchValidate(testModel: testModel) &&
                  (controller.labId == 'all'
                      ? true
                      : controller.labId == testModel.labId) &&
                  (searchCon.testCategorieFilter.isEmpty ||
                      searchCon.testCategorieFilter == 'Packages' ||
                      testModel.category == searchCon.testCategorieFilter)) {
                return Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
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
                        details: () {
                          controller.testDetails(
                            testModel: testModel,
                            context: context,
                          );
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          );
        },
      ),
    );
  }
}
