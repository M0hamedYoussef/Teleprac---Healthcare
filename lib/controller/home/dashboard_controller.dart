import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/main_controller.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/model/home/dashboard/accounts/account_details_model.dart';
import 'package:teleprac/routes.dart';

class DashboardController extends GetxController {
  late String myRole;
  late String myId;
  Crud crud = Crud();
  MyServices myServices = Get.find();
  MainController mainController = Get.find();

  @override
  void onInit() {
    myRole = myServices.sharedPreferences.getString('role')!;
    myId = myServices.sharedPreferences.getString('id')!;
    super.onInit();
  }

  myAppointments() async {
    loading();
    var res = await myAppointmentsRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        Get.offNamed(
          AppRoutes.myAppointmentsScreen,
          arguments: {
            'appointmentsList': responseModel.appointmentsList,
          },
        );
      } else if (responseModel.responseCode == '201') {
        Get.back();
        Get.defaultDialog(middleText: 'List Is Empty');
      }
    }
  }

  getSchedule() async {
    loading();
    var res = await getScheduleRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200' ||
          responseModel.responseCode == '201') {
        Get.offNamed(
          AppRoutes.mySchedulseScreen,
          arguments: {
            'schedulesList': responseModel.scheduleList!,
            'slotDuration': responseModel.slotDuration!,
          },
        );
      }
    }
  }

  myPrescriptions() async {
    loading();
    var res = await myPrescriptionsRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        Get.offNamed(
          AppRoutes.myPrescriptionsScreen,
          arguments: {
            'prescriptionList': responseModel.prescriptionsList,
          },
        );
      } else if (responseModel.responseCode == '201') {
        Get.back();
        Get.defaultDialog(middleText: 'List Is Empty');
      }
    }
  }

  myLabAppointments() async {
    loading();
    var res = await myLabAppointmentsRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        Get.offNamed(
          AppRoutes.labAppointmentsScreen,
          arguments: {
            'labAppointmentsList': responseModel.appointmentsList,
          },
        );
      } else if (responseModel.responseCode == '201') {
        Get.back();
        Get.defaultDialog(middleText: 'List Is Empty');
      }
    }
  }

  myInvoices() async {
    loading();
    var res = await myInvoicesRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        Get.offNamed(
          AppRoutes.myInvoicesScreen,
          arguments: {
            'invoicesList': responseModel.invoicesList,
          },
        );
      } else if (responseModel.responseCode == '201') {
        Get.back();
        Get.defaultDialog(middleText: 'List Is Empty');
      }
    }
  }

  myMedicalHistory() async {
    loading();
    var res = await myMedicalHistoryRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        Get.offNamed(
          AppRoutes.medicalHistoryScreen,
          arguments: {
            'medical_history': responseModel.medicalHistoryList,
          },
        );
      }
    }
  }

  myMedicalHistoryRequest() async {
    var res = await crud.connect(
      link: AppLinks.medicalHistory,
      data: {
        'patient_id': myId,
      },
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  myFavourites() async {
    if (myServices.myFavouritesList.isNotEmpty) {
      Get.toNamed(
        AppRoutes.myFavouritesScreen,
        arguments: {
          'favouritesList': myServices.myFavouritesList,
        },
      );
    } else {
      loading();
      var res = await myFavouritesRequest();
      Get.back();
      if (res is RequsetStatus == false) {
        ResponseModel responseModel = ResponseModel.fromJson(res);
        if (responseModel.responseCode == '200') {
          Get.toNamed(
            AppRoutes.myFavouritesScreen,
            arguments: {
              'favouritesList': responseModel.doctorsList!,
            },
          );
        } else if (responseModel.responseCode == '201') {
          Get.defaultDialog(middleText: 'Favourites List Is Empty');
        }
      }
    }
  }

  myMessages() async {
    loading();
    var res = await myMessagesRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        Get.offNamed(
          AppRoutes.myChatsScreen,
          arguments: {
            'chatsList': responseModel.chatsList,
          },
        );
      } else if (responseModel.responseCode == '201') {
        Get.back();
        Get.defaultDialog(middleText: 'No Messages');
      }
    }
  }

  myOrders() async {
    loading();
    var res = await myOrdersRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);

      if (responseModel.responseCode == '200') {
        Get.offNamed(
          AppRoutes.myOrdersScreen,
          arguments: {
            'ordersList': responseModel.ordersList,
          },
        );
      } else if (responseModel.responseCode == '201' ||
          responseModel.responseCode == '500') {
        Get.back();
        Get.defaultDialog(middleText: 'List Is Empty');
      }
    }
  }

  myFamily() async {
    loading();
    var res = await myFamilyRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);

      if (responseModel.responseCode == '200' ||
          responseModel.responseCode == '201') {
        Get.offNamed(
          AppRoutes.myFamilyScreen,
          arguments: {
            'family_members': responseModel
                .doctorsList, // it's the same as doctor_list from API
          },
        );
      }
    }
  }

  myPatients() async {
    loading();
    var res = await myPatientsRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        Get.offNamed(
          AppRoutes.myPatientsScreen,
          arguments: {
            'patientsList': responseModel.patientsList,
          },
        );
      } else if (responseModel.responseCode == '201') {
        Get.back();
        Get.defaultDialog(middleText: 'List Is Empty');
      }
    }
  }

  myReviews() async {
    loading();
    var res = await myReviewsRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        Get.offNamed(
          AppRoutes.myReviewsScreen,
          arguments: {
            'reviews_list': responseModel.reviewsList,
          },
        );
      } else if (responseModel.responseCode == '201') {
        Get.back();
        Get.defaultDialog(middleText: 'List Is Empty');
      }
    }
  }

  myProducts() async {
    loading();
    if (mainController.allPharmaciesCategories.isEmpty) {
      var pharmaciesCategoriesRes =
          await mainController.allPharamaciesCategoriesRequest();
      if (pharmaciesCategoriesRes is RequsetStatus == false) {
        ResponseModel pharmaciesCategoriesResponseModel =
            ResponseModel.fromJson(pharmaciesCategoriesRes);
        if (pharmaciesCategoriesResponseModel.responseCode == '200') {
          mainController.allPharmaciesCategories =
              pharmaciesCategoriesResponseModel.data['main_product'];
          mainController.allUnits =
              pharmaciesCategoriesResponseModel.data['unit'];
        }
      }
    }
    var res = await myProductsRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        Get.offNamed(
          AppRoutes.myProductsScreen,
          arguments: {
            'myProductsList': responseModel.myProductsList,
            'pharmaciesCategories': mainController.allPharmaciesCategories,
            'allUnits': mainController.allUnits,
          },
        );
      } else if (responseModel.responseCode == '201') {
        Get.back();
        Get.defaultDialog(middleText: 'List Is Empty');
      }
    }
  }

  payForMedicines() async {
    loading();
    var res = await myPrescriptionsRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        Get.offNamed(
          AppRoutes.payForMedicinesScreen,
          arguments: {
            'prescriptionList': responseModel.prescriptionsList,
          },
        );
      } else if (responseModel.responseCode == '201') {
        Get.back();
        Get.defaultDialog(middleText: 'List Is Empty');
      }
    }
  }

  payForLabTests() async {
    loading();
    var res = await payForLabTestsRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        Get.offNamed(
          AppRoutes.payForLabTestsScreen,
          arguments: {
            'tests_list': responseModel.recommendedTestsList,
          },
        );
      } else if (responseModel.responseCode == '201') {
        Get.back();
        Get.defaultDialog(middleText: 'List Is Empty');
      }
    }
  }

  doctorAccounts() async {
    loading();
    var doctorAcountRes = await getDoctorAccountDetails();
    ResponseModel doctorAccountResponseModel =
        ResponseModel.fromJson(doctorAcountRes);
    AccountDetailsModel accountDetailsModel =
        AccountDetailsModel.fromJson(doctorAccountResponseModel.data);
    //
    var doctoAccountsList = await doctorAccountsRequest();
    ResponseModel doctorAccountsListResponseModel =
        ResponseModel.fromJson(doctoAccountsList);
    List accounts = doctorAccountsListResponseModel.accounts!;
    //
    Get.offNamed(
      AppRoutes.doctorAccountsScreen,
      arguments: {
        'accounts': accounts,
        'accountDetailsModel': accountDetailsModel,
      },
    );
  }

  // Api Requests
  myAppointmentsRequest() async {
    var res = await crud.connect(
      link: AppLinks.appointmentsList,
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  getScheduleRequest() async {
    var res = await crud.connect(
      link: AppLinks.getSchedule,
      data: {
        'day_id': '1',
      },
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  myPrescriptionsRequest() async {
    var res = await crud.connect(
      link: AppLinks.prescriptionsList,
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  payForLabTestsRequest() async {
    var res = await crud.connect(
      link: AppLinks.recommendedTests,
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  myLabAppointmentsRequest() async {
    var res = await crud.connect(
      link: AppLinks.labAppointmentsList,
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  myInvoicesRequest() async {
    var res = await crud.connect(
      link: AppLinks.invoicesList,
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  myFavouritesRequest() async {
    var res = await crud.connect(
      link: AppLinks.favouritesList,
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  myMessagesRequest() async {
    var res = await crud.connect(
      link: AppLinks.chatsList,
      method: 'GET',
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  myFamilyRequest() async {
    var res = await crud.connect(
      link: AppLinks.myFamily,
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  myOrdersRequest() async {
    var res = await crud.connect(
      link: AppLinks.ordersList,
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  myPatientsRequest() async {
    var res = await crud.connect(
      link: AppLinks.myPatients,
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  myReviewsRequest() async {
    var res = await crud.connect(
      link: AppLinks.myReviews,
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
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

  doctorAccountsRequest() async {
    var res = await crud.connect(
      link: AppLinks.doctorAccounts,
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  getDoctorAccountDetails() async {
    var res = await crud.connect(
      link: AppLinks.getDoctorAccountDetails,
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
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
