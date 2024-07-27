import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.function,
    this.text = '',
    this.margin = const EdgeInsets.only(left: 20, right: 20, bottom: 10),
    this.height = 0.05,
    this.width,
    this.opacity = 1,
    this.textColor = AppColors.secondaryColor,
    this.buttonColor,
    this.buttonIcon,
    this.customWidget,
    this.fontSize,
    this.fontHeight,
    this.circularRadius = 10,
    this.iconAlignment = Alignment.centerRight,
    this.elevation = 4,
    this.cairoFont = true,
    this.fontWeight,
  });
  final EdgeInsetsGeometry? margin;
  final void Function() function;
  final String text;
  final double height;
  final double? width;
  final double opacity;
  final Color textColor;
  final Color? buttonColor;
  final Widget? buttonIcon;
  final Widget? customWidget;
  final double? fontSize;
  final double? fontHeight;
  final double circularRadius;
  final Alignment iconAlignment;
  final double elevation;
  final bool cairoFont;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: AppDecoration().screenHeight * height,
      width: width == null ? null : AppDecoration().screenHeight * width!,
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              buttonColor ?? AppColors.lightGreenSecond.withOpacity(opacity),
          foregroundColor: textColor,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(circularRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (buttonIcon != null && iconAlignment == Alignment.centerLeft)
              buttonIcon!,
            customWidget ??
                Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontSize != null
                        ? AppDecoration().screenWidth * fontSize!
                        : AppDecoration().screenWidth * 0.04,
                    height: fontHeight,
                    fontFamily: cairoFont ? AppDecoration.cairo : null,
                    fontWeight: fontWeight,
                  ),
                ),
            if (buttonIcon != null && iconAlignment == Alignment.centerRight)
              buttonIcon!,
          ],
        ),
      ),
    );
  }
}
