import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/labs/tests_controller.dart';
import 'package:teleprac/controller/search_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/lab_screen/tests_screen/filters.dart';
import 'package:teleprac/view/widgets/lab_screen/tests_screen/search_bar.dart';
import 'package:teleprac/view/widgets/lab_screen/tests_screen/tests_list.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class TestsScreen extends StatelessWidget {
  const TestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TestsController controller = Get.put(TestsController());
    Get.put(SearchCon());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: WillPopScope(
        onWillPop: controller.willPop,
        child: SafeArea(
          child: Column(
            children: [
              UpperPart(
                text: AppTexts.searchHint2,
                trText: 'Labs',
                trFunction: () {
                  controller.viewLabs();
                },
                customBackFunction: controller.willPop,
              ),
              SizedBox(height: AppDecoration().screenHeight * 0.02),
              const TestsSearchBar(),
              // SizedBox(height: AppDecoration().screenHeight * 0.02),
              // CustomButton(
              //   circularRadius: 5,
              //   textColor: AppColors.secondaryColor,
              //   buttonColor: AppColors.primaryColor,
              //   margin: const EdgeInsets.only(left: 10, right: 10),
              //   text: 'See All Labs',
              //   function: () {
              //     controller.viewLabs();
              //   },
              // ),
              const TestsFilters(),
              const TestsList(),
            ],
          ),
        ),
      ),
    );
  }
}
