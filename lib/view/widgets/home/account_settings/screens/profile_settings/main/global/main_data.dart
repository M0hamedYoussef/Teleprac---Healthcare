import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/account_settings/profile_controller.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/custom_text_form_field.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/date_picker.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/drop_down.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class MainData extends StatelessWidget {
  const MainData({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Column(
          children: [
            CustomDatePicker(
              date: controller.dob,
              validationText: controller.dobValidationText,
              onTap: () {
                controller.selectDate(context: context);
              },
            ),
            SizedBox(height: AppDecoration().screenHeight * .02),
            CustomDropDown(
              leading: Icon(
                controller.gender.toLowerCase() == '1'
                    ? Icons.man
                    : Icons.woman,
                color: AppColors.primaryColor,
              ),
              dropdownList: controller.genders,
              value: controller.gender,
              label: 'Gender',
              validationText: controller.genderValidationText,
              onChanged: (String? val) {
                controller.gender = val!;
                controller.update();
              },
            ),
            SizedBox(height: AppDecoration().screenHeight * .02),
            CustomDropDown(
              leading: const Icon(
                Icons.bloodtype_sharp,
                color: AppColors.primaryColor,
              ),
              dropdownList: controller.bloodGroups,
              value: controller.bloodGroup,
              validationText: controller.bloodGroupValidationText,
              label: 'Blood Group',
              onChanged: (String? val) {
                controller.bloodGroup = val!;
                controller.update();
              },
            ),
            SizedBox(height: AppDecoration().screenHeight * .02),
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
            CustomTextFormField(
              leading: const Icon(
                Icons.mail,
                color: AppColors.primaryColor,
              ),
              textEditingController: controller.postalCodeCon,
              focusNode: controller.postalCodeFocus,
              keyboardType: TextInputType.number,
              validationText: controller.postalCodeValidationText,
              label: 'Postal Code',
            ),
            SizedBox(height: AppDecoration().screenHeight * .01),
            CustomDropDown(
              leading: const Icon(
                Icons.location_city,
                color: AppColors.primaryColor,
              ),
              dropdownList: controller.states,
              validationText: controller.stateValidationText,
              value: controller.state,
              label: 'State',
              onChanged: (String? val) {
                controller.stateSelected(id: val!);
              },
            ),
            SizedBox(height: AppDecoration().screenHeight * .02),
            if (controller.state != '0' && controller.state.isNotEmpty)
              GestureDetector(
                onTap: () {
                  if (controller.cities.isEmpty) {
                    Get.defaultDialog(middleText: 'Choose State First');
                  }
                },
                child: CustomDropDown(
                  leading: const Icon(
                    Icons.location_city,
                    color: AppColors.primaryColor,
                  ),
                  validationText: controller.cityValidationText,
                  dropdownList: controller.cities,
                  value: controller.cities
                          .toString()
                          .contains('value: ${controller.city.trim()},')
                      ? controller.city
                      : '',
                  label: 'City',
                  onChanged: (String? val) {
                    controller.city = val!;

                    controller.update();
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
