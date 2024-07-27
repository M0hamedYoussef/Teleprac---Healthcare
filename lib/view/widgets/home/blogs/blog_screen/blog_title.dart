import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class BlogTitle extends StatelessWidget {
  const BlogTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title.toLowerCase().capitalizeFirst!,
        style: TextStyle(
          fontSize: AppDecoration().screenWidth * 0.06,
          fontFamily: AppDecoration.cairo,
          fontWeight: FontWeight.w500,
          color: AppColors.black.withOpacity(0.7),
        ),
      ),
    );
  }
}
