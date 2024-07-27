import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class BlogCreatedDate extends StatelessWidget {
  const BlogCreatedDate({super.key, required this.date});
  final String date;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Icon(
            Icons.watch_later_outlined,
            color: AppColors.primaryColor,
          ),
          SizedBox(width: AppDecoration().screenWidth * 0.01),
          Text(
            Jiffy(date).yMMMMEEEEdjm,
            style: TextStyle(
              fontSize: AppDecoration().screenWidth * 0.04,
              fontFamily: AppDecoration.cairo,
              fontWeight: FontWeight.w400,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
