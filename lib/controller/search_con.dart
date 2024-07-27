import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/model/doctors/doctors_model.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/model/labs/lab_model.dart';
import 'package:teleprac/model/labs/tests/test_model.dart';
import 'package:teleprac/model/pharmacies/category_model.dart';
import 'package:teleprac/model/pharmacies/pharmacy_model.dart';
import 'package:teleprac/model/pharmacies/product_model.dart';
import 'package:teleprac/model/specializations/specializations_model.dart';
import 'package:teleprac/routes.dart';

class SearchCon extends GetxController {
  double filteringHeight = 0;
  Crud crud = Crud();
  // Doctors Search
  late List allSpecializationsList;
  List allGendersList = ['Male', 'Female'];
  late TextEditingController doctorsSearchCon;
  FocusNode doctorsSearchFocus = FocusNode();
  List<String> specialityFilters = [];
  String genderFilter = '';
  // Labs Search
  TextEditingController labsSearchCon = TextEditingController();
  TextEditingController testsSearchCon = TextEditingController();
  String testCategorieFilter = '';
  List testsCategories = [
    {
      'value': '0',
      'label': 'Imaging Tests',
    },
    {
      'value': '1',
      'label': 'Lab Tests',
    },
  ];
  // Pharmacies
  late List pharmaciesCategories;
  late List pharmaciesProducts;
  TextEditingController pharmacyProductsSearchCon = TextEditingController();
  FocusNode pharmacyProductsSearchFocus = FocusNode();
  TextEditingController pharmacySearchCon = TextEditingController();
  // List filteredCategories = [];
  // List filteredSubCategories = [];
  String filteredCategorie = '';
  List<SubCateogory> filteredCatSubcategories = [];
  String filteredSubCategorie = '';
  List filteredProducts = [];
  List availableCatImages = [
    '1',
    '12',
    '27',
    '28',
    '63',
  ];
  List availableSubcatImages = [
    '8',
    '9',
    '13',
    '14',
    '15',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '25',
    '26',
    '32',
    '33',
    '34',
    '36',
    '41',
    '42',
    '43',
    '44',
    '45',
    '56',
    '57',
    '58',
    '59',
    '60',
    '61',
    '62',
    '65',
    '66',
  ];

  @override
  void onInit() {
    if (Get.currentRoute == AppRoutes.allDoctors) {
      allSpecializationsList = Get.arguments['specializationsList'];
      if (Get.arguments['searchCon'] != null) {
        doctorsSearchCon = Get.arguments['searchCon'];
      } else {
        doctorsSearchCon = TextEditingController();
      }
      if (Get.arguments['appliedFilter'] != null) {
        specialityFilters.add(Get.arguments['appliedFilter']);
      }
    } else if (Get.currentRoute == AppRoutes.pharmaciesProducts) {
      pharmaciesCategories = Get.arguments['pharmaciesCategories'];
      pharmaciesProducts = Get.arguments['pharmaciesProducts'];
    }

    pharmacyProductsSearchFocus.addListener(() {
      if (pharmacyProductsSearchFocus.hasFocus) {
        closeFiltersContainer();
      }
    });
    doctorsSearchFocus.addListener(() {
      if (doctorsSearchFocus.hasFocus) {
        closeFiltersContainer();
      }
    });

    super.onInit();
  }

  // Doctors

  closeFiltersContainer() {
    if (filteringHeight != 0) {
      filteringHeight = 0;
      update();
    }
  }

  checkFilter({
    required RxBool checked,
    required SpecializationModel specializationModel,
  }) {
    checked.value = !checked.value;
    if (checked.value == true) {
      specialityFilters.add(specializationModel.specialization!);
    } else {
      if (specialityFilters.contains(specializationModel.specialization!)) {
        specialityFilters.remove(specializationModel.specialization!);
      }
    }
    closeFiltersContainer();
  }

  doctorFilterValidate({required DoctorModel doctorModel}) {
    bool isFiltered = false;
    bool isSpecialityFiltered = false;
    bool isGenderFiltered = false;
    if (specialityFilters.isNotEmpty) {
      for (int i = 0; i < specialityFilters.length; i++) {
        if (doctorModel.speciality!.toLowerCase().removeAllWhitespace ==
            specialityFilters[i].toLowerCase().removeAllWhitespace) {
          isSpecialityFiltered = true;
          break;
        }
      }
    } else {
      isSpecialityFiltered = true;
    }
    if (genderFilter.isNotEmpty) {
      isGenderFiltered = genderFilter.toLowerCase().removeAllWhitespace ==
          doctorModel.gender!.toLowerCase().removeAllWhitespace;
    } else {
      isGenderFiltered = true;
    }
    isFiltered = isGenderFiltered && isSpecialityFiltered;
    return isFiltered;
  }

