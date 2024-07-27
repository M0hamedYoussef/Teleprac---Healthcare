import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:teleprac/controller/home/dashboard/chats/my_chats_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/home/dashboard/chat/chat_model.dart';

class MyChatsList extends GetView<MyChatsController> {
  const MyChatsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: controller.myChats.length,
        physics: const BouncingScrollPhysics(parent: PageScrollPhysics()),
        itemBuilder: (context, index) {
          ChatModel chatModel = ChatModel.fromJson(controller.myChats[index]);

          return GestureDetector(
            onTap: () {
              controller.getMessagesAndOpenChat(chatModel: chatModel);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.secondaryColor,
              ),
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
              ),
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  SizedBox(width: AppDecoration().screenWidth * 0.02),
                  Hero(
                    tag: chatModel.userid!,
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        chatModel.profileimage!,
                      ),
                      backgroundColor: AppColors.secondaryColor,
                      radius: 30,
                    ),
                  ),
                  SizedBox(width: AppDecoration().screenWidth * 0.03),
                  FittedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: AppDecoration().screenWidth * 0.5,
                          child: Text(
                            chatModel.fullName!,
                            style: TextStyle(
                              fontSize: AppDecoration().screenWidth * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: AppDecoration().screenWidth * 0.5,
                          child: Text(
                            chatModel.lastchat != null
                                ? chatModel.lastchat!.length < 20
                                    ? chatModel.lastchat!
                                    : chatModel.lastchat!.replaceRange(
                                        17,
                                        chatModel.lastchat!.length,
                                        '...',
                                      )
                                : '',
                            style: TextStyle(
                              fontSize: AppDecoration().screenWidth * 0.04,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
