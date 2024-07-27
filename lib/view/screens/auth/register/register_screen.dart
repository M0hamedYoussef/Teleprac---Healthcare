import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/auth/register_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/view/widgets/auth/register/forms/role_form.dart';
import 'package:teleprac/view/widgets/auth/register/second_design_text.dart';
import 'package:teleprac/view/widgets/auth/register/first_design_text.dart';
import 'package:teleprac/view/widgets/auth/register/forms/email_form.dart';
import 'package:teleprac/view/widgets/auth/register/forms/password_form.dart';
import 'package:teleprac/view/widgets/auth/register/forms/firstname_form.dart';
import 'package:teleprac/view/widgets/auth/register/forms/lastname_form.dart';
import 'package:teleprac/view/widgets/auth/register/forms/mobile_form.dart';
import 'package:teleprac/view/widgets/auth/register/forms/repeat_pass_.dart';
import 'package:teleprac/view/widgets/auth/register/reg_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterCon controller = Get.put(RegisterCon());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: WillPopScope(
        onWillPop: controller.willPop,
        child: ListView(
          children: [
            SizedBox(height: AppDecoration().screenHeight * 0.02),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                AppDecoration.appIcon,
                height: AppDecoration().screenHeight * 0.2,
              ),
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.03),
            const FirstNameForm(),
            SizedBox(height: AppDecoration().screenHeight * 0.01),
            const LastNameForm(),
            SizedBox(height: AppDecoration().screenHeight * 0.01),
            const MobileNumberForm(),
            SizedBox(height: AppDecoration().screenHeight * 0.01),
            // const OtpForm(),
            // SizedBox(height: AppDecoration().screenHeight * 0.01),
            const EmailForm(),
            SizedBox(height: AppDecoration().screenHeight * 0.01),
            const PasswordForm(),
            SizedBox(height: AppDecoration().screenHeight * 0.005),
            const FirstDesignText(),
            SizedBox(height: AppDecoration().screenHeight * 0.01),
            const RepeatPasswordForm(),
            SizedBox(height: AppDecoration().screenHeight * 0.005),
            const RoleForm(),
            SizedBox(height: AppDecoration().screenHeight * 0.01),
            const SecondDesignText(),
            SizedBox(height: AppDecoration().screenHeight * 0.005),
            const RegisterButton(),
            SizedBox(height: AppDecoration().screenHeight * 0.02),
          ],
        ),
      ),
    );
  }
}

/*
 MainContainer(
          children: [
            UpperPart(
              text: AppTexts.createAcc0,
              customBarColor: AppColors.lightGreenSecond,
              customBackFunction: controller.willPop,
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.02),
            Container(
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
                children: [
                  SizedBox(height: AppDecoration().screenHeight * 0.02),
                  const FirstNameForm(),
                  const LastNameForm(),
                  const MobileNumberForm(),
                  const OtpForm(),
                  SizedBox(height: AppDecoration().screenHeight * 0.01),
                  const EmailForm(),
                  const PasswordForm(),
                  SizedBox(height: AppDecoration().screenHeight * 0.005),
                  const FirstDesignText(),
                  SizedBox(height: AppDecoration().screenHeight * 0.01),
                  const RepeatPasswordForm(),
                  SizedBox(height: AppDecoration().screenHeight * 0.005),
                  const RoleForm(),
                  SizedBox(height: AppDecoration().screenHeight * 0.01),
                  const SecondDesignText(),
                  SizedBox(height: AppDecoration().screenHeight * 0.005),
                  const RegisterButton(),
                  SizedBox(height: AppDecoration().screenHeight * 0.02),
                ],
              ),
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.02),
          ],
        ),

 */