  categorieFilterValidate({required ProductModel productModel}) {
    bool isFiltered = filteredCategorie == productModel.category;
    // for (int i = 0; i < filteredCategories.length; i++) {
    //   if (productModel.category! == filteredCategories[i]) {
    //     isFiltered = true;
    //     break;
    //   }
    // }
    // for (int i = 0; i < filteredSubCategories.length; i++) {
    //   if (productModel.subcategory! == filteredSubCategories[i]) {
    //     isFiltered = false;
    //   } else {
    //     isFiltered = true;
    //     break;
    //   }
    // }
    return isFiltered;
  }

  checkCategorieFilter({
    required bool checked,
    required CategoryModel categoryModel,
  }) async {
    checked = !checked;
    if (checked) {
      loading();
      filteredCategorie = categoryModel.categoryId!;
      filteredSubCategorie = '';
      var res = await checkCategorieRequest();
      if (res is RequsetStatus == false) {
        ResponseModel responseModel = ResponseModel.fromJson(res);
        filteredProducts = responseModel.productsList!;
        filteredCatSubcategories = categoryModel.subCateogory!;
      }
      Get.back();
    } else {
      filteredCategorie = '';
      filteredSubCategorie = '';
      filteredProducts = [];
      filteredCatSubcategories = [];
    }

    update();
  }

