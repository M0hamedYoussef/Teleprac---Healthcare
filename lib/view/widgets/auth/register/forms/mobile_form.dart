import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/auth/register_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class MobileNumberForm extends GetView<RegisterCon> {
  const MobileNumberForm({super.key});

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
          Row(
            children: [
              const Icon(
                Icons.phone,
                color: AppColors.grey,
              ),
              SizedBox(width: AppDecoration().screenWidth * 0.02),
              const Expanded(
                child: Text(
                  AppTexts.mobileNoLabel,
                  style: TextStyle(fontFamily: AppDecoration.cairo),
                ),
              ),
            ],
          ),
          TextFormField(
            controller: controller.mobileNoCon,
            focusNode: controller.mobileNoFocus,
            keyboardType: TextInputType.number,
            onEditingComplete: () {
              controller.mobileNoEditingCompleted();
            },
            decoration: const InputDecoration(
              hintText: 'Enter Your Mobile Number',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primaryColor,
                ),
              ),
              focusColor: AppColors.primaryColor,
              floatingLabelStyle: TextStyle(
                color: AppColors.primaryColor,
              ),
            ),
          ),
          SizedBox(height: AppDecoration().screenHeight * 0.01),
          GetBuilder<RegisterCon>(
            builder: (_) {
              return Text(
                controller.mobileNoValidationText,
                style: const TextStyle(
                  color: AppColors.red,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
