import 'package:get/get.dart';
import 'package:teleprac/model/home/blogs_model.dart';

class BlogsController extends GetxController {
  late BlogsModel blogModel;

  @override
  void onInit() {
    blogModel = Get.arguments['blogModel'];
    super.onInit();
  }

}
