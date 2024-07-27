import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/search_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class UpperPart extends GetView<SearchCon> {
  const UpperPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.mainLinarGradient,
      ),
      width: AppDecoration().screenWidth,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    SystemChrome.setSystemUIOverlayStyle(
                      const SystemUiOverlayStyle(
                        statusBarColor: AppColors.lightGrey1,
                        statusBarIconBrightness: Brightness.light,
                      ),
                    );

                    Get.back();
                  },
                  icon: const Icon(
                    CupertinoIcons.back,
                    color: AppColors.secondaryColor,
                    size: 40,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppDecoration().screenHeight * 0.01),
                    Text(
                      AppTexts.doctors,
                      style: TextStyle(
                        fontSize: AppDecoration().screenWidth * 0.07,
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppDecoration.cairo,
                        height: 0.9,
                      ),
                    ),
                    const Text(
                      AppTexts.onlineConsultaion,
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppDecoration.cairo,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Speciality Filter',
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppDecoration.cairo,
                    height: 1,
                  ),
                ),
                GetBuilder<SearchCon>(
                  builder: (_) => IconButton(
                    onPressed: () {
                      controller.filterOpen();
                    },
                    icon: Icon(
                      controller.specialityFilters.isEmpty
                          ? Icons.filter_alt_outlined
                          : Icons.filter_alt,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
