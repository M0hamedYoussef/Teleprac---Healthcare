import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:teleprac/controller/main_controller.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/model/home/cart_item_model.dart';
import 'package:teleprac/model/home/dashboard/custom_product_model.dart';
import 'package:teleprac/model/home/dashboard/recommended_test_model.dart';
import 'package:teleprac/model/pharmacies/product_model.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/standalone.dart';

class BillingController extends GetxController {
  // late CollectionReference carts;
  // late DocumentReference myCart;
  // late List allProducts;
  // late double totalPrice;
  late String myId;
  late List? cartProducts;
  late RecommendedTestModel? recommendedTestModel;
  late List? pharmaciesInTheCart;
  late List states;
  late bool payForMedicine;
  late bool payForLabTests;
  late String appointmentDate;
  late Location indianTimeZone;
  List cities = [];
  Crud crud = Crud();
  MyServices myServices = Get.find();
  MainController mainController = Get.find();
  // MyCartController myCartController = Get.find();
  //
  TextEditingController fullNameCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController firstAddressCon = TextEditingController();
  TextEditingController secondAddressCon = TextEditingController();
  TextEditingController postalCodeCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();
  //
  FocusNode fullNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode firstAddressFocus = FocusNode();
  FocusNode secondAddressFocus = FocusNode();
  FocusNode postalCodeFocus = FocusNode();
  //
  String city = '';
  String state = '';
  File? prescriptionImage;
  String? fullNameValidationText;
  String? emailValidationText;
  String? firstAddressValidationText;
  String? secondAddressValidationText;
  String? postalCodeValidationText;
  String? phoneValidationText;

  @override
  void onInit() {
    super.onInit();
    myId = myServices.sharedPreferences.getString('id')!;
    states = Get.arguments['states'];
    cartProducts = Get.arguments['cartProducts'];
    pharmaciesInTheCart = Get.arguments['pharmaciesInTheCart'];
    recommendedTestModel = Get.arguments['recommendedTestModel'];

    payForMedicine = Get.arguments['isPayForMedicine'] ?? false;
    payForLabTests = Get.arguments['isPayForLabTests'] ?? false;
    initializeTimeZones();
    indianTimeZone = getLocation('Asia/Kolkata');
    appointmentDate =
        TZDateTime.now(indianTimeZone).toString().substring(0, 10);
  }

  placeOrder() async {
    // for (int i = 0; i < pharmaciesInTheCart.length; i++) {
    List thisPharmacyProducts = [];
    bool isPresctptionRequiered = false;
    double amount = 0;
    if (!payForMedicine) {
      for (var product in cartProducts!) {
        CartItemModel cartItemModel = CartItemModel.fromJson(product);
        ProductModel productModel = cartItemModel.productModel!;
        if (productModel.userId == pharmaciesInTheCart![0]) {
          // for (var cartItem in mainController.cartProducts) {
          //   if (cartItem['product_id'] == productModel.id) {
          //     qty = cartItem['qty'];
          //     break;
          //   }
          // }
          if (productModel.medicineType == '1') {
            isPresctptionRequiered = true;
          }
          if (productModel.discount.toString().removeAllWhitespace != '0' &&
              productModel.discount != null &&
              productModel.discount!.isNotEmpty &&
              productModel.price != productModel.salePrice) {
            amount = amount +
                double.parse(productModel.salePrice!) *
                    int.parse(cartItemModel.qty!);
          } else {
            amount = amount +
                double.parse(productModel.price!) *
                    int.parse(cartItemModel.qty!);
          }
          thisPharmacyProducts.add({
            'user_id': myId,
            'product_id': productModel.id,
            'qty': cartItemModel.qty!,
            'product_name': productModel.name,
            'price': productModel.price,
            'sub_total':
                productModel.discount.toString().removeAllWhitespace != '0' &&
                        productModel.discount != null &&
                        productModel.discount!.isNotEmpty &&
                        productModel.price != productModel.salePrice
                    ? productModel.salePrice
                    : productModel.price,
          });
        }
      }
    } else {
      for (var product in cartProducts!) {
        CustomProductModel customProductModel =
            CustomProductModel.fromJson(product);
        if (customProductModel.pharmacyId == pharmaciesInTheCart![0]) {
          String? qty;
          for (var cartItem in mainController.cartProducts) {
            if (cartItem['product_id'] == customProductModel.id) {
              qty = cartItem['qty'];
              break;
            }
          }

          amount = amount + double.parse(customProductModel.price!);

          thisPharmacyProducts.add({
            'user_id': myId,
            'product_id': customProductModel.id,
            'qty': qty ?? '1',
            'product_name': customProductModel.name,
            'price': customProductModel.price,
            'sub_total': customProductModel.price,
          });
        }
      }
    }

    await placeOrderRequest(
      pharmacyId: pharmaciesInTheCart![0],
      products: thisPharmacyProducts,
      isPresctptionRequiered: isPresctptionRequiered,
      amount: amount.toString(),
    );

    // }
  }

