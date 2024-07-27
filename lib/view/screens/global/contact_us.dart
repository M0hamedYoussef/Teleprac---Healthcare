import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/contact_us_controller.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/custom_text_form_field.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ContactUsController controller = Get.put(ContactUsController());

    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            const UpperPart(
              text: AppTexts.contactUs,
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.02),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.secondaryColor,
              ),
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: GetBuilder<ContactUsController>(
                builder: (controller) {
                  return Column(
                    children: [
                      SizedBox(height: AppDecoration().screenHeight * 0.02),
                      CustomTextFormField(
                        textEditingController: controller.nameCon,
                        focusNode: controller.nameFocus,
                        nextFocusNode: controller.phoneFocus,
                        validationText: controller.nameValidationText,
                        label: 'Full Name',
                        oldDesign: false,
                      ),
                      SizedBox(height: AppDecoration().screenHeight * 0.01),
                      CustomTextFormField(
                        leading: const Icon(
                          Icons.phone,
                          color: AppColors.primaryColor,
                        ),
                        textEditingController: controller.phoneCon,
                        focusNode: controller.phoneFocus,
                        nextFocusNode: controller.emailFocus,
                        keyboardType: TextInputType.number,
                        oldDesign: false,
                        validationText: controller.phoneValidationText,
                        label: 'Phone Number',
                      ),
                      SizedBox(height: AppDecoration().screenHeight * 0.01),
                      CustomTextFormField(
                        leading: const Icon(
                          Icons.mail,
                          color: AppColors.primaryColor,
                        ),
                        textEditingController: controller.emailCon,
                        nextFocusNode: controller.messageFocus,
                        focusNode: controller.emailFocus,
                        oldDesign: false,
                        validationText: controller.emailValidationText,
                        label: 'Email',
                      ),
                      SizedBox(height: AppDecoration().screenHeight * 0.01),
                      CustomTextFormField(
                        leading: const Icon(
                          Icons.message,
                          color: AppColors.primaryColor,
                        ),
                        textEditingController: controller.messageCon,
                        focusNode: controller.messageFocus,
                        validationText: controller.messageValidationText,
                        oldDesign: false,
                        maxLines: null,
                        label: 'Message',
                      ),
                      SizedBox(height: AppDecoration().screenHeight * 0.02),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.05),
            CustomButton(
              function: () {
                controller.contactUs();
              },
              text: 'Submit',
              textColor: AppColors.secondaryColor,
              buttonColor: AppColors.primaryColor,
              circularRadius: 10,
              width: 0.7,
            ),
          ],
        ),
      ),
    );
  }
}
