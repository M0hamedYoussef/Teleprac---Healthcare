import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/account_settings/account_controller.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/view/widgets/home/account_settings/tiles/aboutus_tile.dart';
import 'package:teleprac/view/widgets/home/account_settings/tiles/change_password.dart';
import 'package:teleprac/view/widgets/home/account_settings/tiles/contactus_tile.dart';
import 'package:teleprac/view/widgets/home/account_settings/tiles/logout_tile.dart';
import 'package:teleprac/view/widgets/home/account_settings/tiles/profile_settings.dart';
import 'package:teleprac/view/widgets/home/account_settings/upper_stack.dart';
import 'package:teleprac/view/widgets/home/account_settings/welcome_text.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AccountController controller = Get.put(AccountController());

    return Scaffold(
      body: WillPopScope(
        onWillPop: controller.willPop,
        child: Column(
          children: [
            const SettingStack(),
            Expanded(
              child: ListView(
                physics: const PageScrollPhysics(),
                children: [
                  SizedBox(height: AppDecoration().screenHeight * .03),
                  const WelcomeText(),
                  SizedBox(height: AppDecoration().screenHeight * .03),
                  const ProfileSettings(),
                  const ChangePassword(),
                  const SettingsAboutUs(),
                  const SettingsContactUs(),
                  const SettingsLogout(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
