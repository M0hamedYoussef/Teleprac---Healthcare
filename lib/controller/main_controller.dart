import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:fl_geocoder/fl_geocoder.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/model/doctors/advanced_doctor_model.dart';
import 'package:teleprac/model/doctors/doctors_model.dart';
import 'package:teleprac/model/doctors/session_model.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/model/home/cart_item_model.dart';
import 'package:teleprac/model/home/offers_model.dart';
import 'package:teleprac/model/labs/tests/advanced_test_model.dart';
import 'package:teleprac/model/pharmacies/product_model.dart';
import 'package:teleprac/model/specializations/specializations_model.dart';
import 'package:teleprac/routes.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;

class MainController extends GetxController {
  late String firstName;
  late String lastName;
  late String fullName;
  late tz.Location indianTimeZone;
  late String currentLocation;
  ProductModel? savedProductModel;
  AdvancedTestModel? savedTestModel;
  String? lastViewingType;
  String? myRole;
  String? myId;
  MyServices myServices = Get.find();
  TextEditingController searchCon = TextEditingController();
  FocusNode searchFocus = FocusNode();
  List topDoctors = [];
  List commonSpecializationsList = [];
  List labsList = [];
  List clinicsList = [];
  List offersList = [];
  List blogsList = [];
  Crud crud = Crud();

  List allDoctors = [];
  List allSpecializationsList = [];
  List sessions = [];

  // List allLabs = [];
  List allLabTests = [];

  // List allPharmacies = [];
  List allPharmaciesProducts = [];
  List allPharmaciesCategories = [];
  List allUnits = [];

  List cartProducts = [];

  @override
  onInit() async {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.lightGrey1,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    firstName = myServices.sharedPreferences.getString('first_name') ?? '';
    lastName = myServices.sharedPreferences.getString('last_name') ?? '';
    myRole = myServices.sharedPreferences.getString('role');
    fullName = '$firstName $lastName';
    currentLocation =
        myServices.sharedPreferences.getString('currentLocation') ??
            'Unavailable';
    getAllData();
    setLast();
    tz.initializeTimeZones();
    indianTimeZone = tz.getLocation('Asia/Kolkata');
    bookLabTestDate =
        tz.TZDateTime.now(indianTimeZone).toString().substring(0, 10);
    super.onInit();
  }

  setLast() {
    lastViewingType = myServices.sharedPreferences.getString('lastViewingType');
    if (lastViewingType == 'product') {
      savedProductModel = ProductModel.fromJson({
        'id': myServices.sharedPreferences.getString('lastProductID'),
        'lastProductImage':
            myServices.sharedPreferences.getString('lastProductImage'),
        'discount':
            myServices.sharedPreferences.getString('lastProductDiscount'),
        'name': myServices.sharedPreferences.getString('lastProductName'),
        'price': myServices.sharedPreferences.getString('lastProductPrice'),
        'sale_price':
            myServices.sharedPreferences.getString('lastProductSalePrice'),
        'medicine_type':
            myServices.sharedPreferences.getString('lastProductMedicineType'),
        'manufactured_by':
            myServices.sharedPreferences.getString('lastProductManufacturedBy'),
        'composition':
            myServices.sharedPreferences.getString('lastProductComposition'),
        'short_description': myServices.sharedPreferences
            .getString('lastProductShortDescription'),
      });
      update();
    } else if (lastViewingType == 'test') {
      savedTestModel = AdvancedTestModel.fromJson({
        'test_details': {
          'test_id': myServices.sharedPreferences.getString('testID'),
          'lab_test_name': myServices.sharedPreferences.getString('testName'),
          'lab_id': myServices.sharedPreferences.getString('labID'),
          'amount': myServices.sharedPreferences.getString('testPrice'),
          'mrp': myServices.sharedPreferences.getString('testMRP'),
          'discount': myServices.sharedPreferences.getString('testDiscount'),
          'description':
              myServices.sharedPreferences.getString('testDescription'),
        },
        'lab_details': {
          'fullname': myServices.sharedPreferences.getString('testLabName'),
          'profileimage': myServices.sharedPreferences
              .getString('labPFP')!
              .replaceAll('${AppLinks.baseUrl}/', ''),
        },
      });
      update();
    }
  }

