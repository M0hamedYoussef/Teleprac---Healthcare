import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/model/pharmacies/product_model.dart';
import 'package:teleprac/routes.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/standalone.dart';

class MyProductsController extends GetxController {
  Crud crud = Crud();
  MyServices myServices = Get.find();
  //
  late List myProductsList;
  late List categories;
  late List allUnits;
  late Location indianTimeZone;
  late String currentDate;
  //
  TextEditingController productNameCon = TextEditingController();
  TextEditingController productPackSizeCon = TextEditingController();
  TextEditingController productManufacturedbyCon = TextEditingController();
  TextEditingController productShortDescriptionCon = TextEditingController();
  TextEditingController productDescriptionCon = TextEditingController();
  TextEditingController productPriceCon = TextEditingController();
  TextEditingController productSalePriceCon = TextEditingController();
  TextEditingController productDiscountCon = TextEditingController();
  TextEditingController productCompsitionCon = TextEditingController();
  TextEditingController productUnitValueCon = TextEditingController();
  FocusNode productNameFocus = FocusNode();
  FocusNode productPackSizeFocus = FocusNode();
  FocusNode productUnitValueFocus = FocusNode();
  FocusNode productPriceFocus = FocusNode();
  FocusNode productSalePriceFocus = FocusNode();
  FocusNode productDiscountFocus = FocusNode();
  FocusNode productDescriptionFocus = FocusNode();
  FocusNode productShortDescriptionFocus = FocusNode();
  FocusNode productManufacturedbyFocus = FocusNode();
  FocusNode productCompsitionFocus = FocusNode();
  File? productImage;
  String? selectedCategory;
  String? selectedSubCategory;
  String? selectedUnit;
  bool? status;
  List? subCategories;

  String? selectedProductType;
  String? featured;
  String? stock;
  String? expieryDate;

  ProductModel? selectedProductModel;

  List productTypes = [
    {
      'value': '0',
      'label': 'Without Prescription',
    },
    {
      'value': '1',
      'label': 'Prescription',
    },
  ];

  List featuredOptions = [
    {
      'value': '0',
      'label': 'No',
    },
    {
      'value': '1',
      'label': 'Yes',
    },
  ];

  List stockOptions = [
    {
      'value': '0',
      'label': 'Out Of Stock',
    },
    {
      'value': '1',
      'label': 'In Stock',
    },
  ];

  @override
  void onInit() {
    myProductsList = Get.arguments['myProductsList'];
    categories = Get.arguments['pharmaciesCategories'];
    allUnits = Get.arguments['allUnits'];
    initializeTimeZones();
    indianTimeZone = getLocation('Asia/Kolkata');
    currentDate = TZDateTime.now(indianTimeZone).toString().substring(0, 10);
    super.onInit();
  }

