import 'package:get/get.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/routes.dart';

class PayForMedicinesController extends GetxController {
  late List products;
  double totalPrice = 0;
  Crud crud = Crud();

  @override
  void onInit() {
    products = Get.arguments['products'];
    for (var product in products) {
      totalPrice = totalPrice + double.parse(product['price'].toString());
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
        'cartProducts': products,
        'isPayForMedicine': true,
        'pharmaciesInTheCart': [
          products[0]['pharmacy_id'],
        ],
      },
    );
  }
}
