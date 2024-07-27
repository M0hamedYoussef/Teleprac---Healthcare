import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard/my_favourites_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/home/dashboard/my_favourites/favourites_list.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class MyFavouritesScreen extends StatelessWidget {
  const MyFavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyFavouritesController());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: SafeArea(
        child: Column(
          children: [
            const UpperPart(
              text: AppTexts.favourites,
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.02),
            const MyFavouritesList(),
          ],
        ),
      ),
    );
  }
}
