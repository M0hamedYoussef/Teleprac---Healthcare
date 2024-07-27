import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard_controller.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/home/dashboard/doctor_dashboard.dart';
import 'package:teleprac/view/widgets/home/dashboard/patient_dashboard.dart';
import 'package:teleprac/view/widgets/home/dashboard/pharmacy_dashboard.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());

    return Scaffold(
      body: WillPopScope(
        onWillPop: controller.willPop,
        child: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            children: [
              const UpperPart(
                text: AppTexts.dashboard,
                changeStatusbarColor: true,
              ),
              SizedBox(height: AppDecoration().screenHeight * 0.03),
              Hero(
                tag: AppDecoration.dashboard,
                child: Image.asset(
                  AppDecoration.dashboard,
                  height: AppDecoration().screenHeight * 0.15,
                ),
              ),
              SizedBox(height: AppDecoration().screenHeight * 0.02),
              Text(
                AppTexts.dashboard,
                style: TextStyle(
                  fontSize: AppDecoration().screenHeight * 0.032,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppDecoration().screenHeight * 0.03),
              if (controller.myRole == '1') const DoctorDashboard(),
              if (controller.myRole == '2') const PatientDashboard(),
              if (controller.myRole == '5') const PharmacyDashboard(),
              SizedBox(height: AppDecoration().screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
