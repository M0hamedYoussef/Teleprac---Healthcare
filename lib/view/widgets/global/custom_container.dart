import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.children,
    this.decorationImage,
    this.height = 0.4,
    this.color = AppColors.secondaryColor,
    this.margin = const EdgeInsets.only(
      left: 20,
      right: 20,
    ),
    this.scrollPhysics =
        const BouncingScrollPhysics(parent: PageScrollPhysics()),
    this.customScrollPhysics =
        const BouncingScrollPhysics(parent: NeverScrollableScrollPhysics()),
    this.listView = true,
  });
  final List<Widget> children;
  final ScrollPhysics scrollPhysics;
  final ScrollPhysics customScrollPhysics;
  final EdgeInsetsGeometry? margin;
  final DecorationImage? decorationImage;
  final double? height;
  final Color color;
  final bool listView;
  @override
  Widget build(BuildContext context) {
    if (listView) {
      return Container(
        height: height == null ? null : AppDecoration().screenHeight * height!,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: decorationImage,
          color: color,
        ),
        child: ListView(
          physics: scrollPhysics,
          children: children,
        ),
      );
    } else {
      return Container(
        height: height == null ? null : AppDecoration().screenHeight * height!,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: decorationImage,
          color: color,
        ),
        child: SafeArea(
          child: CustomScrollView(
            physics: customScrollPhysics,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: children,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
