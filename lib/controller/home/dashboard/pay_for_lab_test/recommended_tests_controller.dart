import 'package:get/get.dart';
import 'package:teleprac/model/home/dashboard/recommended_test_model.dart';
import 'package:teleprac/routes.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_prescriptions/pay_for_lab_tests/recommended_test_details.dart';

class PayForLabTestsController extends GetxController {
  late List recommendedTests;

  @override
  void onInit() {
    recommendedTests = Get.arguments['tests_list'];
    super.onInit();
  }

  viewTest({required RecommendedTestModel recommendedTestModel}) {
    Get.to(
      RecommendedLabTestDetails(
        recommendedTestModel: recommendedTestModel,
      ),
      transition: Transition.downToUp,
    );
  }

  payNow({required RecommendedTestModel recommendedTestModel}) {
    Get.toNamed(
      AppRoutes.payForLabTestsCheckoutPreview,
      arguments: {
        'recommendedTestModel': recommendedTestModel,
      },
    );
  }
}
