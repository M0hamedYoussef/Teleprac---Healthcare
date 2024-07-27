import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/model/home/dashboard/prescriptions/advanced_prescription_model.dart';
import 'package:teleprac/model/home/dashboard/prescriptions/prescriprtion_model.dart';
import 'package:teleprac/routes.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_prescriptions/prescription_details.dart';

class MyPrescriptionsController extends GetxController {
  late List myPrescriptions;
  Crud crud = Crud();

  @override
  void onInit() {
    myPrescriptions = Get.arguments['prescriptionList'];
    super.onInit();
  }

  prescriptionView({
    required PrescriptionModel prescriptionModel,
  }) async {
    loading();
    var res = await prescriptionViewRequest(
      prescriptionModel: prescriptionModel,
    );
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        AdvancedPrescriptionModel advancedPrescriptionModel =
            AdvancedPrescriptionModel.fromJson(
          responseModel.data,
        );
        advancedPrescriptionModel.createdDate = prescriptionModel.createdDate;
        Get.off(
          () => PrescriptionDetailsScreen(
            advancedPrescriptionModel: advancedPrescriptionModel,
          ),
        );
      } else {
        Get.back();
        Fluttertoast.showToast(
          msg: 'Something went wrong',
          backgroundColor: AppColors.secondaryColor,
          textColor: AppColors.black,
        );
      }
    }
  }

  prescriptionViewRequest({
    required PrescriptionModel prescriptionModel,
  }) async {
    var res = await crud.connect(
      link: AppLinks.prescriptionDetails,
      data: {
        'prescription_id': prescriptionModel.id!,
      },
      headers: {
        'token': AppLinks.token,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  payNow({
    required PrescriptionModel prescriptionModel,
  }) async {
    loading();
    var res = await payNowRequest(
      prescriptionModel: prescriptionModel,
    );
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        List products = responseModel.data;
        Get.offNamed(
          AppRoutes.payForMedicinesCheckoutPreview,
          arguments: {
            'products': products,
          },
        );
      } else {
        Get.back();
        Fluttertoast.showToast(
          msg: 'Something went wrong',
          backgroundColor: AppColors.secondaryColor,
          textColor: AppColors.black,
        );
      }
    }
  }

  payNowRequest({
    required PrescriptionModel prescriptionModel,
  }) async {
    var res = await crud.connect(
      link: AppLinks.prescriptionCheckout,
      data: {
        'prescription_id': prescriptionModel.id,
      },
      headers: {
        'token': AppLinks.token,
      },
    );
    return res.fold((l) => l, (r) => r);
  }
}