  shoppingCart() async {
    loading();
    // if (allPharmaciesProducts.isEmpty) {
    //   var pharmaciesProductsRes = await allPharamaciesProductsRequest();
    //   if (pharmaciesProductsRes is RequsetStatus == false) {
    //     ResponseModel pharmaciesProductsResponseModel =
    //         ResponseModel.fromJson(pharmaciesProductsRes);
    //     if (pharmaciesProductsResponseModel.responseCode == '200') {
    //       allPharmaciesProducts = pharmaciesProductsResponseModel.productsList!;
    //     }
    //   }
    // }
    await getCartProducts();
    Get.offNamed(
      AppRoutes.cart,
      arguments: {
        'cartProducts': cartProducts,
      },
    );
  }

  notifications() async {
    loading();
    List notificationsList = [];
    var notificationsRes = await notificationsRequest();
    if (notificationsRes is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(notificationsRes);
      if (responseModel.responseCode == '200') {
        notificationsList = responseModel.data!;
      }
    }
    Get.offNamed(
      AppRoutes.notifications,
      arguments: {
        'notifications': notificationsList,
      },
    );
  }

  getCartProducts() async {
    cartProducts = [];
    var profuctsRes = await getCartProductsRequest();
    if (profuctsRes is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(profuctsRes);
      if (responseModel.responseCode == '200') {
        cartProducts = responseModel.data is List ? responseModel.data! : [];
      }
      // CollectionReference carts =
      //     FirebaseFirestore.instance.collection('carts');
      // DocumentReference myCart =
      //     carts.doc(myServices.sharedPreferences.getString('id'));
      // DocumentSnapshot productsDoc = await myCart.get();
      // if (productsDoc.data() != null) {
      //   cartProducts = productsDoc.get('products');
      // }
    }
  }

  searchEditingCompleted() async {
    searchFocus.unfocus();
    if (allDoctors.isEmpty || allSpecializationsList.isEmpty) {
      loading();
      if (allDoctors.isEmpty) {
        await getAllDoctors();
      }
      if (allSpecializationsList.isEmpty) {
        await getAllSpecializations();
      }
      Get.offNamed(
        AppRoutes.allDoctors,
        arguments: {
          'specializationsList': allSpecializationsList,
          'searchCon': searchCon,
        },
      );
    } else if (allDoctors.isNotEmpty && allSpecializationsList.isNotEmpty) {
      Get.toNamed(
        AppRoutes.allDoctors,
        arguments: {
          'specializationsList': allSpecializationsList,
          'searchCon': searchCon,
        },
      );
    }
  }

  seeAllSpecializations() async {
    if (allDoctors.isEmpty || allSpecializationsList.isEmpty) {
      loading();
      if (allDoctors.isEmpty) {
        await getAllDoctors();
      }
      if (allSpecializationsList.isEmpty) {
        await getAllSpecializations();
      }
      Get.offNamed(
        AppRoutes.specializations,
        arguments: {
          'specializationsList': allSpecializationsList,
        },
      );
    } else {
      Get.toNamed(
        AppRoutes.specializations,
        arguments: {
          'specializationsList': allSpecializationsList,
        },
      );
    }
  }

  specializationSelected({
    required SpecializationModel specializationModel,
  }) async {
    if (allDoctors.isEmpty || allSpecializationsList.isEmpty) {
      loading();
      if (allDoctors.isEmpty) {
        await getAllDoctors();
      }
      if (allSpecializationsList.isEmpty) {
        await getAllSpecializations();
      }
      Get.offNamed(
        AppRoutes.allDoctors,
        arguments: {
          'specializationsList': allSpecializationsList,
          'appliedFilter': specializationModel.specialization,
          'searchCon': searchCon,
        },
      );
    } else {
      Get.toNamed(
        AppRoutes.allDoctors,
        arguments: {
          'specializationsList': allSpecializationsList,
          'appliedFilter': specializationModel.specialization,
          'searchCon': searchCon,
        },
      );
    }
  }

  // getLocation() async {
  //   PermissionStatus gps = await Permission.location.request();
  //   bool isGpsEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!isGpsEnabled) {
  //     Get.snackbar('Alert', 'Please Enable Location');
  //   }
  //   if (gps.isGranted && isGpsEnabled) {
  //     Position currentPos = await Geolocator.getCurrentPosition();
  //     await FlGeocoder('').findAddressesFromLocationCoordinates(
  //       location: Location(currentPos.latitude, currentPos.longitude),
  //     );
  //   }
  // }

