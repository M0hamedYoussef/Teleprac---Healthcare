import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({
    super.key,
    this.padding = const EdgeInsets.only(
      left: 20,
      right: 20,
      top: 8,
    ),
    required this.date,
    required this.onTap,
    this.label,
    this.oldDesgin = true,
    this.validationText,
  });
  final EdgeInsets padding;
  final String date;
  final String? label;
  final String? validationText;
  final bool oldDesgin;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    if (oldDesgin) {
      if (date.isEmpty && label != null) {
        return GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.lightGreen,
                  ),
                  height: AppDecoration().screenHeight * 0.07,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: AppDecoration().screenWidth * 0.02),
                          const Icon(
                            Icons.date_range_outlined,
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(width: AppDecoration().screenWidth * 0.02),
                          Text(
                            label!,
                            style: TextStyle(
                              fontSize: AppDecoration().screenWidth * 0.04,
                              color: AppColors.grey,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.edit,
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(width: AppDecoration().screenWidth * 0.03),
                        ],
                      ),
                    ],
                  ),
                ),
                if (validationText != null)
                  Text(
                    validationText!,
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.035,
                      color: AppColors.grey,
                    ),
                  ),
              ],
            ),
          ),
        );
      } else {
        return GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.lightGreen,
                  ),
                  height: AppDecoration().screenHeight * 0.07,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: AppDecoration().screenWidth * 0.02),
                          const Icon(
                            Icons.date_range_outlined,
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(width: AppDecoration().screenWidth * 0.02),
                          Text(
                            date,
                            style: TextStyle(
                              fontSize: AppDecoration().screenWidth * 0.04,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.edit,
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(width: AppDecoration().screenWidth * 0.03),
                        ],
                      ),
                    ],
                  ),
                ),
                if (validationText != null)
                  Text(
                    validationText!,
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.035,
                      color: AppColors.red,
                    ),
                  ),
              ],
            ),
          ),
        );
      }
    } else {
      if (date.isEmpty && label != null) {
        return Column(
          children: [
            GestureDetector(
              onTap: onTap,
              child: Padding(
                padding: padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: AppDecoration().screenWidth * 0.02),
                            const Icon(
                              Icons.date_range_outlined,
                              color: AppColors.grey,
                            ),
                            SizedBox(width: AppDecoration().screenWidth * 0.02),
                            Text(
                              label!,
                              style: TextStyle(
                                fontSize: AppDecoration().screenWidth * 0.042,
                                color: AppColors.grey,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppDecoration.cairo,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.edit,
                              size: AppDecoration().screenWidth * 0.045,
                              color: AppColors.grey,
                            ),
                            SizedBox(width: AppDecoration().screenWidth * 0.03),
                          ],
                        ),
                      ],
                    ),
                    if (validationText != null)
                      Text(
                        validationText!,
                        style: TextStyle(
                          color: AppColors.red,
                          fontSize: AppDecoration().screenWidth * 0.035,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: AppColors.black,
                thickness: 0.2,
              ),
            ),
          ],
        );
      } else {
        return Column(
          children: [
            GestureDetector(
              onTap: onTap,
              child: Padding(
                padding: padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: AppDecoration().screenWidth * 0.02),
                            const Icon(
                              Icons.date_range_outlined,
                              color: AppColors.grey,
                            ),
                            SizedBox(width: AppDecoration().screenWidth * 0.02),
                            Text(
                              date,
                              style: TextStyle(
                                fontSize: AppDecoration().screenWidth * 0.042,
                                color: AppColors.grey,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppDecoration.cairo,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.edit,
                              size: AppDecoration().screenWidth * 0.045,
                              color: AppColors.grey,
                            ),
                            SizedBox(width: AppDecoration().screenWidth * 0.03),
                          ],
                        ),
                      ],
                    ),
                    if (validationText != null)
                      Text(
                        validationText!,
                        style: TextStyle(
                          color: AppColors.red,
                          fontSize: AppDecoration().screenWidth * 0.035,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: AppColors.black,
                thickness: 0.2,
              ),
            ),
          ],
        );
      }
    }
  }
}