  placeOrderRequest({
    required String pharmacyId,
    required String amount,
    required List products,
    required bool isPresctptionRequiered,
  }) async {
    Razorpay razorpay = Razorpay();
    razorpay.on(
      Razorpay.EVENT_PAYMENT_SUCCESS,
      (PaymentSuccessResponse response) async {
        loading();
        var res = await placeOrderConfirmRequest(
          pharmacyId: pharmacyId,
          products: products,
          amount: amount,
        );

        if (res is RequsetStatus == false) {
          ResponseModel responseModel = ResponseModel.fromJson(res);
          if (responseModel.responseCode == '200') {
            // for (var element in products) {
            // for (var cartItem in mainController.cartProducts) {
            // if (cartItem['product_id'] == element['product_id']) {
            // mainController.cartProducts.remove(cartItem);
            // break;
            // }
            // }
            // for (ProductModel cartProductModel
            //     in myCartController.cartProducts) {
            //   if (cartProductModel.id == element['product_id']) {
            //     myCartController.cartProducts.remove(cartProductModel);
            //     break;
            //   }
            // }
            // }
            // await myCartController.myCart.set({
            // 'products': mainController.cartProducts,
            // });
            // myCartController.update();
            Get.back();
            Get.back();
            if (payForMedicine) {
              Get.back();
            }
            Fluttertoast.showToast(
              msg: 'Success',
              textColor: AppColors.black,
              backgroundColor: AppColors.secondaryColor,
            );
          } else {
            Get.back();
            Fluttertoast.showToast(
              msg: 'Something went wrong',
              textColor: AppColors.black,
              backgroundColor: AppColors.secondaryColor,
            );
          }
        }
      },
    );
    if (isPresctptionRequiered) {
      XFile? uploadedImage;
      await Get.defaultDialog(
        middleText: 'Prescription Image Required',
        actions: [
          MaterialButton(
            onPressed: () async {
              uploadedImage =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              int random = Random().nextInt(99999999);
              if (uploadedImage != null) {
                CroppedFile? croppedFile = await ImageCropper().cropImage(
                  sourcePath: uploadedImage!.path,
                  aspectRatioPresets: [
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio16x9
                  ],
                  uiSettings: [
                    AndroidUiSettings(
                      toolbarTitle: 'Edit Image',
                      toolbarColor: AppColors.primaryColor,
                      toolbarWidgetColor: AppColors.secondaryColor,
                      initAspectRatio: CropAspectRatioPreset.original,
                      lockAspectRatio: false,
                      activeControlsWidgetColor: AppColors.primaryColor,
                    ),
                    IOSUiSettings(title: 'Edit Image'),
                  ],
                );
                if (croppedFile != null) {
                  Directory temp = await getTemporaryDirectory();
                  XFile? compressedPrescription =
                      await FlutterImageCompress.compressAndGetFile(
                    croppedFile.path,
                    '${temp.path}/compressed$random.${croppedFile.path.split('.').last}',
                    quality: 80,
                  );
                  if (compressedPrescription != null) {
                    uploadedImage = XFile(compressedPrescription.path);
                  } else {
                    uploadedImage = XFile(croppedFile.path);
                  }
                }
                Get.back();
              }
            },
            color: AppColors.primaryColor,
            child: SizedBox(
              width: AppDecoration().screenWidth * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.upload,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  Text(
                    'Upload',
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: AppDecoration().screenWidth * 0.035,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppDecoration.cairo,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

      if (uploadedImage != null) {
        prescriptionImage = File(uploadedImage!.path);
        razorpay.open({
          'name': 'Pharmacy Products',
          'amount': '${double.parse(amount).round().toInt()}00',
          'key': AppLinks.razorPay,
        });
      } else {
        Get.defaultDialog(
          middleText: 'Prescription Image Required',
        );
      }
    } else {
      razorpay.open({
        'name': 'Pharmacy Products',
        'amount': '${double.parse(amount).round().toInt()}00',
        'key': AppLinks.razorPay,
      });
    }
  }

  placeOrderConfirmRequest({
    required String pharmacyId,
    required List products,
    required String amount,
  }) async {
    var res = await crud.connect(
      file: prescriptionImage,
      fileRequestName: 'prescription_image',
      link: AppLinks.placeOrder,
      data: {
        'access_token': AppLinks.razorPay,
        'user_id': myId,
        'amount': amount,
        'address1': firstAddressCon.text.trim(),
        'address2': secondAddressCon.text.trim(),
        'emailid': emailCon.text.trim(),
        'full_name': fullNameCon.text.trim(),
        'phoneno': phoneCon.text.trim(),
        'zipcode': postalCodeCon.text.trim(),
        'city': city,
        'state': state,
        'pharmacy_id': pharmacyId,
        'cartItems': jsonEncode(products),
        'payment_method': '3',
        'country': '101',
      },
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  selectDate({required BuildContext context}) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(appointmentDate),
      firstDate: DateTime.parse(
          TZDateTime.now(indianTimeZone).toString().substring(0, 10)),
      lastDate: DateTime.parse(appointmentDate).add(const Duration(days: 365)),
    );

    if (picked != null) {
      appointmentDate = picked.toString().substring(0, 10);
    }
  }

  bookTests({required BuildContext context}) async {
    double amount = 0;
    Razorpay razorpay = Razorpay();
    for (LabtestDetails labTestDetailsModel
        in recommendedTestModel!.labtestDetails!) {
      amount = amount + double.parse(labTestDetailsModel.finalPrice!);
    }
    await selectDate(context: context);
    razorpay.on(
      Razorpay.EVENT_PAYMENT_SUCCESS,
      (PaymentSuccessResponse response) async {
        for (LabtestDetails labTestDetailsModel
            in recommendedTestModel!.labtestDetails!) {
          await bookTestRequest(
            labtestDetailsModel: labTestDetailsModel,
            labId: recommendedTestModel!.labId!,
            appointmentDate: appointmentDate,
          );
        }
      },
    );
    razorpay.open({
      'name': 'Recommended Tests Checkout',
      'amount': '${amount.round()}00',
      'key': AppLinks.razorPay,
    });
  }

  bookTestRequest({
    required LabtestDetails labtestDetailsModel,
    required String labId,
    required String appointmentDate,
  }) async {
    int random = Random().nextInt(99999999);
    var res = await crud.connect(
      link: AppLinks.bookTest,
      data: {
        'lab_id': labId,
        'booking_ids': labtestDetailsModel.testId,
        'appoinment_date': appointmentDate,
        'amount': labtestDetailsModel.finalPrice,
        'del_type': '0',
        'payment_method': '1',
        "currency_code": "INR",
        "txn_id": "",
        "order_id": "",
        "transaction_status": "",
        "payment_type": "RZP",
        "payment_status": '1',
        "status": "New",
        "invoice_no": '$random',
      },
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  stateSelected({required String id}) async {
    state = id;
    loading();
    var res = await citiesRequest(id: id);
    Get.back();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode.toString().trim() == '200') {
        cities = responseModel.requestedList!;
        update();
      }
    }
  }

  citiesRequest({required String id}) async {
    var res = await crud.connect(
      link: AppLinks.locationsApi,
      data: {
        'type': '3',
        'id': id,
      },
      headers: {
        'token': AppLinks.token,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  validate() {
    bool valid = false;
    bool fullnameValidate = false;
    bool firstAddressValidate = false;
    bool secondAddressValidate = false;
    bool emailValidate = false;
    bool phoneValidate = false;
    bool postalCodeValidate = false;

    if (fullNameCon.text.isEmpty) {
      fullNameValidationText = 'Can\'t be empty';
      fullnameValidate = false;
    } else {
      fullNameValidationText = null;
      fullnameValidate = true;
    }
    if (firstAddressCon.text.isEmpty) {
      firstAddressValidationText = 'Can\'t be empty';
      firstAddressValidate = false;
    } else {
      firstAddressValidationText = null;
      firstAddressValidate = true;
    }
    if (secondAddressCon.text.isEmpty) {
      secondAddressValidationText = 'Can\'t be empty';
      secondAddressValidate = false;
    } else {
      secondAddressValidationText = null;
      secondAddressValidate = true;
    }
    if (!GetUtils.isEmail(emailCon.text.trim()) || emailCon.text.isEmpty) {
      emailValidationText = 'Email is invalid';
      emailValidate = false;
    } else {
      emailValidationText = null;
      emailValidate = true;
    }
    if (!GetUtils.isPhoneNumber(phoneCon.text.trim()) ||
        phoneCon.text.isEmpty) {
      phoneValidationText = 'Phonenumber is invalid';
      phoneValidate = false;
    } else {
      phoneValidationText = null;
      phoneValidate = true;
    }
    if (!GetUtils.isNumericOnly(postalCodeCon.text.trim()) ||
        postalCodeCon.text.isEmpty) {
      postalCodeValidationText = 'Postal Code is invalid';
      postalCodeValidate = false;
    } else {
      postalCodeValidationText = null;
      postalCodeValidate = true;
    }

    if (fullnameValidate &&
        firstAddressValidate &&
        secondAddressValidate &&
        emailValidate &&
        phoneValidate &&
        postalCodeValidate &&
        state.isNotEmpty &&
        city.isNotEmpty) {
      valid = true;
    } else if (state.isEmpty || city.isEmpty) {
      Get.defaultDialog(middleText: 'Please fill all fields');
    }
    update();
    return valid;
  }
}
