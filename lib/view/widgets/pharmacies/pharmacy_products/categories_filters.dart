import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/search_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/pharmacies/category_model.dart';

class CategoriesFilters extends StatelessWidget {
  const CategoriesFilters({super.key});

  @override
  Widget build(BuildContext context) {
    SearchCon searchCon = Get.find();
    return SizedBox(
      height: AppDecoration().screenHeight * 0.1,
      child: GetBuilder<SearchCon>(
        builder: (_) {
          return ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            scrollDirection: Axis.horizontal,
            children: [
              GestureDetector(
                onTap: () {
                  searchCon.filteredCategorie = '';
                  searchCon.filteredSubCategorie = '';
                  searchCon.filteredCatSubcategories = [];
                  searchCon.filteredProducts = [];
                  searchCon.update();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  decoration: BoxDecoration(
                    color: searchCon.filteredCategorie.isEmpty
                        ? AppColors.primaryColor
                        : AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      'All',
                      style: TextStyle(
                        color: searchCon.filteredCategorie.isEmpty
                            ? AppColors.secondaryColor
                            : AppColors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              ...List.generate(
                searchCon.pharmaciesCategories.length,
                (index) {
                  CategoryModel categoryModel = CategoryModel.fromJson(
                      searchCon.pharmaciesCategories[index]);

                  bool checked =
                      searchCon.filteredCategorie == categoryModel.categoryId;
                  return GestureDetector(
                    onTap: () {
                      searchCon.checkCategorieFilter(
                        checked: checked,
                        categoryModel: categoryModel,
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 350),
                      decoration: BoxDecoration(
                        color: checked
                            ? AppColors.primaryColor
                            : AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Row(
                          children: [
                            if (searchCon.availableCatImages
                                .contains(categoryModel.categoryId))
                              Image.asset(
                                '${AppDecoration.pharmacyPath}/categories/${categoryModel.categoryId}.png',
                                errorBuilder: (context, error, stackTrace) {
                                  return const SizedBox();
                                },
                              ),
                            SizedBox(width: AppDecoration().screenWidth * 0.01),
                            Text(
                              categoryModel.categoryName!,
                              style: TextStyle(
                                color: checked
                                    ? AppColors.secondaryColor
                                    : AppColors.grey,
                              ),
                            ),
                            SizedBox(width: AppDecoration().screenWidth * 0.01),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
