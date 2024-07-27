import 'package:get/get.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/model/home/dashboard/recommended_test_model.dart';
import 'package:teleprac/routes.dart';

class PayForLabTestCheckoutController extends GetxController {
  late RecommendedTestModel recommendedTestModel;
  List tests = [];
  double totalPrice = 0;
  Crud crud = Crud();

  @override
  void onInit() {
    recommendedTestModel = Get.arguments['recommendedTestModel'];
    for (LabtestDetails labtestDetailsModel
        in recommendedTestModel.labtestDetails!) {
      tests.add(labtestDetailsModel);
      totalPrice = totalPrice + int.parse(labtestDetailsModel.finalPrice!);
    }
    super.onInit();
  }

  statesRequest() async {
    var res = await crud.connect(
      link: AppLinks.locationsApi,
      data: {
        'type': '2',
        'id': '101',
      },
      headers: {
        'token': AppLinks.token,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  checkout() async {
    loading();
    var statesRes = await statesRequest();
    ResponseModel statesResponseModel = ResponseModel.fromJson(statesRes);
    Get.offNamed(
      AppRoutes.billing,
      arguments: {
        'states': statesResponseModel.requestedList,
        'recommendedTestModel': recommendedTestModel,
        'isPayForLabTests': true,
      },
    );
  }
}
