import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:teleprac/controller/main_controller.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/core/functions/replace.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/model/labs/tests/advanced_test_model.dart';
import 'package:teleprac/model/labs/tests/test_model.dart';
import 'package:teleprac/routes.dart';
import 'package:teleprac/view/screens/labs/tests/test_checkout_screen.dart';
import 'package:teleprac/view/screens/labs/tests/test_details_screen.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/standalone.dart';

class TestsController extends GetxController {
  List allLabs = [];
  List allTests = [];
  List imagingTests = [];
  List labTests = [];
  List packages = [];
  late String labId;
  late Location indianTimeZone;
  AdvancedTestModel? advancedTestModel;
  MyServices myServices = Get.find();
  MainController mainController = Get.find();
  Crud crud = Crud();
  Razorpay razorpay = Razorpay();
  late String appointmentDate;
  String homeSample = '0';
  String testPrice = '';

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments['allTests'] != null) {
        allTests = Get.arguments['allTests'];
        for (var element in allTests) {
          TestModel testModel = TestModel.fromJson(element);
          if (testModel.category == '0') {
            imagingTests.add(element);
          } else {
            labTests.add(element);
          }
        }
      }
      if (Get.arguments['labId'] != null) {
        labId = Get.arguments['labId'];
      } else {
        labId = 'all';
      }
    }

    initializeTimeZones();
    indianTimeZone = getLocation('Asia/Kolkata');
    appointmentDate =
        TZDateTime.now(indianTimeZone).toString().substring(0, 10);
    super.onInit();
  }

  Future<bool> selectDate({required BuildContext context}) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(appointmentDate),
      firstDate: DateTime.parse(
          TZDateTime.now(indianTimeZone).toString().substring(0, 10)),
      lastDate: DateTime.parse(appointmentDate).add(const Duration(days: 365)),
    );

    if (picked != null) {
      appointmentDate = picked.toString().substring(0, 10);
      return true;
    } else {
      return false;
    }
  }

  goToCheckoutScreen({
    required AdvancedTestModel advancedTestModel,
  }) {
    Get.to(
      () => TestCheckoutScreen(
        advancedTestModel: advancedTestModel,
      ),
      transition: Transition.downToUp,
    );
  }

  bookTest({
    required AdvancedTestModel advancedTestModel,
    required BuildContext context,
  }) async {
    bool con = await selectDate(context: context);
    if (con) {
      if (homeSample == '1') {
        testPrice = (double.parse(advancedTestModel.testDetails!.amount!) + 100)
            .toString();
      } else {
        testPrice = advancedTestModel.testDetails!.amount!;
      }

      razorpay.on(
        Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) async {
          var res = await bookTestRequest(advancedTestModel: advancedTestModel);
          if (res is RequsetStatus == false) {
            ResponseModel responseModel = ResponseModel.fromJson(res);
            if (responseModel.responseCode == '200') {
              Fluttertoast.showToast(
                msg: 'Done',
                textColor: AppColors.black,
                backgroundColor: AppColors.secondaryColor,
              );
            }
          }
        },
      );
      razorpay.open({
        'name':
            '${advancedTestModel.labDetails!.fullName} - ${advancedTestModel.testDetails!.labTestName}',
        'amount': '${double.parse(testPrice).round()}00',
        'key': AppLinks.razorPay,
      });
    }
  }

  testDetails({
    required TestModel testModel,
    required BuildContext context,
  }) async {
    loading();
    var res = await testDetailsRequest(testModel: testModel);
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        advancedTestModel = AdvancedTestModel.fromJson(
          responseModel.data,
        );
        advancedTestModel!.testDetails!.labTestId = testModel.id;
        await myServices.sharedPreferences.setString('lastViewingType', 'test');
        await myServices.sharedPreferences
            .setString('testID', advancedTestModel!.testDetails!.labTestId!);
        await myServices.sharedPreferences
            .setString('labID', advancedTestModel!.testDetails!.labId!);
        await myServices.sharedPreferences
            .setString('labPFP', advancedTestModel!.labDetails!.profileimage!);
        await myServices.sharedPreferences.setString(
            'testName', advancedTestModel!.testDetails!.labTestName!);
        await myServices.sharedPreferences
            .setString('testLabName', advancedTestModel!.labDetails!.fullName!);
        if (advancedTestModel!.testDetails!.description != null) {
          await myServices.sharedPreferences.setString(
            'testDescription',
            replace(
              text: advancedTestModel!.testDetails!.description!,
              replace: {
                '.\n\n': '.',
                ':\n\n•': ':',
              },
            ),
          );
        }
        if (advancedTestModel!.testDetails!.discount != null) {
          await myServices.sharedPreferences.setString(
              'testDiscount', advancedTestModel!.testDetails!.discount!);
        }
        if (advancedTestModel!.testDetails!.mrp != null) {
          await myServices.sharedPreferences
              .setString('testMRP', advancedTestModel!.testDetails!.mrp!);
        }
        await myServices.sharedPreferences
            .setString('testPrice', advancedTestModel!.testDetails!.amount!);
        mainController.setLast();
        Get.off(
          () => TestDetailsScreen(
            advancedTestModel: advancedTestModel!,
          ),
        );
      }
    }
  }

  testDetailsRequest({required TestModel testModel}) async {
    var res = await crud.connect(
      link: AppLinks.testDetails,
      data: {
        'labtest_id': testModel.id!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  bookTestRequest({required AdvancedTestModel advancedTestModel}) async {
    int random = Random().nextInt(99999999);
    var res = await crud.connect(
      link: AppLinks.bookTest,
      data: {
        'lab_id': advancedTestModel.testDetails!.labId,
        'booking_ids': advancedTestModel.testDetails!.labTestId,
        'appoinment_date': appointmentDate,
        'amount': testPrice,
        'del_type': homeSample,
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

  viewLabs() async {
    loading();
    var labsRes = await labsListRequest();
    if (labsRes is RequsetStatus == false) {
      ResponseModel labResponseModel = ResponseModel.fromJson(labsRes);
      if (labResponseModel.responseCode == '200') {
        allLabs = labResponseModel.labsList!;
      }
    }
    Get.offNamed(
      AppRoutes.allLabs,
      arguments: {
        'allTests': allTests,
        'allLabs': allLabs,
      },
    );
  }

  masterPackagesSelected() async {
    if (packages.isEmpty) {
      loading();
      var res = await masterPackagesTestsRequest();
      if (res is RequsetStatus == false) {
        ResponseModel responseModel = ResponseModel.fromJson(res);
        packages = responseModel.testsList!;
      }
      Get.back();
    }
  }

  labsListRequest() async {
    var res = await crud.connect(
      link: AppLinks.labsList,
    );
    return res.fold((l) => l, (r) => r);
  }

  masterPackagesTestsRequest() async {
    var res = await crud.connect(
      link: AppLinks.testsList,
      data: {
        'type': '1',
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

  Future<bool> testDetailsWillPop() {
    if (Get.previousRoute == AppRoutes.home) {
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
}
