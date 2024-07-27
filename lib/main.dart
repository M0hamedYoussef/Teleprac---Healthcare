import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/binding/my_binding.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/routes.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();
  await initService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: MyBindings(),
      initialRoute: AppRoutes.onBoardingScreen,
      theme: ThemeData.light(useMaterial3: false).copyWith(
        colorScheme: ColorScheme.fromSwatch(
          accentColor: AppColors.primaryColor.withOpacity(0.7),
        ),
      ),
      getPages: routes,
    );
  }
}
