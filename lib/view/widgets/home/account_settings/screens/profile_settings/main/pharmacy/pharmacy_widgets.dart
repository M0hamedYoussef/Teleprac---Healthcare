import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/account_settings/profile_controller.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/custom_text_form_field.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class PharmacyWidgets extends StatelessWidget {
  const PharmacyWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      leading: const Icon(
                        Icons.person,
                        color: AppColors.primaryColor,
                      ),
                      padding: EdgeInsets.zero,
                      textEditingController: controller.firstNameCon,
                      focusNode: controller.firstNameFocus,
                      validationText: controller.firstNameValidationText,
                      onEditingComplete: controller.firstNameEditingCompleted,
                      label: 'First Name',
                    ),
                  ),
                  SizedBox(width: AppDecoration().screenWidth * .02),
                  Expanded(
                    child: CustomTextFormField(
                      leading: const Icon(
                        Icons.person,
                        color: AppColors.primaryColor,
                      ),
                      textEditingController: controller.lastNameCon,
                      focusNode: controller.lastNameFocus,
                      padding: EdgeInsets.zero,
                      validationText: controller.lastNameValidationText,
                      onEditingComplete: controller.lastNameEditingCompleted,
                      label: 'Last Name',
                    ),
                  ),
                ],
              ),
            ),
            CustomTextFormField(
              leading: const Icon(
                Icons.location_city,
                color: AppColors.primaryColor,
              ),
              textEditingController: controller.firstAddressCon,
              focusNode: controller.firstAddressFocus,
              validationText: controller.firstAddressValidationText,
              onEditingComplete: controller.firstAddressEditingCompleted,
              label: 'First Address',
            ),
            CustomTextFormField(
              leading: const Icon(
                Icons.location_city,
                color: AppColors.primaryColor,
              ),
              textEditingController: controller.secondAddressCon,
              focusNode: controller.secondAddressFocus,
              validationText: controller.secondAddressValidationText,
              onEditingComplete: controller.secondAddressEditingCompleted,
              label: 'Second Address',
            ),
            CustomButton(
              function: () {
                controller.updatePharmacyProfile();
              },
              buttonColor: AppColors.primaryColor,
              circularRadius: 10,
              text: 'Update Profile',
            ),
          ],
        );
      },
    );
  }
}
