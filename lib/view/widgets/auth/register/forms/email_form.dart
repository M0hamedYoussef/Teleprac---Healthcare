import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/auth/register_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class EmailForm extends GetView<RegisterCon> {
  const EmailForm({super.key});

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
                Icons.email_outlined,
                color: AppColors.grey,
              ),
              SizedBox(width: AppDecoration().screenWidth * 0.02),
              const Expanded(
                child: Text(
                  AppTexts.emailLabel,
                  style: TextStyle(fontFamily: AppDecoration.cairo),
                ),
              ),
            ],
          ),
          TextFormField(
            controller: controller.emailCon,
            focusNode: controller.emailFocus,
            onEditingComplete: () {
              controller.emailEditingCompleted();
            },
            decoration: const InputDecoration(
              hintText: 'Enter Your Email',
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
                controller.emailValidationText,
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

/*
    Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.lightGreen,
            ),
            child: Row(
              children: [
                SizedBox(width: AppDecoration().screenWidth * 0.05),
                 const Icon(
                  Icons.email_outlined,
                  color: AppColors.grey,
                ),
                SizedBox(width: AppDecoration().screenWidth * 0.02),
                Expanded(
                  child: TextFormField(
                    controller: controller.emailCon,
                    focusNode: controller.emailFocus,
                    onEditingComplete: () {
                      controller.emailEditingCompleted();
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      label: Text(AppTexts.emailLabel),
                      floatingLabelStyle: TextStyle(
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

 */