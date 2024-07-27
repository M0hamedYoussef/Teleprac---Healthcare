import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/main_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class DoctorSearchBar extends GetView<MainController> {
  const DoctorSearchBar({super.key, this.focusNode});
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.secondaryColor,
              border: Border.all(
                width: 0.7,
                color: AppColors.greySplash,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: controller.searchCon,
                      focusNode: focusNode ?? controller.searchFocus,
                      onEditingComplete: () {
                        controller.searchEditingCompleted();
                      },
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: AppTexts.searchHint,
                        labelStyle: TextStyle(
                          fontSize: AppDecoration().screenWidth * 0.03,
                          color: AppColors.black,
                          fontFamily: AppDecoration.cairo,
                          fontWeight: FontWeight.w500,
                        ),
                        floatingLabelStyle: TextStyle(
                          color: AppColors.black,
                          fontSize: AppDecoration().screenWidth * 0.03,
                          fontFamily: AppDecoration.cairo,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.searchEditingCompleted();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      // color: AppColors.primaryColor,
                    ),
                    child: Icon(
                      Icons.search,
                      color: AppColors.grey,
                      size: AppDecoration().screenWidth * 0.07,
                    ),
                  ),
                ),
                SizedBox(width: AppDecoration().screenWidth * 0.03),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
