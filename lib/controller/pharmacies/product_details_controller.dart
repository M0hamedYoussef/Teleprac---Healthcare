import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/main_controller.dart';
import 'package:teleprac/controller/search_con.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/model/pharmacies/product_model.dart';
import 'package:teleprac/routes.dart';

class ProductDetailsController extends GetxController {
  // late CollectionReference carts;
  // late DocumentReference myCart;
  // late String myId;
  late List pharmacies;
  late List pharmaciesCategories;
  late List pharmaciesProducts;
  late List units;
  late List cartProducts;
  late ProductModel productModel;
  late String previousRoute;
  Crud crud = Crud();
  MyServices myServices = Get.find();
  MainController mainController = Get.find();

  @override
  void onInit() {
    super.onInit();
    productModel = Get.arguments['productModel'];
    cartProducts = Get.arguments['cartProducts'];
    previousRoute = Get.previousRoute;
    // myId = myServices.sharedPreferences.getString('id')!;
    // carts = FirebaseFirestore.instance.collection('carts');
    // myCart = carts.doc(myId);
  }

  addToCart() async {
    loading();
    await addToCartRequest(
      id: productModel.id!,
    );
    cartProducts.add(productModel.id);
    // mainController.cartProducts.add({
    //   'product_id': productModel.id,
    //   'qty': '1',
    // });

    // await myCart.set({
    //   'products': mainController.cartProducts,
    // });
    Get.back();
    update();
  }

  removeFromCart() async {
    loading();
    // for (var cartItem in mainController.cartProducts) {
    //   if (cartItem['product_id'] == productModel.id) {
    //     mainController.cartProducts.remove(cartItem);
    //     break;
    //   }
    // }
    // await myCart.set({
    //   'products': mainController.cartProducts,
    // });
    await removeFromCartRequest(
      id: productModel.id!,
    );
    cartProducts.remove(productModel.id);
    Get.back();
    update();
  }

  addToCartRequest({
    required String id,
  }) async {
    var res = await crud.connect(
      link: AppLinks.addToCart,
      data: {
        'product_id': md5.convert(utf8.encode(id)).toString(),
      },
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  removeFromCartRequest({
    required String id,
  }) async {
    var res = await crud.connect(
      link: AppLinks.updateCart,
      data: {
        'product_id': md5.convert(utf8.encode(id)).toString(),
        'action': 'remove',
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  Future<bool> willPop() {
    Get.back();
    if (previousRoute == AppRoutes.pharmaciesProducts) {
      SearchCon searchCon = Get.find();
      searchCon.update();
    }
    return Future.value(false);
  }
}
