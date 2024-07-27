import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/bottom_bar_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/view/widgets/home/blogs/blogs.dart';
import 'package:teleprac/view/widgets/home/bottom_bar.dart';
import 'package:teleprac/view/widgets/home/design/design_images.dart';
import 'package:teleprac/view/widgets/home/doctors/top_doctors.dart';
import 'package:teleprac/view/widgets/home/last_activity.dart';
import 'package:teleprac/view/widgets/home/offers/diagnostic_offers.dart';
import 'package:teleprac/view/widgets/home/offers/pharmacy_offers.dart';
import 'package:teleprac/view/widgets/home/search.dart';
import 'package:teleprac/view/widgets/home/specializations/specializations.dart';
import 'package:teleprac/view/widgets/home/upper_row.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BottomBarController());
    return Scaffold(
      // bottomNavigationBar: const HomeBottomBar(),
      backgroundColor: AppColors.greyDesign,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ListView(
              children: [
                SizedBox(height: AppDecoration().screenHeight * 0.02),
                const UpperRow(),
                SizedBox(height: AppDecoration().screenHeight * 0.03),
                const DoctorSearchBar(),
                SizedBox(height: AppDecoration().screenHeight * 0.035),
                const DesignImages(),
                SizedBox(height: AppDecoration().screenHeight * 0.02),
                const LastActivity(),
                SizedBox(height: AppDecoration().screenHeight * 0.01),
                const TopDoctors(),
                SizedBox(height: AppDecoration().screenHeight * 0.02),
                const Specializations(),
                SizedBox(height: AppDecoration().screenHeight * 0.02),
                const PharmacyOffers(),
                SizedBox(height: AppDecoration().screenHeight * 0.02),
                const DiagnosticOffers(),
                SizedBox(height: AppDecoration().screenHeight * 0.02),
                const Blogs(),
                SizedBox(height: AppDecoration().screenHeight * 0.1),
              ],
            ),
            Positioned(
              bottom: AppDecoration().screenHeight * 0.02,
              child: const HomeBottomBar(),
            ),
          ],
        ),
      ),
    );
  }
}
/*
CustomContainer(
        margin: null,
        decorationImage: const DecorationImage(
          image: AssetImage(AppDecoration.homeBg),
          fit: BoxFit.fill,
        ),
        height: 1,
        children: [
          SizedBox(height: AppDecoration().screenHeight * 0.01),
          const UpperRow(),
          SizedBox(height: AppDecoration().screenHeight * 0.02),
          const WelcomeText(),
          SizedBox(height: AppDecoration().screenHeight * 0.03),
          const DoctorSearchBar(),
          SizedBox(height: AppDecoration().screenHeight * 0.03),
          const DesignImages(),
          SizedBox(height: AppDecoration().screenHeight * 0.02),
          const LastActivity(),
          SizedBox(height: AppDecoration().screenHeight * 0.02),
          const OfferGradientContainer(),
          SizedBox(height: AppDecoration().screenHeight * 0.03),
          const TopDoctors(),
          SizedBox(height: AppDecoration().screenHeight * 0.03),
          const SurgeryGradientContainer(),
          SizedBox(height: AppDecoration().screenHeight * 0.03),
          const Specializations(),
          SizedBox(height: AppDecoration().screenHeight * 0.02),
          const PharmacyOffers(),
          SizedBox(height: AppDecoration().screenHeight * 0.02),
          const DiagnosticOffers(),
          SizedBox(height: AppDecoration().screenHeight * 0.02),
          const Blogs(),
          SizedBox(height: AppDecoration().screenHeight * 0.02),
        ],
      ),
*/
