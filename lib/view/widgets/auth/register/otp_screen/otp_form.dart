import 'package:teleprac/controller/auth/register_con.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/const/colors.dart';

class VerifyOtpForm extends GetView<RegisterCon> {
  const VerifyOtpForm({super.key});
  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      numberOfFields: 6,
      autoFocus: true,
      showFieldAsBox: true,
      cursorColor: AppColors.primaryColor,
      focusedBorderColor: AppColors.primaryColor,
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      onSubmit: (code) {
        controller.verifyOtp();
      },
    );
  }
}
