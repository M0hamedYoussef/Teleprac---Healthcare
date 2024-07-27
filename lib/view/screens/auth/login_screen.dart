import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/auth/login_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/view/widgets/auth/login/container/create_acc.dart';
import 'package:teleprac/view/widgets/auth/login/container/email_form.dart';
import 'package:teleprac/view/widgets/auth/login/container/login_button.dart';
import 'package:teleprac/view/widgets/auth/login/container/pass_form.dart';
import 'package:teleprac/view/widgets/auth/login/container/pass_options.dart';
import 'package:teleprac/view/widgets/auth/login/upper_part.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginCon());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: ListView(
        children: [
          SizedBox(height: AppDecoration().screenHeight * 0.02),
          const UpperPart(),
          SizedBox(height: AppDecoration().screenHeight * 0.03),
          const EmailForm(),
          SizedBox(height: AppDecoration().screenHeight * 0.015),
          const PasswordForm(),
          SizedBox(height: AppDecoration().screenHeight * 0.1),
          const LoginButton(),
          SizedBox(height: AppDecoration().screenHeight * 0.015),
          const PasswordOptions(),
          SizedBox(height: AppDecoration().screenHeight * 0.2),
          const CreateAccountText(),
          SizedBox(height: AppDecoration().screenHeight * 0.015),
        ],
      ),
    );
  }
}
/* 
/////////////////////OLD
 MainContainer(
        children: [
          SizedBox(height: AppDecoration().screenHeight * 0.02),
          const UpperPart(),
          const WelcomeText(),
          SizedBox(height: AppDecoration().screenHeight * 0.03),
          const MiddleDesign(),
          SizedBox(height: AppDecoration().screenHeight * 0.02),
          const FirstDesignText(),
          SizedBox(height: AppDecoration().screenHeight * 0.06),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.secondaryColor,
            ),
            child: Column(
              children: [
                // const SigninText(),
                SizedBox(height: AppDecoration().screenHeight * 0.03),
                const EmailForm(),
                SizedBox(height: AppDecoration().screenHeight * 0.015),
                const PasswordForm(),
                const PasswordOptions(),
                SizedBox(height: AppDecoration().screenHeight * 0.01),
                const LoginButton(),
                SizedBox(height: AppDecoration().screenHeight * 0.02),
                const CreateAccountText(),
                SizedBox(height: AppDecoration().screenHeight * 0.02),
              ],
            ),
          ),
        ],
      ), 
 */
