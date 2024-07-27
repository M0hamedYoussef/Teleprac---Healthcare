import 'package:get/get.dart';

class MyReviewsController extends GetxController {
  late List myReviews;

  @override
  void onInit() {
    myReviews = Get.arguments['reviews_list'];
    super.onInit();
  }
}
