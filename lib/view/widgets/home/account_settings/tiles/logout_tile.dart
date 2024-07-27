import 'package:teleprac/controller/home/account_settings/account_controller.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/global/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsLogout extends GetView<AccountController> {
  const SettingsLogout({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      onTap: () {
        controller.logout();
      },
      title: AppTexts.logout,
      icon: Icons.logout,
    );
  }
}
