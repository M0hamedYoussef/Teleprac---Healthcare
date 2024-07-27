import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard/chats/my_chats_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/home/dashboard/my_chats/chats_screen/chats_list.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class MyChatsScreen extends StatelessWidget {
  const MyChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyChatsController());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: SafeArea(
        child: Column(
          children: [
            const UpperPart(
              text: AppTexts.myChats,
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.02),
            const MyChatsList(),
          ],
        ),
      ),
    );
  }
}
