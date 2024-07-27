import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/search_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/pharmacies/category_model.dart';

class SubcategoriesFilters extends StatelessWidget {
  const SubcategoriesFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchCon>(
      builder: (searchCon) {
        if (searchCon.filteredCatSubcategories.isNotEmpty) {
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
                        searchCon.checkSubCategorieFilter(checked: true);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 350),
                        decoration: BoxDecoration(
                          color: searchCon.filteredSubCategorie.isEmpty
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
                              color: searchCon.filteredSubCategorie.isEmpty
                                  ? AppColors.secondaryColor
                                  : AppColors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ...List.generate(
                      searchCon.filteredCatSubcategories.length,
                      (index) {
                        SubCateogory subCateogoryModel =
                            searchCon.filteredCatSubcategories[index];
                        bool checked = searchCon.filteredSubCategorie ==
                            subCateogoryModel.subCategoryId!;
                        return GestureDetector(
                          onTap: () {
                            searchCon.checkSubCategorieFilter(
                              checked: checked,
                              subCateogory: subCateogoryModel,
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
                                  if (searchCon.availableSubcatImages.contains(
                                      subCateogoryModel.subCategoryId))
                                    Image.asset(
                                      '${AppDecoration.pharmacyPath}/subcategories/${subCateogoryModel.subCategoryId}_subcat.png',
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const SizedBox();
                                      },
                                    ),
                                  SizedBox(
                                      width:
                                          AppDecoration().screenWidth * 0.01),
                                  Text(
                                    subCateogoryModel.subCategoryName!,
                                    style: TextStyle(
                                      color: checked
                                          ? AppColors.secondaryColor
                                          : AppColors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          AppDecoration().screenWidth * 0.01),
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
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
