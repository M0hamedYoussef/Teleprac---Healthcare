import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppMiddleware extends GetMiddleware {
  MyServices myServices = Get.find();

  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    if (myServices.loginSuccess == true) {
      return const RouteSettings(name: AppRoutes.home);
    }

    return null;
  }
}
