import 'package:teleprac/controller/home/account_settings/account_controller.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/global/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePassword extends GetView<AccountController> {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      onTap: () {
        controller.onChangePasswordPressed();
      },
      title: AppTexts.changePass,
      image: AppDecoration.changePass,
    );
  }
}
