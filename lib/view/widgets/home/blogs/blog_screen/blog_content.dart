import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class BlogContent extends StatelessWidget {
  const BlogContent({super.key, required this.content});
  final String content;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        content,
        style: TextStyle(
          fontSize: AppDecoration().screenWidth * 0.045,
          fontFamily: AppDecoration.cairo,
          fontWeight: FontWeight.w500,
          wordSpacing: 2,
          color: AppColors.grey,
        ),
      ),
    );
  }
}
