import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/main_controller.dart';
import 'package:teleprac/controller/search_con.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/model/home/cart_item_model.dart';
import 'package:teleprac/model/pharmacies/pharmacy_model.dart';
import 'package:teleprac/model/pharmacies/product_model.dart';
import 'package:teleprac/routes.dart';

class PharmaciesController extends GetxController {
  late CollectionReference carts;
  late DocumentReference myCart;
  late String myId;
  late List pharmaciesCategories;
  late List pharmaciesProducts;
  late List units;
  List cartProducts = [];
  List pharmacies = [];
  bool pharmacySelected = false;
  PharmacyModel? pharmacyModel;
  Crud crud = Crud();
  SearchCon searchCon = Get.find();
  MyServices myServices = Get.find();
  MainController mainController = Get.find();

  @override
  void onInit() {
    super.onInit();
    // pharmacies = Get.arguments['pharmaciesList'];
    pharmaciesCategories = Get.arguments['pharmaciesCategories'];
    pharmaciesProducts = Get.arguments['pharmaciesProducts'];

    for (var cartItem in Get.arguments['cartProducts']) {
      CartItemModel cartItemModel = CartItemModel.fromJson(cartItem);
      cartProducts.add(cartItemModel.productModel!.id);
    }

    units = Get.arguments['units'];
    myId = myServices.sharedPreferences.getString('id')!;
    carts = FirebaseFirestore.instance.collection('carts');
    myCart = carts.doc(myId);
  }

  seeAllPharmacies() async {
    loading();
    var pharmaciesRes = await allPharamaciesRequest();
    if (pharmaciesRes is RequsetStatus == false) {
      ResponseModel pharmaciesResponseModel =
          ResponseModel.fromJson(pharmaciesRes);
      if (pharmaciesResponseModel.responseCode == '200') {
        pharmacies = pharmaciesResponseModel.data['data'];
      }
    }
    Get.offNamed(
      AppRoutes.pharmaciesScreen,
    );
  }

  allPharamaciesRequest() async {
    var res = await crud.connect(
      link: AppLinks.pharmaciesList,
    );
    return res.fold((l) => l, (r) => r);
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
    Get.toNamed(
      AppRoutes.productDetails,
      arguments: {
        'productModel': productModel,
        'cartProducts': cartProducts,
      },
    );
  }

  pharmacyDetails({required PharmacyModel selectedPharmacyModel}) {
    pharmacyModel = selectedPharmacyModel;
    Get.toNamed(AppRoutes.pharmacyDetails);
  }

  pharmacyProducts({required PharmacyModel pharmacyModel}) async {
    List selectedPharamacyProducts = [];
    for (var element in pharmaciesProducts) {
      ProductModel productModel = ProductModel.fromJson(element);
      if (productModel.userId == pharmacyModel.id) {
        selectedPharamacyProducts.add(element);
      }
    }
    searchCon.filteredProducts.clear();
    searchCon.filteredCategorie = '';
    searchCon.filteredSubCategorie = '';
    searchCon.pharmaciesProducts = selectedPharamacyProducts;
    pharmacySelected = true;
    searchCon.update();
    Get.toNamed(AppRoutes.pharmaciesProducts);
  }

  addToCart({required ProductModel productModel}) async {
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
    searchCon.update();
  }

  buyNow({required ProductModel productModel}) async {
    await addToCart(productModel: productModel);
    mainController.shoppingCart();
  }

  removeFromCart({required ProductModel productModel}) async {
    loading();
    await removeFromCartRequest(id: productModel.id!);
    cartProducts.remove(productModel.id);
    // for (var cartItem in mainController.cartProducts) {
    // if (cartItem['product_id'] == productModel.id) {
    //     mainController.cartProducts.remove(cartItem);
    //     break;
    //   }
    // }
    // await myCart.set({
    //   'products': mainController.cartProducts,
    // });
    Get.back();
    searchCon.update();
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
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  Future<bool> willPop() {
    if (!pharmacySelected) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: AppColors.lightGrey1,
          statusBarIconBrightness: Brightness.light,
        ),
      );
    }
    Get.back();
    return Future.value(false);
  }

  Future<bool> pharmacyClosed() {
    searchCon.filteredProducts.clear();
    searchCon.filteredCategorie = '';
    searchCon.filteredSubCategorie = '';
    searchCon.pharmaciesProducts = pharmaciesProducts;
    pharmacySelected = false;
    searchCon.update();
    Get.back();
    return Future.value(false);
  }
}
