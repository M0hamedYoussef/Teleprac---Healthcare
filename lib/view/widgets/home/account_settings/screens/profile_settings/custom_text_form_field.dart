import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.formColor = AppColors.lightGreen,
    this.padding = const EdgeInsets.only(
      left: 20,
      right: 20,
      top: 8,
    ),
    required this.textEditingController,
    required this.label,
    this.focusNode,
    this.validationText,
    this.nextFocusNode,
    this.leading,
    this.onEditingComplete,
    this.onChanged,
    this.keyboardType,
    this.maxLines = 1,
    this.maxLength,
    this.startingHeight,
    this.maxHeight = 0.15,
    this.oldDesign = true,
  });
  final bool oldDesign;
  final Color formColor;
  final EdgeInsets padding;
  final Widget? leading;
  final TextEditingController textEditingController;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final Function()? onEditingComplete;
  final Function(String? val)? onChanged;
  final String label;
  final String? validationText;
  final int? maxLines;
  final int? maxLength;
  final double? startingHeight;
  final double maxHeight;
  @override
  Widget build(BuildContext context) {
    if (oldDesign) {
      return Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: formColor,
              ),
              child: Row(
                children: [
                  SizedBox(width: AppDecoration().screenWidth * 0.02),
                  if (leading != null) leading!,
                  SizedBox(width: AppDecoration().screenWidth * 0.02),
                  Expanded(
                    child: Container(
                      height: startingHeight == null
                          ? null
                          : AppDecoration().screenHeight * startingHeight!,
                      constraints: BoxConstraints(
                          maxHeight: AppDecoration().screenHeight * maxHeight),
                      padding: maxLength == null
                          ? null
                          : const EdgeInsets.only(bottom: 10, right: 10),
                      child: TextFormField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        maxLines: maxLines,
                        maxLength: maxLength,
                        keyboardType: keyboardType,
                        onChanged: onChanged,
                        onEditingComplete: () {
                          if (onEditingComplete != null) {
                            onEditingComplete!();
                          } else {
                            if (nextFocusNode != null) {
                              nextFocusNode!.requestFocus();
                            }
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          label: Text(label),
                          floatingLabelStyle: const TextStyle(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (validationText != null)
              Text(
                validationText!,
                style: TextStyle(
                  color: AppColors.red,
                  fontSize: AppDecoration().screenWidth * 0.04,
                ),
              ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: startingHeight == null
                  ? null
                  : AppDecoration().screenHeight * startingHeight!,
              constraints: BoxConstraints(
                  maxHeight: AppDecoration().screenHeight * maxHeight),
              child: TextFormField(
                controller: textEditingController,
                focusNode: focusNode,
                maxLines: maxLines,
                maxLength: maxLength,
                keyboardType: keyboardType,
                onChanged: onChanged,
                cursorColor: AppColors.primaryColor,
                onEditingComplete: () {
                  if (onEditingComplete != null) {
                    onEditingComplete!();
                  } else {
                    if (nextFocusNode != null) {
                      nextFocusNode!.requestFocus();
                    }
                  }
                },
                decoration: InputDecoration(
                  hintText: label,
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  focusColor: AppColors.primaryColor,
                  floatingLabelStyle: const TextStyle(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.02),
            Text(
              validationText ?? '',
              style: TextStyle(
                color: AppColors.red,
                fontSize: AppDecoration().screenWidth * 0.03,
              ),
            ),
          ],
        ),
      );
    }
  }
}
