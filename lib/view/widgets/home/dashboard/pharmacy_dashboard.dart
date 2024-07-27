import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard_controller.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:flutter/material.dart';
import 'package:teleprac/view/widgets/global/custom_list_tile.dart';

class PharmacyDashboard extends GetView<DashboardController> {
  const PharmacyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomListTile(
          onTap: () {
            controller.myMessages();
          },
          title: AppTexts.myMessages,
          image: AppDecoration.myMessages,
        ),
        CustomListTile(
          onTap: () {
            controller.myProducts();
          },
          title: AppTexts.myProducts,
        ),
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
