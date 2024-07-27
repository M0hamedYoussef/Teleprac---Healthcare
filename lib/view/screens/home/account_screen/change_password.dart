import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/account_settings/change_password_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/change_password/current_password_form.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/change_password/password_form.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/change_password/repeat_pass_.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ChangePasswordController controller = Get.put(ChangePasswordController());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: WillPopScope(
        onWillPop: controller.willPop,
        child: SafeArea(
            child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppDecoration().screenHeight * 0.02),
                  Container(
                    height: AppDecoration().screenHeight * 0.05,
                    width: AppDecoration().screenHeight * 0.05,
                    margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.greySplash,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        controller.willPop();
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: AppDecoration().screenHeight * 0.007),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      AppTexts.changePass,
                      style: TextStyle(
                        color: AppColors.grey,
                        fontFamily: AppDecoration.cairo,
                        fontWeight: FontWeight.w300,
                        fontSize: AppDecoration().screenWidth * 0.08,
                      ),
                    ),
                  ),
                  SizedBox(height: AppDecoration().screenHeight * 0.04),
                  const CurrentPasswordForm(),
                  SizedBox(height: AppDecoration().screenHeight * 0.01),
                  const PasswordForm(),
                  SizedBox(height: AppDecoration().screenHeight * 0.01),
                  const RepeatPasswordForm(),
                  SizedBox(height: AppDecoration().screenHeight * 0.02),
                  const Spacer(),
                  CustomButton(
                    function: () {
                      controller.changePassword();
                    },
                    buttonColor: AppColors.primaryColor,
                    text: AppTexts.changePass,
                  ),
                  SizedBox(height: AppDecoration().screenHeight * 0.06),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}

/*
 CustomContainer(
          height: 1,
          margin: null,
          decorationImage: const DecorationImage(
            image: AssetImage(
              AppDecoration.bg_0,
            ),
            fit: BoxFit.fill,
          ),
          children: [
            SizedBox(height: AppDecoration().screenHeight * 0.15),
            const Center(
              child: Text(
                AppTexts.changePass,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  height: 1.2,
                ),
              ),
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.15),
            CustomContainer(
              color: AppColors.secondaryColor,
              height: 0.4,
              children: [
                SizedBox(height: AppDecoration().screenHeight * 0.03),
                const CurrentPasswordForm(),
                SizedBox(height: AppDecoration().screenHeight * 0.01),
                const PasswordForm(),
                SizedBox(height: AppDecoration().screenHeight * 0.01),
                const RepeatPasswordForm(),
                SizedBox(height: AppDecoration().screenHeight * 0.02),
                CustomButton(
                  function: () {
                    controller.changePassword();
                  },
                  buttonColor: AppColors.primaryColor,
                  text: AppTexts.changePass,
                ),
              ],
            ),
          ],
        ),
         */