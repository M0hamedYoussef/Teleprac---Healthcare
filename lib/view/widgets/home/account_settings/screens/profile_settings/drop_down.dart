import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/global/drop_down_model.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.dropdownList,
    required this.value,
    required this.onChanged,
    this.leading,
    required this.label,
    this.validationText,
    this.padding = const EdgeInsets.only(
      left: 20,
      right: 20,
    ),
    this.circularRadius = 14,
    this.oldDesign = true,
  });
  final bool oldDesign;
  final Widget? leading;
  final List dropdownList;
  final String value;
  final String? validationText;
  final String label;
  final Function(String?) onChanged;
  final EdgeInsets padding;
  final double circularRadius;

  @override
  Widget build(BuildContext context) {
    if (oldDesign) {
      return Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              height: AppDecoration().screenHeight * 0.07,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(circularRadius),
                color: AppColors.lightGreen,
              ),
              child: Row(
                children: [
                  SizedBox(width: AppDecoration().screenWidth * 0.01),
                  if (leading != null) leading!,
                  SizedBox(width: AppDecoration().screenWidth * 0.02),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: Text(
                          label,
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: AppDecoration().screenWidth * 0.04,
                          ),
                        ),
                        items: [
                          ...List.generate(
                            dropdownList.length,
                            (index) {
                              DropDownItemModel dropDownItemModel =
                                  DropDownItemModel.fromJson(
                                dropdownList[index],
                              );

                              return DropdownMenuItem<String>(
                                value: dropDownItemModel.value!,
                                child: Text(
                                  dropDownItemModel.label!,
                                  style: TextStyle(
                                    fontSize:
                                        AppDecoration().screenWidth * 0.04,
                                    fontWeight: FontWeight.bold,
                                    color: value == dropDownItemModel.value
                                        ? AppColors.darkGreen
                                        : AppColors.black,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                        value: value.isEmpty ? null : value,
                        onChanged: onChanged,
                        iconStyleData: IconStyleData(
                          icon: const Icon(
                            Icons.arrow_drop_down,
                          ),
                          iconSize: AppDecoration().screenWidth * 0.05,
                          iconEnabledColor: AppColors.primaryColor,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          width: AppDecoration().screenWidth * 0.8,
                          maxHeight: AppDecoration().screenHeight * 0.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: AppColors.secondaryColor,
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
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Text(
                      label,
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: AppDecoration().screenWidth * 0.04,
                      ),
                    ),
                    items: [
                      ...List.generate(
                        dropdownList.length,
                        (index) {
                          DropDownItemModel dropDownItemModel =
                              DropDownItemModel.fromJson(
                            dropdownList[index],
                          );

                          return DropdownMenuItem<String>(
                            value: dropDownItemModel.value!,
                            child: Text(
                              dropDownItemModel.label!,
                              style: TextStyle(
                                fontSize: AppDecoration().screenWidth * 0.04,
                                fontWeight: FontWeight.bold,
                                color: value == dropDownItemModel.value
                                    ? AppColors.primaryColor
                                    : AppColors.black,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                    value: value.isEmpty ? null : value,
                    onChanged: onChanged,
                    iconStyleData: IconStyleData(
                      icon: const Icon(
                        Icons.arrow_drop_down,
                      ),
                      iconSize: AppDecoration().screenWidth * 0.05,
                      iconEnabledColor: value.isNotEmpty
                          ? AppColors.primaryColor
                          : AppColors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      width: AppDecoration().screenWidth * 0.8,
                      maxHeight: AppDecoration().screenHeight * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 0.5,
                  color: AppColors.grey,
                ),
              ],
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
    }
  }
}
