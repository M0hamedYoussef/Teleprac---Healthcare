import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard_controller.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:flutter/material.dart';
import 'package:teleprac/view/widgets/global/custom_list_tile.dart';

class PatientDashboard extends GetView<DashboardController> {
  const PatientDashboard({super.key});

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
            controller.myPrescriptions();
          },
          title: AppTexts.myPrescriptions,
          image: AppDecoration.myPrescriptions,
        ),
        CustomListTile(
          onTap: () {
            controller.myLabAppointments();
          },
          title: AppTexts.myLabReports,
          image: AppDecoration.myLabReports,
        ),
        CustomListTile(
          onTap: () {
            controller.payForMedicines();
          },
          title: AppTexts.payForMedicines,
          image: AppDecoration.payForMedicine,
        ),
        CustomListTile(
          onTap: () {
            controller.payForLabTests();
          },
          title: AppTexts.payForLabTests,
          image: AppDecoration.payForLabTests,
        ),
        // CustomListTile(
        //   onTap: () {},
        //   title: AppTexts.payForNursing,
        //   image: AppDecoration.payNursingCare,
        // ),
        CustomListTile(
          onTap: () {
            controller.myFamily();
          },
          title: AppTexts.myFamily,
          image: AppDecoration.myFamily,
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
            controller.myInvoices();
          },
          title: AppTexts.myInvoices,
          image: AppDecoration.myInvoices,
        ),
        CustomListTile(
          onTap: () {
            controller.myMedicalHistory();
          },
          title: AppTexts.medicalHistory,
          icon: Icons.history,
        ),
        CustomListTile(
          onTap: () {
            controller.myFavourites();
          },
          title: AppTexts.favourites,
          image: AppDecoration.favourites,
        ),
        // CustomListTile(
        //   onTap: () {},
        //   title: AppTexts.trackMyOrders,
        //   image: AppDecoration.trackMyOrders,
        // ),
        CustomListTile(
          onTap: () {
            controller.myOrders();
          },
          title: AppTexts.myOrders,
        ),
      ],
    );
  }
}
