import 'package:get/get.dart';
import 'package:teleprac/model/specializations/specializations_model.dart';
import 'package:teleprac/routes.dart';

class SpecializationsController extends GetxController {
  List specializationsList = [];

  @override
  void onInit() {
    super.onInit();
    specializationsList = Get.arguments['specializationsList'];
  }

  specializationSelected({
    required SpecializationModel specializationModel,
  }) async {
    Get.toNamed(
      AppRoutes.allDoctors,
      arguments: {
        'specializationsList': specializationsList,
        'appliedFilter': specializationModel.specialization,
      },
    );
  }


}
