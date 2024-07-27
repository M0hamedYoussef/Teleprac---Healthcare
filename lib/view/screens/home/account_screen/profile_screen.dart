import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/account_settings/profile_controller.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/view/widgets/global/custom_container.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/main/doctor/doctor_widgets.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/main/global/main_data.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/main/patient/patient_widgets.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/main/pharmacy/pharmacy_widgets.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/upper_stack.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      body: WillPopScope(
        onWillPop: controller.willPop,
        child: SafeArea(
          child: CustomContainer(
            listView: true,
            margin: null,
            height: 1,
            children: [
              const ProfileStack(),
              SizedBox(height: AppDecoration().screenHeight * .06),
              if (controller.userRole == '1' ||
                  controller.userRole == '7' ||
                  controller.userRole == '2')
                const MainData(),
              if (controller.userRole == '5') const PharmacyWidgets(),
              if (controller.userRole == '1' || controller.userRole == '7')
                const DoctorWidgets(),
              if (controller.userRole == '2') const PatientUpdateButton(),
              SizedBox(height: AppDecoration().screenHeight * .02),
            ],
          ),
        ),
      ),
    );
  }
}
