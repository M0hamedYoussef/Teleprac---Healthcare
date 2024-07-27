import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class CustomShimmerPlaceHolder extends StatelessWidget {
  const CustomShimmerPlaceHolder({
    super.key,
    this.height,
    this.width,
    this.decoration,
    this.margin = const EdgeInsets.only(left: 10, right: 10),
  });
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final Decoration? decoration;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.lightGreen,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Container(
        height: height == null ? null : AppDecoration().screenHeight * height!,
        width: width == null ? null : AppDecoration().screenHeight * width!,
        decoration: decoration ??
            BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
        margin: margin,
      ),
    );
  }
}
