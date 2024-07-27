import 'package:get/get.dart';

class MyLabAppointmentsController extends GetxController {
  late List myLabAppointments;

  @override
  void onInit() {
    myLabAppointments = Get.arguments['labAppointmentsList'];
    super.onInit();
  }
}
