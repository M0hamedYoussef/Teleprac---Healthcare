import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/pharmacies/pharmacies_controller.dart';
import 'package:teleprac/controller/search_con.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/pharmacies/pharmacy_products/categories_filters.dart';
import 'package:teleprac/view/widgets/pharmacies/pharmacy_products/products_list.dart';
import 'package:teleprac/view/widgets/pharmacies/pharmacy_products/search_bar.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/view/widgets/pharmacies/pharmacy_products/subcategories_filters.dart';

class PharmaciesProductsScreen extends StatelessWidget {
  const PharmaciesProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SearchCon());
    PharmaciesController controller = Get.put(PharmaciesController());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: WillPopScope(
        onWillPop: controller.willPop,
        child: SafeArea(
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            // Stack(
            children: [
              UpperPart(
                text: 'Products',
                customBackFunction: controller.willPop,
              ),
              SizedBox(height: AppDecoration().screenHeight * 0.02),
              const PharmacyProductsSearchBar(),
              SizedBox(height: AppDecoration().screenHeight * 0.01),
              if (!controller.pharmacySelected)
                CustomButton(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  function: () {
                    controller.seeAllPharmacies();
                  },
                  buttonColor: AppColors.primaryColor,
                  text: 'See All Phramacies',
                ),

              const CategoriesFilters(),
              const SubcategoriesFilters(),
              const PharmacyProductsList(),
              // GestureDetector(
              //   onTap: () {
              //     searchCon.closeFiltersContainer();
              //   },
              //   child: CustomContainer(
              //     decorationImage: const DecorationImage(
              //       image: AssetImage(
              //         AppDecoration.homeBg,
              //       ),
              //       fit: BoxFit.fill,
              //     ),
              //     margin: null,
              //     height: 1,
              //     children: [
              //       const UpperPart(),
              //       SizedBox(height: AppDecoration().screenHeight * 0.02),
              //       const PharmacyProductsSearchBar(),
              //       SizedBox(height: AppDecoration().screenHeight * 0.01),
              //       const PharmacyProductsList(),
              //     ],
              //   ),
              // ),
              // const CategoriesSearchFilter(),
            ],
          ),
        ),
      ),
    );
  }
}
