import 'package:get/get.dart';
import 'package:teleprac/model/home/dashboard/patient_model.dart';
import 'package:teleprac/routes.dart';

class MyPatientsController extends GetxController {
  late List myPatients;

  @override
  void onInit() {
    myPatients = Get.arguments['patientsList'];
    super.onInit();
  }

  viewPatientProfile({required PatientModel patientModel}) {
    Get.toNamed(
      AppRoutes.patientProfileScreen,
      arguments: {
        'patient_model': patientModel,
      },
    );
  }
}
