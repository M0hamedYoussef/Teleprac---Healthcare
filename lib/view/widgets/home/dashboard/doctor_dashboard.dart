import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard_controller.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:flutter/material.dart';
import 'package:teleprac/view/widgets/global/custom_list_tile.dart';

class DoctorDashboard extends GetView<DashboardController> {
  const DoctorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomListTile(
          onTap: () {
            controller.myAppointments();
          },
          title: AppTexts.myAppointments,
          image: AppDecoration.myAppointments,
        ),
        CustomListTile(
          onTap: () {
            controller.getSchedule();
          },
          title: AppTexts.scheduleAppointments,
          icon: Icons.timer_outlined,
        ),
        CustomListTile(
          onTap: () {
            controller.myPatients();
          },
          title: AppTexts.myPatients,
          image: AppDecoration.doctor,
        ),
        CustomListTile(
          onTap: () {
            controller.myMessages();
          },
          title: AppTexts.myMessages,
          image: AppDecoration.myMessages,
        ),
        CustomListTile(
          onTap: () {
            controller.myReviews();
          },
          title: AppTexts.reviews,
          image: AppDecoration.reviews,
        ),
        CustomListTile(
          onTap: () {
            controller.doctorAccounts();
          },
          title: 'Accounts',
          icon: Icons.monetization_on_outlined,
        ),
      ],
    );
  }
}
