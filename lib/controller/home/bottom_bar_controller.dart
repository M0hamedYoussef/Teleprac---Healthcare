import 'package:get/get.dart';
import 'package:teleprac/controller/main_controller.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/view/screens/home/account_screen/account_screen.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/dashboard_screen.dart';

class BottomBarController extends GetxController {
  MainController mainController = Get.find();

  account() async {
    if (mainController.allSpecializationsList.isEmpty) {
      loading();
      await mainController.getAllSpecializations();
      Get.off(
        () => const AccountScreen(),
        arguments: {
          'specializationsList': mainController.allSpecializationsList,
        },
        transition: Transition.downToUp,
      );
    } else {
      Get.to(
        () => const AccountScreen(),
        arguments: {
          'specializationsList': mainController.allSpecializationsList,
        },
        transition: Transition.downToUp,
      );
    }
  }

  labTest() {
    mainController.diagnosticTests();
  }

  pharmacy() {
    mainController.onlinePharmacy();
  }

  doctor() {
    mainController.onlineConsultation();
  }

  dashboardScreen() {
    Get.to(
      () => const DashboardScreen(),
      transition: Transition.downToUp,
    );
  }

  notificationsScreen() {
    mainController.notifications();
  }
}
