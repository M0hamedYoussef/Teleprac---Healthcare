import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/account_settings/profile_controller.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/core/const/colors.dart';

class PatientUpdateButton extends GetView<ProfileController> {
  const PatientUpdateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      function: () {
        controller.updatePatientProfile();
      },
      buttonColor: AppColors.primaryColor,
      circularRadius: 10,
      text: 'Update Profile',
    );
  }
}
