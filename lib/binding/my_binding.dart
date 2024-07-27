import 'package:get/get.dart';
import 'package:teleprac/controller/main_controller.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(MainController());
  }
}
