import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/const/colors.dart';

class SuccessScreenCon extends GetxController {
  late void Function() function;
  late String buttonText;
  String? centerText;

  @override
  void onInit() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    function = Get.arguments['function'];
    buttonText = Get.arguments['buttonText'];
    centerText = Get.arguments['centerText'];
    super.onInit();
  }
}
