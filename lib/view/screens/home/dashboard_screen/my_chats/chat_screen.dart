import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard/chats/chat_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/home/dashboard/chat/message_model.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/custom_text_form_field.dart';
import 'package:teleprac/view/widgets/home/dashboard/my_chats/chat_screen/upper_part.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ChatController controller = Get.put(ChatController());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: SafeArea(
        child: Column(
          children: [
            const UpperPart(),
            SizedBox(height: AppDecoration().screenHeight * 0.01),
            Expanded(
              child: GetBuilder<ChatController>(
                builder: (_) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    reverse: true,
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      MessageModel messageModel = MessageModel.fromJson(
                        controller.messages.reversed.toList()[index],
                      );
                      return Column(
                        crossAxisAlignment:
                            messageModel.chatFrom == controller.myID
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: messageModel.chatFrom == controller.myID
                                ? const EdgeInsets.only(right: 45.0)
                                : const EdgeInsets.only(left: 45.0),
                            child: Text(messageModel.fromUserName!),
                          ),
                          Stack(
                            children: [
                              if (messageModel.chatFrom != controller.myID)
                                Positioned(
                                  left: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: CircleAvatar(
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        messageModel.profileFromImage!,
                                      ),
                                      backgroundColor: AppColors.transparent,
                                    ),
                                  ),
                                ),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.secondaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                margin: messageModel.chatFrom == controller.myID
                                    ? const EdgeInsets.fromLTRB(80, 5, 50, 10)
                                    : const EdgeInsets.fromLTRB(50, 5, 80, 10),
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  messageModel.content!,
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppDecoration.cairo,
                                    fontSize:
                                        AppDecoration().screenWidth * 0.04,
                                  ),
                                ),
                              ),
                              if (messageModel.chatFrom == controller.myID)
                                Positioned(
                                  right: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: CircleAvatar(
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        messageModel.profileFromImage!,
                                      ),
                                      backgroundColor: AppColors.transparent,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    textEditingController: controller.textEditingController,
                    label: 'Send Message',
                    formColor: AppColors.secondaryColor,
                    maxLines: null,
                    padding: const EdgeInsets.all(10),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.sendMessage();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: AppDecoration().screenWidth * 0.12,
                    width: AppDecoration().screenWidth * 0.12,
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.only(left: 5, right: 10),
                    child: SvgPicture.asset(
                      AppDecoration.send,
                      width: AppDecoration().screenWidth * 0.05,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primaryColor,
                        BlendMode.srcIn,
                      ),
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
