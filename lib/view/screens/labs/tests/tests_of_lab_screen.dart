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

class LabTestsScreen extends StatelessWidget {
  const LabTestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TestsController());
    Get.put(SearchCon());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: SafeArea(
        child: Column(
          children: [
            const UpperPart(
              text: AppTexts.searchHint2,
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.02),
            const TestsSearchBar(),
            // SizedBox(height: AppDecoration().screenHeight * 0.02),
            const TestsFilters(),
            const TestsList(),
          ],
        ),
      ),
    );
  }
}
