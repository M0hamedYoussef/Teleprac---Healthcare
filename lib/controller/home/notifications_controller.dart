import 'package:get/get.dart';
import 'package:teleprac/core/class/crud.dart';

class NotificationsController extends GetxController {
  late List notifications;
  Crud crud = Crud();

  @override
  void onInit() {
    notifications = Get.arguments['notifications'];
    super.onInit();
  }
}