  getAllData() {
    getMainData();
    getOffers();
    getBlogs();
    getAllDoctors();
    getAllSpecializations();
  }

  goToHomeSample() {
    Get.toNamed(
      AppRoutes.homeCollection,
    );
  }

  getMainData() async {
    var res = await homeRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        topDoctors = responseModel.doctorsList!;
        commonSpecializationsList = responseModel.specializationsList!;
        labsList = responseModel.labsList!;
        clinicsList = responseModel.clinicsList!;
        update();
      }
    }
  }

  getOffers() async {
    var res = await offersRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        offersList = responseModel.offersList!;
        update();
      }
    }
  }

  getBlogs() async {
    var res = await blogsRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        blogsList = responseModel.blogsList!;
        update();
      }
    }
  }

  homeRequest() async {
    var res = await crud.connect(
      link: AppLinks.home,
      method: 'GET',
    );
    return res.fold((l) => l, (r) => r);
  }

  offersRequest() async {
    var res = await crud.connect(
      link: AppLinks.offers,
    );
    return res.fold((l) => l, (r) => r);
  }

  blogsRequest() async {
    var res = await crud.connect(
      link: AppLinks.blogs,
    );
    return res.fold((l) => l, (r) => r);
  }

  // Labs
  diagnosticTests() async {
    if (allLabTests.isEmpty
        //  || allLabs.isEmpty
        ) {
      loading();
      // if (allLabs.isEmpty) {
      //   var labsRes = await labsListRequest();
      //   if (labsRes is RequsetStatus == false) {
      //     ResponseModel labResponseModel = ResponseModel.fromJson(labsRes);
      //     if (labResponseModel.responseCode == '200') {
      //       allLabs = labResponseModel.labsList!;
      //     }
      //   }
      // }
      if (allLabTests.isEmpty) {
        var testsRes = await labTestsRequest();
        if (testsRes is RequsetStatus == false) {
          ResponseModel testResponseModel = ResponseModel.fromJson(testsRes);
          if (testResponseModel.responseCode == '200') {
            allLabTests = testResponseModel.testsList!;
          }
        }
      }
      Get.offNamed(
        AppRoutes.allTests,
        arguments: {
          // 'allLabs': allLabs,
          'allTests': allLabTests,
        },
      );
    } else {
      Get.toNamed(
        AppRoutes.allTests,
        arguments: {
          // 'allLabs': allLabs,
          'allTests': allLabTests,
        },
      );
    }
  }

  // labsListRequest() async {
  //   var res = await crud.connect(
  //     link: AppLinks.labsList,
  //   );
  //   return res.fold((l) => l, (r) => r);
  // }

  labTestsRequest() async {
    var res = await crud.connect(
      link: AppLinks.testsList,
    );
    return res.fold((l) => l, (r) => r);
  }

  // Pharmacies
  // allPharamaciesRequest() async {
  //   var res = await crud.connect(
  //     link: AppLinks.pharmaciesList,
  //   );
  //   return res.fold((l) => l, (r) => r);
  // }

  allPharamaciesProductsRequest() async {
    var res = await crud.connect(
      link: AppLinks.pharmacyProducts,
    );
    return res.fold((l) => l, (r) => r);
  }

  allPharamaciesCategoriesRequest() async {
    var res = await crud.connect(
      link: AppLinks.pharmacyCategories,
    );
    return res.fold((l) => l, (r) => r);
  }

  onlinePharmacy() async {
    if (
        // allPharmacies.isEmpty ||
        allPharmaciesCategories.isEmpty || allPharmaciesProducts.isEmpty) {
      loading();
      getCartProducts();
      // if (allPharmacies.isEmpty) {
      // var pharmaciesRes = await allPharamaciesRequest();
      // if (pharmaciesRes is RequsetStatus == false) {
      //   ResponseModel pharmaciesResponseModel =
      //       ResponseModel.fromJson(pharmaciesRes);
      //   if (pharmaciesResponseModel.responseCode == '200') {
      //     allPharmacies = pharmaciesResponseModel.data['data'];
      //   }
      // }
      // }
      if (allPharmaciesCategories.isEmpty) {
        var pharmaciesCategoriesRes = await allPharamaciesCategoriesRequest();
        if (pharmaciesCategoriesRes is RequsetStatus == false) {
          ResponseModel pharmaciesCategoriesResponseModel =
              ResponseModel.fromJson(pharmaciesCategoriesRes);
          if (pharmaciesCategoriesResponseModel.responseCode == '200') {
            allPharmaciesCategories =
                pharmaciesCategoriesResponseModel.data['main_product'];
            allUnits = pharmaciesCategoriesResponseModel.data['unit'];
          }
        }
      }
      if (allPharmaciesProducts.isEmpty) {
        var pharmaciesProductsRes = await allPharamaciesProductsRequest();
        if (pharmaciesProductsRes is RequsetStatus == false) {
          ResponseModel pharmaciesProductsResponseModel =
              ResponseModel.fromJson(pharmaciesProductsRes);
          if (pharmaciesProductsResponseModel.responseCode == '200') {
            allPharmaciesProducts =
                pharmaciesProductsResponseModel.productsList!;
          }
        }
      }
      Get.offNamed(
        AppRoutes.pharmaciesProducts,
        arguments: {
          // 'pharmaciesList': allPharmacies,
          'pharmaciesCategories': allPharmaciesCategories,
          'pharmaciesProducts': allPharmaciesProducts,
          'cartProducts': cartProducts,
          'units': allUnits,
        },
      );
    } else {
      loading();
      getCartProducts();
      Get.offNamed(
        AppRoutes.pharmaciesProducts,
        arguments: {
          // 'pharmaciesList': allPharmacies,
          'pharmaciesCategories': allPharmaciesCategories,
          'pharmaciesProducts': allPharmaciesProducts,
          'cartProducts': cartProducts,
          'units': allUnits,
        },
      );
    }
  }

  // Offers
  offerDetails({required OffersModel offerModel}) async {
    if (offerModel.type == '0') {
      if (allPharmaciesProducts.isEmpty) {
        loading();
        var pharmaciesProductsRes = await allPharamaciesProductsRequest();
        if (pharmaciesProductsRes is RequsetStatus == false) {
          ResponseModel pharmaciesProductsResponseModel =
              ResponseModel.fromJson(pharmaciesProductsRes);
          if (pharmaciesProductsResponseModel.responseCode == '200') {
            allPharmaciesProducts =
                pharmaciesProductsResponseModel.productsList!;
          }
        }
        Get.offNamed(
          AppRoutes.offerScreen,
          arguments: {
            'offerModel': offerModel,
            'allProductsList': allPharmaciesProducts,
          },
        );
      } else {
        Get.toNamed(
          AppRoutes.offerScreen,
          arguments: {
            'offerModel': offerModel,
            'allProductsList': allPharmaciesProducts,
          },
        );
      }
    } else if (offerModel.type == '1') {
      if (allLabTests.isEmpty) {
        loading();
        var testsRes = await labTestsRequest();
        if (testsRes is RequsetStatus == false) {
          ResponseModel testResponseModel = ResponseModel.fromJson(testsRes);
          if (testResponseModel.responseCode == '200') {
            allLabTests = testResponseModel.testsList!;
          }
        }
        Get.offNamed(
          AppRoutes.offerScreen,
          arguments: {
            'offerModel': offerModel,
            'allTests': allLabTests,
          },
        );
      } else {
        Get.toNamed(
          AppRoutes.offerScreen,
          arguments: {
            'offerModel': offerModel,
            'allTests': allLabTests,
          },
        );
      }
    }
  }

  // Doctors
  getAllDoctors() async {
    var res = await allDoctorsRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        allDoctors = responseModel.doctorsList!;
        update();
      }
    }
  }

  getAllSpecializations() async {
    var res = await allSpecializationsRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        allSpecializationsList = responseModel.specializationsList!;
        update();
      }
    }
  }

  seeAllDoctors() async {
    if (allDoctors.isEmpty || allSpecializationsList.isEmpty) {
      loading();
      if (allDoctors.isEmpty) {
        await getAllDoctors();
      }
      if (allSpecializationsList.isEmpty) {
        await getAllSpecializations();
      }
      Get.offNamed(
        AppRoutes.allDoctors,
        arguments: {
          'specializationsList': allSpecializationsList,
          'searchCon': searchCon,
        },
      );
    } else if (allDoctors.isNotEmpty && allSpecializationsList.isNotEmpty) {
      Get.toNamed(
        AppRoutes.allDoctors,
        arguments: {
          'specializationsList': allSpecializationsList,
          'searchCon': searchCon,
        },
      );
    }
  }

  viewDoctor({required DoctorModel doctorModel}) async {
    loading();
    var res = await doctorDetailsRequest(doctorModel: doctorModel);
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        AdvancedDoctorModel advancedDoctorModel = AdvancedDoctorModel.fromJson(
          responseModel.data,
        );
        advancedDoctorModel.expYears = doctorModel.experience;
        Get.offNamed(
          AppRoutes.doctorScreen,
          arguments: {
            'advancedDoctorModel': advancedDoctorModel,
            'allDoctors': allDoctors,
            'allSpecializations': allSpecializationsList,
            'previousRoute': Get.currentRoute,
          },
        );
      }
    }
  }

  onlineConsultation() async {
    if (allDoctors.isEmpty || allSpecializationsList.isEmpty) {
      loading();
      if (allDoctors.isEmpty) {
        await getAllDoctors();
      }
      if (allSpecializationsList.isEmpty) {
        await getAllSpecializations();
      }
      Get.offNamed(
        AppRoutes.allDoctors,
        arguments: {
          'specializationsList': allSpecializationsList,
          'searchCon': searchCon,
        },
      );
    } else if (allDoctors.isNotEmpty && allSpecializationsList.isNotEmpty) {
      Get.toNamed(
        AppRoutes.allDoctors,
        arguments: {
          'specializationsList': allSpecializationsList,
          'searchCon': searchCon,
        },
      );
    }
  }

  bookNow({required DoctorModel doctorModel}) async {
    await checkAvailableTimes(doctorModel: doctorModel);
    String? nextAvailable =
        await nextAvailableAppointment(doctorId: doctorModel.id!);
    List<SessionModel> savedSessions = [];
    for (var element in sessions) {
      SessionModel sessionModel = SessionModel.fromJson(element);
      savedSessions.add(sessionModel);
    }
    sessions = [];

    Get.offNamed(
      AppRoutes.appointment,
      arguments: {
        'doctor_id': doctorModel.id,
        'doctor_name': doctorModel.fullName,
        'doctor_image': doctorModel.profileimage,
        'amount': doctorModel.amount,
        'today_sessions': savedSessions,
        'nextAvailable': nextAvailable,
        'previousRoute': Get.currentRoute,
      },
    );
  }

  checkAvailableTimes({required DoctorModel doctorModel}) async {
    loading();
    var res = await checkAvailableTimesRequest(doctorModel: doctorModel);
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        if (responseModel.data is List) {
          for (var element in responseModel.data) {
            sessions.add(element);
          }
        }
      }
    }
  }

  checkAvailableTimesRequest({required DoctorModel doctorModel}) async {
    String todayDate =
        tz.TZDateTime.now(indianTimeZone).toString().substring(0, 10);
    var res = await crud.connect(
      link: AppLinks.availableSlots,
      data: {
        'schedule_date': todayDate,
        'doctor_id': doctorModel.id,
      },
      headers: {
        'token': AppLinks.token,
        'timezone': 'Asia/Kolkata',
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  nextAvailableAppointment({required String doctorId}) async {
    String? nextAvailable;
    var res = await nextAvailableAppointmentRequest(doctorId: doctorId);
    ResponseModel responseModel = ResponseModel.fromJson(res);
    if (responseModel.responseCode == '200') {
      nextAvailable =
          responseModel.data['next_availability'].toString() == 'null'
              ? null
              : responseModel.data['next_availability'].toString();
    }
    return nextAvailable;
  }

  nextAvailableAppointmentRequest({required String doctorId}) async {
    var res = await crud.connect(
      link: AppLinks.nextAvailableAppointment,
      data: {
        'doctor_id': doctorId,
      },
      headers: {
        'token': AppLinks.token,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  doctorDetailsRequest({required DoctorModel doctorModel}) async {
    var res = await crud.connect(
      link: AppLinks.doctorDetails,
      data: {
        'doctor_id': doctorModel.id!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  getCartProductsRequest() async {
    var res = await crud.connect(
      link: AppLinks.getCartItems,
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  allDoctorsRequest() async {
    var res = await crud.connect(
      link: AppLinks.doctors,
    );
    return res.fold((l) => l, (r) => r);
  }

  allSpecializationsRequest() async {
    var res = await crud.connect(
      link: AppLinks.specializations,
    );
    return res.fold((l) => l, (r) => r);
  }

  notificationsRequest() async {
    var res = await crud.connect(
      link: AppLinks.notifications,
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  // Last Activity Test
  Razorpay razorpay = Razorpay();
  String bookLabTestDate = '';
  // String homeSample = '';
  // String testPrice = '';
  selectDate({required BuildContext context}) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(bookLabTestDate),
      firstDate: DateTime.parse(
          tz.TZDateTime.now(indianTimeZone).toString().substring(0, 10)),
      lastDate: DateTime.parse(bookLabTestDate).add(const Duration(days: 365)),
    );

    if (picked != null) {
      bookLabTestDate = picked.toString().substring(0, 10);
    }
  }

  lastActivityProductDetails() async {
    List cartProductsIds = [];
    loading();
    await getCartProducts();
    for (var product in cartProducts) {
      CartItemModel cartItemModel = CartItemModel.fromJson(product);
      cartProductsIds.add(cartItemModel.productModel!.id!);
    }
    Get.offNamed(
      AppRoutes.productDetails,
      arguments: {
        'productModel': savedProductModel,
        'cartProducts': cartProductsIds,
      },
    );
  }

  // bookTest({
  //   required TestModel testModel,
  //   required BuildContext context,
  // }) async {
  //  Get.to(
  //   () => TestCheckoutScreen(
  //     bookTest: () {
  //       bookTestRequest(advancedTestModel: advancedTestModel);
  //     },
  //     advancedTestModel: advancedTestModel,
  //   ),
  //   transition: Transition.downToUp,
  // );
  // await selectDate(context: context);
  // await Get.defaultDialog(
  //   middleText: 'Do You Want A Home Sample Collection ?',
  //   onWillPop: () {
  //     homeSample = '0';
  //     testPrice = testModel.amount!;
  //     Get.back();
  //     return Future.value(false);
  //   },
  //   actions: [
  //     MaterialButton(
  //       onPressed: () {
  //         homeSample = '0';
  //         testPrice = testModel.amount!;
  //         Get.back();
  //       },
  //       color: AppColors.primaryColor,
  //       child: const Text(
  //         'No',
  //         style: TextStyle(
  //           color: AppColors.secondaryColor,
  //           fontSize: 15,
  //           fontWeight: FontWeight.bold,
  //           fontFamily: AppDecoration.cairo,
  //         ),
  //       ),
  //     ),
  //     MaterialButton(
  //       onPressed: () {
  //         homeSample = '1';
  //         testPrice = (int.parse(testModel.amount!) + 100).toString();
  //         Get.back();
  //       },
  //       color: AppColors.primaryColor,
  //       child: const Text(
  //         'Yes',
  //         style: TextStyle(
  //           color: AppColors.secondaryColor,
  //           fontSize: 15,
  //           fontWeight: FontWeight.bold,
  //           fontFamily: AppDecoration.cairo,
  //         ),
  //       ),
  //     ),
  //   ],
  // );
  // razorpay.on(
  //   Razorpay.EVENT_PAYMENT_SUCCESS,
  //   (PaymentSuccessResponse response) async {
  //     var res = await bookTestRequest(testModel: testModel);

  //     if (res is RequsetStatus == false) {
  //       ResponseModel responseModel = ResponseModel.fromJson(res);
  //       if (responseModel.responseCode == '200') {
  //         Fluttertoast.showToast(
  //           msg: 'Done',
  //           textColor: AppColors.black,
  //           backgroundColor: AppColors.secondaryColor,
  //         );
  //       }
  //     }
  //   },
  // );
  // razorpay.open({
  //   'name': '${testModel.labName} - ${testModel.labTestName}',
  //   'amount': '${double.parse(testPrice).round().toInt()}00',
  //   'key': AppLinks.razorPay,
  // });
  // }

  // bookTestRequest({required TestModel testModel}) async {
  //   var res = await crud.connect(
  //     link: AppLinks.bookTest,
  //     data: {
  //       'lab_id': testModel.labId,
  //       'booking_ids': testModel.id,
  //       'appoinment_date': bookLabTestDate,
  //       'amount': testPrice,
  //       'del_type': homeSample,
  //       'payment_method': '1',
  //     },
  //     headers: {
  //       'token':  myServices.sharedPreferences.getString('token')!,
  //     },
  //   );
  //   return res.fold((l) => l, (r) => r);
  // }
}