  selectDate({required BuildContext context}) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: expieryDate == null
          ? DateTime.parse(currentDate)
          : DateTime.parse(expieryDate!),
      firstDate: DateTime.parse(
          TZDateTime.now(indianTimeZone).toString().substring(0, 10)),
      lastDate: DateTime.parse(currentDate).add(const Duration(days: 7000)),
    );

    if (picked != null) {
      expieryDate = picked.toString().substring(0, 10);
      update();
    }
  }

  goToEditProductScreen({required ProductModel productModel}) {
    productImage = null;
    selectedProductModel = productModel;
    productNameCon.text = productModel.name!;
    productManufacturedbyCon.text = productModel.manufacturedBy!;
    productShortDescriptionCon.text = productModel.shortDescription!;
    productDescriptionCon.text = productModel.description!;
    productPriceCon.text = productModel.price!;
    productSalePriceCon.text = productModel.salePrice!;
    productDiscountCon.text = productModel.discount!;
    expieryDate = productModel.expiryDate!;
    productCompsitionCon.text = productModel.composition!;
    productUnitValueCon.text =
        productModel.unitValue == 'null' ? '' : productModel.unitValue ?? '';
    selectedCategory =
        productModel.category == 'null' ? '' : productModel.category ?? '';
    selectedSubCategory = productModel.subcategory == 'null'
        ? ''
        : productModel.subcategory ?? '';
    if (selectedCategory!.isNotEmpty) {
      for (var element in categories) {
        if (element['category_id'] == selectedCategory) {
          subCategories = null;
          subCategories = element['sub_cateogory'];
          break;
        }
      }
    }
    status = productModel.status == '0' ? false : true;
    selectedProductType = productModel.medicineType;
    selectedUnit = productModel.unit == 'null' ? '' : productModel.unit ?? '';
    featured =
        productModel.featured == 'null' ? '' : productModel.featured ?? '';
    stock = productModel.stockStatus == 'null'
        ? ''
        : productModel.stockStatus ?? '';

    Get.toNamed(AppRoutes.editProductScreen);
  }

  myProducts() async {
    var res = await myProductsRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        myProductsList = responseModel.myProductsList!;
      }
    }
  }

  addProduct() async {
    if (validateAll() && productImage != null) {
      loading();
      var res = await addProductRequest();
      if (res is RequsetStatus == false) {
        ResponseModel responseModel = ResponseModel.fromJson(res);
        if (responseModel.responseCode == '200') {
          await myProducts();
          Get.back();
          Get.back();
          update();
          clearAll();
        }
      }
    } else if (productImage == null) {
      Get.defaultDialog(middleText: 'Choose Product Image');
    }
  }

  editProduct() async {
    if (validateAll()) {
      loading();
      var res = await editProductsRequest();
      if (res is RequsetStatus == false) {
        ResponseModel responseModel = ResponseModel.fromJson(res);
        if (responseModel.responseCode == '200') {
          await myProducts();
          Get.back();
          Get.back();
          update();
          clearAll();
        }
      }
    }
  }

  myProductsRequest() async {
    var res = await crud.connect(
      link: AppLinks.myProducts,
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  addProductRequest() async {
    var res = await crud.connect(
      link: AppLinks.addProduct,
      file: productImage,
      fileRequestName: 'user_file',
      data: {
        'name': productNameCon.text.trim(),
        'pack_size': productPackSizeCon.text.trim(),
        'price': productPriceCon.text.trim(),
        'sale_price': productSalePriceCon.text.trim(),
        'discount': productDiscountCon.text.trim(),
        'composition': productCompsitionCon.text.trim(),
        'manufactured_by': productManufacturedbyCon.text.trim(),
        'short_description': productShortDescriptionCon.text.trim(),
        'description': productDescriptionCon.text.trim(),
        'status': status == true ? '1' : '0',
        'expiry_date': expieryDate,
        'unit': selectedUnit,
        'unit_value': productUnitValueCon.text.trim(),
        'category': selectedCategory,
        'subcategory': selectedSubCategory,
        'medicine_type': selectedProductType,
        'featured': featured,
        'stock': stock,
      },
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  editProductsRequest() async {
    var res = await crud.connect(
      link: AppLinks.editProduct,
      file: productImage,
      fileRequestName: 'user_file',
      data: {
        'id': selectedProductModel!.id,
        'name': productNameCon.text.trim(),
        'pack_size': productPackSizeCon.text.trim(),
        'price': productPriceCon.text.trim(),
        'sale_price': productSalePriceCon.text.trim(),
        'discount': productDiscountCon.text.trim(),
        'composition': productCompsitionCon.text.trim(),
        'expiry_date': expieryDate,
        'manufactured_by': productManufacturedbyCon.text.trim(),
        'short_description': productShortDescriptionCon.text.trim(),
        'description': productDescriptionCon.text.trim(),
        'status': status == true ? '1' : '0',
        'unit': selectedUnit,
        'unit_value': productUnitValueCon.text.trim(),
        'category': selectedCategory,
        'subcategory': selectedSubCategory,
        'medicine_type': selectedProductType,
        'featured': featured,
        'stock': stock,
      },
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  selectImage() async {
    XFile? pickedPhoto =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedPhoto != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedPhoto.path,
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
        XFile? compressedPfp = await FlutterImageCompress.compressAndGetFile(
          croppedFile.path,
          '${temp.path}/compressed.${croppedFile.path.split('.').last}',
          quality: 80,
        );
        if (compressedPfp != null) {
          productImage = File(compressedPfp.path);
        } else {
          productImage = File(croppedFile.path);
        }
      }
    }
  }

  clearAll() {
    productNameCon.clear();
    productPackSizeCon.clear();
    productPriceCon.clear();
    productSalePriceCon.clear();
    productDiscountCon.clear();
    productCompsitionCon.clear();
    productManufacturedbyCon.clear();
    productShortDescriptionCon.clear();
    productDescriptionCon.clear();
    productUnitValueCon.clear();
    expieryDate = null;
    status = null;
    selectedUnit = null;
    selectedCategory = null;
    selectedSubCategory = null;
    selectedProductType = null;
    featured = null;
    stock = null;
    selectedProductModel = null;
  }

  bool validateAll() {
    if (productNameCon.text.isEmpty ||
        productPackSizeCon.text.isEmpty ||
        productPriceCon.text.isEmpty ||
        productSalePriceCon.text.isEmpty ||
        productDiscountCon.text.isEmpty ||
        productCompsitionCon.text.isEmpty ||
        productManufacturedbyCon.text.isEmpty ||
        productShortDescriptionCon.text.isEmpty ||
        productDescriptionCon.text.isEmpty ||
        productUnitValueCon.text.isEmpty ||
        status == null ||
        selectedUnit == null ||
        selectedCategory == null ||
        selectedSubCategory == null ||
        selectedProductType == null ||
        featured == null ||
        stock == null ||
        expieryDate == null) {
      Get.defaultDialog(middleText: 'Please Fill All Fields');
      return false;
    } else {
      return true;
    }
  }
}
