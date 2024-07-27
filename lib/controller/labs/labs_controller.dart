import 'package:get/get.dart';
import 'package:teleprac/controller/labs/tests_controller.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/model/labs/advanced_lab_model.dart';
import 'package:teleprac/model/labs/lab_model.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/routes.dart';

class LabsController extends GetxController {
  late List allLabs;
  late List allTests;
  AdvancedLabModel? advancedLabModel;
  TestsController testsController = Get.put(TestsController());
  Crud crud = Crud();
  @override
  void onInit() {
    allLabs = Get.arguments['allLabs'];
    allTests = Get.arguments['allTests'];
    super.onInit();
  }

  bookTest() {
    testsController.labId = advancedLabModel!.labId!;
    testsController.update();
    Get.toNamed(
      AppRoutes.labTests,
    );
  }

  labDetails({required LabModel labModel}) async {
    loading();
    var res = await labDetailsRequest(labModel: labModel);
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        advancedLabModel = AdvancedLabModel.fromJson(
          responseModel.labDetails!,
        );
        Get.offNamed(AppRoutes.labProfile);
      }
    }
  }

  labDetailsRequest({required LabModel labModel}) async {
    var res = await crud.connect(
      link: AppLinks.labDetails,
      data: {
        'lab_id': labModel.id!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  viewLabTests({required LabModel labModel}) {
    testsController.labId = labModel.id!;
    testsController.update();
    Get.toNamed(
      AppRoutes.labTests,
    );
  }

  Future<bool> willPop() {
    testsController.labId = 'all';
    testsController.update();
    Get.back();
    return Future.value(false);
  }
}
