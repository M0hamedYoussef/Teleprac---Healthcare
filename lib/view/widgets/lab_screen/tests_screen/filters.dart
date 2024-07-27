import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/labs/tests_controller.dart';
import 'package:teleprac/controller/search_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/global/drop_down_model.dart';

class TestsFilters extends StatelessWidget {
  const TestsFilters({super.key});

  @override
  Widget build(BuildContext context) {
    TestsController controller = Get.find();
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
                  searchCon.testCategorieFilter = '';
                  searchCon.update();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  decoration: BoxDecoration(
                    color: searchCon.testCategorieFilter.isEmpty
                        ? AppColors.primaryColor
                        : AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  padding: const EdgeInsets.all(8),
                  child: FittedBox(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'All',
                            style: TextStyle(
                              color: searchCon.testCategorieFilter.isEmpty
                                  ? AppColors.secondaryColor
                                  : AppColors.grey,
                            ),
                          ),
                          Text(
                            '(imaging,tests)',
                            style: TextStyle(
                              color: searchCon.testCategorieFilter.isEmpty
                                  ? AppColors.secondaryColor
                                  : AppColors.grey,
                              fontSize: AppDecoration().screenWidth * 0.033,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await controller.masterPackagesSelected();
                  searchCon.testCategorieFilter = 'Packages';
                  searchCon.update();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  decoration: BoxDecoration(
                    color: searchCon.testCategorieFilter == 'Packages'
                        ? AppColors.primaryColor
                        : AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      'Packages',
                      style: TextStyle(
                        color: searchCon.testCategorieFilter == 'Packages'
                            ? AppColors.secondaryColor
                            : AppColors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              ...List.generate(
                searchCon.testsCategories.length,
                (index) {
                  DropDownItemModel testCategoryModel =
                      DropDownItemModel.fromJson(
                    searchCon.testsCategories[index],
                  );
                  String testCategorie = testCategoryModel.value!;
                  return GestureDetector(
                    onTap: () {
                      searchCon.testCategorieFilter = testCategoryModel.value!;
                      searchCon.update();
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 350),
                      decoration: BoxDecoration(
                        color: searchCon.testCategorieFilter == testCategorie
                            ? AppColors.primaryColor
                            : AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                          testCategoryModel.label!,
                          style: TextStyle(
                            color:
                                searchCon.testCategorieFilter == testCategorie
                                    ? AppColors.secondaryColor
                                    : AppColors.grey,
                          ),
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
