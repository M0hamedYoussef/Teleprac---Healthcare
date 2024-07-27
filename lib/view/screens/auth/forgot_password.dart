import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/auth/forgot_password_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/auth/forgotpassword/email_form.dart';
import 'package:teleprac/view/widgets/auth/forgotpassword/reset_button.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    ForgotPassCon controller = Get.put(ForgotPassCon());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: WillPopScope(
        onWillPop: controller.willPop,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: AppDecoration().screenHeight * 0.02),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
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
              ),
              SizedBox(height: AppDecoration().screenHeight * 0.007),
              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 25,
                ),
                child: Text(
                  AppTexts.forgotPass,
                  style: TextStyle(
                    color: AppColors.grey,
                    fontFamily: AppDecoration.cairo,
                    fontSize: AppDecoration().screenWidth * 0.08,
                  ),
                ),
              ),
              SizedBox(height: AppDecoration().screenHeight * 0.007),
              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 25,
                ),
                child: Text(
                  AppTexts.forgotPassText1,
                  style: TextStyle(
                    color: AppColors.grey,
                    fontFamily: AppDecoration.cairo,
                    fontWeight: FontWeight.w500,
                    fontSize: AppDecoration().screenWidth * 0.045,
                  ),
                ),
              ),
              SizedBox(height: AppDecoration().screenHeight * 0.06),
              const EmailForm(),
              const Spacer(),
              const ResetButton(),
              SizedBox(height: AppDecoration().screenHeight * 0.06),
            ],
          ),
        ),
      ),
    );
  }
}

/* OLD

 MainContainer(
          children: [
            UpperPart(
              text: AppTexts.forgotPass,
              customBarColor: AppColors.lightGreenSecond,
              customBackFunction: controller.willPop,
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.02),
            const LockIcon(),
            SizedBox(height: AppDecoration().screenHeight * 0.02),
            const FirstDesignText(),
            SizedBox(height: AppDecoration().screenHeight * 0.01),
            const SecondDesignText(),
            SizedBox(height: AppDecoration().screenHeight * 0.02),
            CustomContainer(
              height: 0.23,
              children: [
                SizedBox(height: AppDecoration().screenHeight * 0.03),
                const EmailForm(),
                SizedBox(height: AppDecoration().screenHeight * 0.02),
                const ResetButton(),
              ],
            ),
          ],
        ),


 */