  checkCategorieRequest() async {
    var res = await crud.connect(
      link: AppLinks.pharmacyProducts,
      data: {
        'cat_id': filteredCategorie,
      },
      headers: {
        'token': AppLinks.token,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  checkSubCategorieFilter({
    required bool checked,
    SubCateogory? subCateogory,
  }) async {
    checked = !checked;
    loading();
    if (checked) {
      filteredSubCategorie = subCateogory!.subCategoryId!;
      var res = await checkSubCategorieRequest();
      if (res is RequsetStatus == false) {
        ResponseModel responseModel = ResponseModel.fromJson(res);
        filteredProducts = responseModel.productsList!;
      }
    } else {
      filteredSubCategorie = '';
      var res = await checkCategorieRequest();
      if (res is RequsetStatus == false) {
        ResponseModel responseModel = ResponseModel.fromJson(res);
        filteredProducts = responseModel.productsList!;
      }
    }
    Get.back();
    update();
  }

  checkSubCategorieRequest() async {
    var res = await crud.connect(
      link: AppLinks.pharmacyProducts,
      data: {
        'cat_id': filteredCategorie,
        'sub_cat_id': filteredSubCategorie,
      },
      headers: {
        'token': AppLinks.token,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  filterOpen() async {
    filteringHeight = 0.5;
    update();
  }

  bool doctorSearchValidate({required DoctorModel doctorModel}) {
    return (doctorModel.fullName
                .toString()
                .toLowerCase()
                .replaceAll('_', '')
                .replaceAll('-', '')
                .replaceAll('|', '')
                .replaceAll('(', '')
                .replaceAll(')', '')
                .replaceAll('@', '')
                .replaceAll(' x ', '')
                .removeAllWhitespace
                .contains(
                  doctorsSearchCon.text
                      .toLowerCase()
                      .replaceAll('_', '')
                      .replaceAll('-', '')
                      .replaceAll('|', '')
                      .replaceAll('(', '')
                      .replaceAll(')', '')
                      .replaceAll('@', '')
                      .replaceAll(' x ', '')
                      .removeAllWhitespace,
                ) ||
            doctorModel.speciality
                .toString()
                .toLowerCase()
                .replaceAll('_', '')
                .replaceAll('-', '')
                .replaceAll('|', '')
                .replaceAll('(', '')
                .replaceAll(')', '')
                .replaceAll('@', '')
                .replaceAll(' x ', '')
                .removeAllWhitespace
                .contains(
                  doctorsSearchCon.text
                      .toLowerCase()
                      .replaceAll('_', '')
                      .replaceAll('-', '')
                      .replaceAll('|', '')
                      .replaceAll('(', '')
                      .replaceAll(')', '')
                      .replaceAll('@', '')
                      .replaceAll(' x ', '')
                      .removeAllWhitespace,
                )) &&
        doctorFilterValidate(doctorModel: doctorModel);
  }

  // Labs
  bool labsSearchValidate({required LabModel labModel}) {
    return (labModel.fullName
        .toString()
        .toLowerCase()
        .replaceAll('_', '')
        .replaceAll('-', '')
        .replaceAll('|', '')
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll('@', '')
        .replaceAll(' x ', '')
        .removeAllWhitespace
        .contains(
          labsSearchCon.text
              .toLowerCase()
              .replaceAll('_', '')
              .replaceAll('-', '')
              .replaceAll('|', '')
              .replaceAll('(', '')
              .replaceAll(')', '')
              .replaceAll('@', '')
              .replaceAll(' x ', '')
              .removeAllWhitespace,
        ));
  }

  // Tests
  bool testsSearchValidate({required TestModel testModel}) {
    if (testsSearchCon.text.isEmpty ||
        (testModel.labTestName
            .toString()
            .toLowerCase()
            .replaceAll('_', '')
            .replaceAll('-', '')
            .replaceAll('|', '')
            .replaceAll('(', '')
            .replaceAll(')', '')
            .replaceAll('@', '')
            .replaceAll(' x ', '')
            .removeAllWhitespace
            .contains(
              testsSearchCon.text
                  .toLowerCase()
                  .replaceAll('_', '')
                  .replaceAll('-', '')
                  .replaceAll('|', '')
                  .replaceAll('(', '')
                  .replaceAll(')', '')
                  .replaceAll('@', '')
                  .replaceAll(' x ', '')
                  .removeAllWhitespace,
            ))) {
      return true;
    } else {
      return false;
    }
  }

  // Pharmacies
  bool pharmaciesSearchValidate({required PharmacyModel pharmacyModel}) {
    return (pharmacyModel.pharmacyName
        .toString()
        .toLowerCase()
        .replaceAll('_', '')
        .replaceAll('-', '')
        .replaceAll('|', '')
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll('@', '')
        .replaceAll(' x ', '')
        .removeAllWhitespace
        .contains(
          pharmacySearchCon.text
              .toLowerCase()
              .replaceAll('_', '')
              .replaceAll('-', '')
              .replaceAll('|', '')
              .replaceAll('(', '')
              .replaceAll(')', '')
              .replaceAll('@', '')
              .replaceAll(' x ', '')
              .removeAllWhitespace,
        ));
  }

  bool productSearchValidate({required ProductModel productModel}) {
    return (productModel.name
        .toString()
        .toLowerCase()
        .replaceAll('_', '')
        .replaceAll('-', '')
        .replaceAll('|', '')
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll('@', '')
        .replaceAll(' x ', '')
        .removeAllWhitespace
        .contains(
          pharmacyProductsSearchCon.text
              .toLowerCase()
              .replaceAll('_', '')
              .replaceAll('-', '')
              .replaceAll('|', '')
              .replaceAll('(', '')
              .replaceAll(')', '')
              .replaceAll('@', '')
              .replaceAll(' x ', '')
              .removeAllWhitespace,
        ));
  }

  // pharmacyProductsSearchCompleted({bool searchRes = true}) {
  //   filteredProducts = [];
  //   if (filteredCategories.isEmpty) {
  //     for (var element in pharmaciesProducts) {
  //       ProductModel productModel = ProductModel.fromJson(element);
  //       if (productModel.name!.toLowerCase().removeAllWhitespace.contains(
  //           pharmacyProductsSearchCon.text.toLowerCase().removeAllWhitespace)) {
  //         filteredProducts.add(element);
  //       }
  //     }
  //   } else {
  //     for (var element in pharmaciesProducts) {
  //       ProductModel productModel = ProductModel.fromJson(element);
  //       if (filteredSubCategories.isEmpty) {
  //         if (filteredCategories.contains(productModel.category) &&
  //             productModel.name!.toLowerCase().removeAllWhitespace.contains(
  //                 pharmacyProductsSearchCon.text
  //                     .toLowerCase()
  //                     .removeAllWhitespace)) {
  //           filteredProducts.add(element);
  //         }
  //       } else {
  //         if ((filteredCategories.contains(productModel.category) &&
  //                 filteredSubCategories.contains(productModel.subcategory)) &&
  //             productModel.name!.toLowerCase().removeAllWhitespace.contains(
  //                 pharmacyProductsSearchCon.text
  //                     .toLowerCase()
  //                     .removeAllWhitespace)) {
  //           filteredProducts.add(element);
  //         }
  //       }
  //     }
  //   }
  //   update();
  //   if (filteredProducts.isEmpty && searchRes) {
  //     Get.defaultDialog(middleText: 'Not Found');
  //   }
  // }

  Future<bool> willPop() {
    if (Get.previousRoute != AppRoutes.specializations &&
        Get.previousRoute != AppRoutes.doctorScreen) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: AppColors.lightGrey1,
          statusBarIconBrightness: Brightness.light,
        ),
      );
    }
    doctorsSearchCon.clear();
    Get.back();
    return Future.value(false);
  }
}
