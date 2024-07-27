import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/main_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/model/home/cart_item_model.dart';
import 'package:teleprac/model/home/offers_model.dart';
import 'package:teleprac/model/labs/tests/test_model.dart';
import 'package:teleprac/model/pharmacies/product_model.dart';
import 'package:teleprac/routes.dart';

class OffersController extends GetxController {
  late OffersModel offerModel;
  late List allProductsList;
  late List allTetsList;
  List offerProducts = [];
  List offerTests = [];
  MainController mainController = Get.find();
  MyServices myServices = Get.find();

  @override
  void onInit() {
    offerModel = Get.arguments['offerModel'];
    if (offerModel.type == '0') {
      allProductsList = Get.arguments['allProductsList'];
      for (var element in allProductsList) {
        ProductModel productModel = ProductModel.fromJson(element);
        if (offerModel.allProductsIds!.contains(productModel.id)) {
          offerProducts.add(productModel);
        }
      }
    } else if (offerModel.type == '1') {
      allTetsList = Get.arguments['allTests'];
      for (var element in allTetsList) {
        TestModel testModel = TestModel.fromJson(element);
        if (offerModel.allProductsIds!.contains(testModel.id)) {
          offerTests.add(testModel);
        }
      }
    }

    super.onInit();
  }

  productDetails({required ProductModel productModel}) async {
    loading();
    await myServices.sharedPreferences.setString('lastViewingType', 'product');
    await myServices.sharedPreferences
        .setString('lastProductID', productModel.id ?? '');
    await myServices.sharedPreferences
        .setString('lastProductImage', productModel.uploadImageUrl ?? '');
    await myServices.sharedPreferences
        .setString('lastProductDiscount', productModel.discount ?? '');
    await myServices.sharedPreferences
        .setString('lastProductPrice', productModel.price ?? '');
    await myServices.sharedPreferences
        .setString('lastProductSalePrice', productModel.salePrice ?? '');
    await myServices.sharedPreferences
        .setString('lastProductMedicineType', productModel.medicineType ?? '');
    await myServices.sharedPreferences
        .setString('lastProductName', productModel.name ?? '');
    await myServices.sharedPreferences.setString(
        'lastProductManufacturedBy', productModel.manufacturedBy ?? '');
    await myServices.sharedPreferences
        .setString('lastProductComposition', productModel.composition ?? '');
    await myServices.sharedPreferences.setString(
        'lastProductShortDescription', productModel.shortDescription ?? '');
    mainController.setLast();
    await mainController.getCartProducts();
    List cartProductsIds = [];
    for (var product in mainController.cartProducts) {
      cartProductsIds.add(CartItemModel.fromJson(product).productModel!.id);
    }
    Get.offNamed(
      AppRoutes.productDetails,
      arguments: {
        'productModel': productModel,
        'cartProducts': cartProductsIds,
      },
    );
  }

  Future<bool> willPop() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.lightGrey1,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    Get.back();
    return Future.value(false);
  }
}
