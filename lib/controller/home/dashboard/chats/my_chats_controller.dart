import 'package:get/get.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/model/home/dashboard/chat/chat_model.dart';
import 'package:teleprac/routes.dart';

class MyChatsController extends GetxController {
  late List myChats;
  Crud crud = Crud();
  MyServices myServices = Get.find();

  @override
  void onInit() {
    myChats = Get.arguments['chatsList'];
    super.onInit();
  }

  getMessagesAndOpenChat({required ChatModel chatModel}) async {
    loading();
    var res = await getMessagesRequest(chatModel: chatModel);
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200' ||
          responseModel.responseCode == '201') {
        Get.offNamed(
          AppRoutes.privateChatScreen,
          arguments: {
            'chatModel': chatModel,
            'messagesList': responseModel.chatMessages ?? [],
          },
        );
      }
    }
  }

  getMessagesRequest({required ChatModel chatModel}) async {
    var res = await crud.connect(
      link: AppLinks.chatMessages,
      data: {
        'user_id': chatModel.userid,
      },
      headers: {
        'token':  myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }
}
