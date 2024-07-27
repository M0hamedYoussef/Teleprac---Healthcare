import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/labs/labs_controller.dart';
import 'package:teleprac/controller/search_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/lab_screen/lab_list.dart';
import 'package:teleprac/view/widgets/lab_screen/search_bar.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class LabsScreen extends StatelessWidget {
  const LabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LabsController controller = Get.put(LabsController());
    Get.put(SearchCon());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: WillPopScope(
        onWillPop: controller.willPop,
        child: SafeArea(
          child: Column(
            children: [
              UpperPart(
                text: AppTexts.labs,
                customBackFunction: controller.willPop,
              ),
              SizedBox(height: AppDecoration().screenHeight * 0.02),
              const LabSearchBar(),
              SizedBox(height: AppDecoration().screenHeight * 0.02),
              const LabsList(),
            ],
          ),
        ),
      ),
    );
  }
}
