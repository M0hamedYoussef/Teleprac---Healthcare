import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/model/home/dashboard/chat/chat_model.dart';
import 'package:teleprac/routes.dart';

class ChatController extends GetxController {
  late ChatModel chatModel;
  late List messages;
  late String myID;
  late String myPFP;
  late String myFirstName;
  late String myLastName;
  late String myFullName;
  Crud crud = Crud();
  MyServices myServices = Get.find();
  TextEditingController textEditingController = TextEditingController();
  String? savedMessage;

  @override
  void onInit() {
    chatModel = Get.arguments['chatModel'];
    messages = Get.arguments['messagesList'];
    myID = myServices.sharedPreferences.getString('id')!;
    myPFP = myServices.sharedPreferences.getString('pfp')!;
    myFirstName = myServices.sharedPreferences.getString('first_name')!;
    myLastName = myServices.sharedPreferences.getString('last_name')!;
    myFullName = '$myFirstName $myLastName';
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (Get.currentRoute != AppRoutes.privateChatScreen) {
        timer.cancel();
      } else {
        if (savedMessage == null) {
          getMessages();
        }
      }
    });
    super.onInit();
  }

  sendMessage() async {
    if (textEditingController.text.isNotEmpty) {
      savedMessage = textEditingController.text.trim();
      textEditingController.clear();
      messages.add(
        {
          'chat_from': myID,
          'profile_from_image': myPFP,
          'from_user_name': myFullName,
          'content': savedMessage,
        },
      );
      update();
      await sendMessageRequest();
      savedMessage = null;
    }
  }

  getMessages() async {
    var res = await getMessagesRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        if (responseModel.chatMessages!.length > messages.length) {
          messages = responseModel.chatMessages!;
          update();
        }
      }
    }
  }

  getMessagesRequest() async {
    var res = await crud.connect(
      link: AppLinks.chatMessages,
      data: {
        'user_id': chatModel.userid,
      },
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  sendMessageRequest() async {
    var res = await crud.connect(
      link: AppLinks.sendMessage,
      data: {
        'user_id': chatModel.userid,
        'message': savedMessage,
      },
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }
}
