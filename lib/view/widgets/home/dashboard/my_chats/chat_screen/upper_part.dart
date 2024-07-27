import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard/chats/chat_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class UpperPart extends GetView<ChatController> {
  const UpperPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
      ),
      width: AppDecoration().screenWidth,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                CupertinoIcons.back,
                color: AppColors.secondaryColor,
                size: AppDecoration().screenWidth * 0.076,
              ),
            ),
            Row(
              children: [
                Hero(
                  tag: controller.chatModel.userid!,
                  child: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                        controller.chatModel.profileimage!),
                    backgroundColor: AppColors.primaryColor,
                    radius: 25,
                  ),
                ),
                SizedBox(width: AppDecoration().screenWidth * 0.02),
                SizedBox(
                  width: AppDecoration().screenWidth * 0.65,
                  child: Text(
                    controller.chatModel.fullName!,
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.05,
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppDecoration.cairo,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
