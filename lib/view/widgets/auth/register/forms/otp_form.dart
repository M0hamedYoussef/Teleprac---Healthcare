import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/auth/register_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class OtpForm extends GetView<RegisterCon> {
  const OtpForm({super.key});

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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.lightGreen,
            ),
            child: Row(
              children: [
                SizedBox(width: AppDecoration().screenWidth * 0.05),
                const Icon(
                  Icons.password,
                  color: AppColors.grey,
                ),
                SizedBox(width: AppDecoration().screenWidth * 0.02),
                Expanded(
                  child: TextFormField(
                    controller: controller.otpCon,
                    focusNode: controller.otpFocus,
                    keyboardType: TextInputType.number,
                    onEditingComplete: () {
                      controller.otpEditingCompleted();
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      label: Text(AppTexts.otpLabel),
                      floatingLabelStyle: TextStyle(
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
