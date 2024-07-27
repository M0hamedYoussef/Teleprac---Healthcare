import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/account_settings/profile_controller.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/custom_text_form_field.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/drop_down.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/main/doctor/education_update.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/main/doctor/experience_update.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/main/doctor/specialization_and_services.dart';

class DoctorWidgets extends StatelessWidget {
  const DoctorWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextFormField(
              leading: const Icon(
                Icons.info,
                color: AppColors.primaryColor,
              ),
              textEditingController: controller.biographyCon,
              maxLines: null,
              label: 'About Me',
            ),
            SizedBox(height: AppDecoration().screenHeight * .02),
            CustomTextFormField(
              leading: const Icon(
                Icons.numbers,
                color: AppColors.primaryColor,
              ),
              textEditingController: controller.registerNoCon,
              validationText: controller.regNumValidationText,
              focusNode: FocusNode(),
              label: 'Regstiration Number',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "About Clinic",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: AppDecoration().screenWidth * 0.045,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            CustomTextFormField(
              leading: const Icon(
                Icons.local_hospital,
                color: AppColors.primaryColor,
              ),
              textEditingController: controller.clinicNameCon,
              nextFocusNode: controller.clinicAddressFocus,
              label: 'Clinic Name',
            ),
            SizedBox(height: AppDecoration().screenHeight * .01),
            CustomTextFormField(
              leading: const Icon(
                Icons.local_hospital,
                color: AppColors.primaryColor,
              ),
              focusNode: controller.clinicAddressFocus,
              textEditingController: controller.clinicAddressCon,
              label: 'Clinic Address',
            ),
            SizedBox(height: AppDecoration().screenHeight * .01),
            const SpecializationAndServices(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Pricing",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: AppDecoration().screenWidth * 0.045,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            CustomDropDown(
              dropdownList: controller.priceTypes,
              value: controller.priceType,
              onChanged: (val) {
                controller.priceType = val!;
                controller.update();
              },
              label: 'Price Type',
            ),
            if (controller.priceType == 'Custom Price')
              CustomTextFormField(
                leading: const Icon(
                  Icons.attach_money,
                  color: AppColors.primaryColor,
                ),
                textEditingController: controller.amountCon,
                label: 'Amount',
              ),
            SizedBox(height: AppDecoration().screenHeight * .02),
            const EducationUpdate(),
            SizedBox(height: AppDecoration().screenHeight * .02),
            const ExperienceUpdate(),
            SizedBox(height: AppDecoration().screenHeight * .02),
            CustomButton(
              function: () {
                controller.updateDoctorProfile();
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
