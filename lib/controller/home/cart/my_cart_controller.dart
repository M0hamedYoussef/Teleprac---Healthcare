import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/main_controller.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/model/home/cart_item_model.dart';
import 'package:teleprac/model/pharmacies/product_model.dart';
import 'package:teleprac/routes.dart';

class MyCartController extends GetxController {
  late CollectionReference carts;
  late DocumentReference myCart;
  late String myId;
  late List cartProducts;
  late double totalPrice;
  late double discount;
  Crud crud = Crud();
  MyServices myServices = Get.find();
  MainController mainController = Get.find();
  // List pharmaciesInTheCart = [];

  @override
  void onInit() {
    super.onInit();
    myId = myServices.sharedPreferences.getString('id')!;
    // carts = FirebaseFirestore.instance.collection('carts');
    // myCart = carts.doc(myId);
    cartProducts = Get.arguments['cartProducts'];
    calculatePrice();
  }

  productDetails({required ProductModel productModel}) async {
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
    List cartProductsIds = [];
    for (var product in cartProducts) {
      cartProductsIds.add(CartItemModel.fromJson(product).productModel!.id);
    }
    Get.toNamed(
      AppRoutes.productDetails,
      arguments: {
        'productModel': productModel,
        'cartProducts': cartProductsIds,
      },
    );
  }

  removeFromCart({
    required ProductModel productModel,
    required int index,
  }) async {
    loading();
    // for (var cartItem in mainController.cartProducts) {
    //   if (cartItem['product_id'] == productModel.id) {
    //     mainController.cartProducts.remove(cartItem);
    //     break;
    //   }
    // }
    // await myCart.set({
    // 'products': mainController.cartProducts,
    // });
    // for (ProductModel cartProductModel in cartProducts) {
    //   if (cartProductModel.id == productModel.id) {
    //     cartProducts.remove(cartProductModel);
    //     break;
    //   }
    // }
    await removeFromCartRequest(id: productModel.id!);
    cartProducts.removeAt(index);
    calculatePrice();
    Get.back();
    update();
  }

  calculatePrice() {
    discount = 0;
    totalPrice = 0;
    for (var product in cartProducts) {
      CartItemModel cartItemModel = CartItemModel.fromJson(product);
      ProductModel productModel = cartItemModel.productModel!;
      double productPrice;
      if (productModel.discount.toString().removeAllWhitespace != '0' &&
          productModel.discount != null &&
          productModel.discount!.isNotEmpty &&
          productModel.price != productModel.salePrice) {
        discount = discount +
            (double.parse(productModel.discount!) *
                int.parse(cartItemModel.qty!));
        productPrice = double.parse(productModel.salePrice!);
      } else {
        productPrice = double.parse(productModel.price!);
      }
      totalPrice = totalPrice + (productPrice * int.parse(cartItemModel.qty!));
    }
    update();
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
    if (statesRes is RequsetStatus == false) {
      ResponseModel statesResponseModel = ResponseModel.fromJson(statesRes);
      if (statesResponseModel.responseCode == '200') {
        Get.offNamed(
          AppRoutes.billing,
          arguments: {
            'states': statesResponseModel.requestedList,
            'cartProducts': cartProducts,
            'pharmaciesInTheCart': [
              CartItemModel.fromJson(cartProducts[0]).productModel!.userId!,
            ],
          },
        );
      } else {
        Get.back();
        Fluttertoast.showToast(
          msg: 'Somthing Went Wrong',
          textColor: AppColors.black,
          backgroundColor: AppColors.secondaryColor,
        );
      }
    }
  }

  removeOneFromCart({
    required CartItemModel cartItemModel,
    required int index,
  }) async {
    if (cartItemModel.qty == '1') {
      removeFromCart(
        productModel: cartItemModel.productModel!,
        index: index,
      );
    } else {
      loading();
      await removeOneFromCartRequest(
        id: cartItemModel.productModel!.id!,
        qty: cartItemModel.qty!,
      );
      Get.back();
      cartProducts[index]['qty'] =
          (int.parse(cartItemModel.qty!) - 1).toString();
      calculatePrice();
    }
  }

  addOneToCart({
    required CartItemModel cartItemModel,
    required int index,
  }) async {
    loading();
    await addOneToCartRequest(
      id: cartItemModel.productModel!.id!,
      qty: cartItemModel.qty!,
    );
    Get.back();
    cartProducts[index]['qty'] = (int.parse(cartItemModel.qty!) + 1).toString();
    calculatePrice();
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

  addOneToCartRequest({
    required String id,
    required String qty,
  }) async {
    var res = await crud.connect(
      link: AppLinks.updateCart,
      data: {
        'product_id': md5.convert(utf8.encode(id)).toString(),
        'qty': (int.parse(qty) + 1).toString(),
        'action': 'update',
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  removeOneFromCartRequest({
    required String id,
    required String qty,
  }) async {
    var res = await crud.connect(
      link: AppLinks.updateCart,
      data: {
        'product_id': md5.convert(utf8.encode(id)).toString(),
        'qty': (int.parse(qty) - 1).toString(),
        'action': 'update',
      },
    );
    return res.fold((l) => l, (r) => r);
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
