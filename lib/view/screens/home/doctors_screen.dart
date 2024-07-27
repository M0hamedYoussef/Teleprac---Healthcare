import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/main_controller.dart';
import 'package:teleprac/controller/search_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/specializations/specializations_model.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';
import 'package:teleprac/view/widgets/search_screen/doctors_list.dart';
import 'package:teleprac/view/widgets/search_screen/search_bar.dart';

class DoctorsWithSearch extends GetView<MainController> {
  const DoctorsWithSearch({super.key});

  @override
  Widget build(BuildContext context) {
    SearchCon searchCon = Get.put(SearchCon());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: WillPopScope(
        onWillPop: searchCon.willPop,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: AppDecoration().screenHeight * 0.01),
              const UpperPart(
                text: 'Doctors',
              ),
              SizedBox(height: AppDecoration().screenHeight * 0.01),
              const DoctorSearchBar(),
              SizedBox(height: AppDecoration().screenHeight * 0.01),
              SizedBox(
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
                            searchCon.genderFilter = '';
                            searchCon.update();
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 350),
                            decoration: BoxDecoration(
                              color: searchCon.genderFilter.isEmpty
                                  ? AppColors.primaryColor
                                  : AppColors.secondaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: AppDecoration().screenWidth * 0.15,
                            margin: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                            padding: const EdgeInsets.all(8),
                            child: Center(
                              child: Text(
                                'All',
                                style: TextStyle(
                                  color: searchCon.genderFilter.isEmpty
                                      ? AppColors.secondaryColor
                                      : AppColors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ...List.generate(
                          searchCon.allGendersList.length,
                          (index) {
                            String gender = searchCon.allGendersList[index];
                            return GestureDetector(
                              onTap: () {
                                searchCon.genderFilter = gender.toLowerCase();
                                searchCon.update();
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 350),
                                decoration: BoxDecoration(
                                  color: searchCon.genderFilter ==
                                          gender.toLowerCase()
                                      ? AppColors.primaryColor
                                      : AppColors.secondaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin:
                                    const EdgeInsets.fromLTRB(10, 15, 10, 15),
                                padding: const EdgeInsets.all(8),
                                child: Center(
                                  child: Text(
                                    gender,
                                    style: TextStyle(
                                      color: searchCon.genderFilter ==
                                              gender.toLowerCase()
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
              ),
              SizedBox(
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
                            searchCon.specialityFilters.clear();
                            searchCon.update();
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 350),
                            decoration: BoxDecoration(
                              color: searchCon.specialityFilters.isEmpty
                                  ? AppColors.primaryColor
                                  : AppColors.secondaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: AppDecoration().screenWidth * 0.15,
                            margin: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                            padding: const EdgeInsets.all(8),
                            child: Center(
                              child: Text(
                                'All',
                                style: TextStyle(
                                  color: searchCon.specialityFilters.isEmpty
                                      ? AppColors.secondaryColor
                                      : AppColors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ...List.generate(
                          searchCon.allSpecializationsList.length,
                          (index) {
                            SpecializationModel specializationModel =
                                SpecializationModel.fromJson(
                              searchCon.allSpecializationsList[index],
                            );
                            return GestureDetector(
                              onTap: () {
                                if (searchCon.specialityFilters.contains(
                                    specializationModel.specialization)) {
                                  searchCon.specialityFilters.remove(
                                      specializationModel.specialization!);
                                } else {
                                  searchCon.specialityFilters
                                      .add(specializationModel.specialization!);
                                }
                                searchCon.update();
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 350),
                                decoration: BoxDecoration(
                                  color: searchCon.specialityFilters.contains(
                                          specializationModel.specialization)
                                      ? AppColors.primaryColor
                                      : AppColors.secondaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin:
                                    const EdgeInsets.fromLTRB(10, 15, 10, 15),
                                padding: const EdgeInsets.all(8),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Image.network(
                                        specializationModel.specializationImg!,
                                        height:
                                            AppDecoration().screenHeight * 0.05,
                                      ),
                                      SizedBox(
                                        width:
                                            AppDecoration().screenWidth * 0.02,
                                      ),
                                      Text(
                                        specializationModel.specialization!,
                                        style: TextStyle(
                                          color: searchCon.specialityFilters
                                                  .contains(specializationModel
                                                      .specialization)
                                              ? AppColors.secondaryColor
                                              : AppColors.grey,
                                        ),
                                      ),
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
              ),
              SizedBox(height: AppDecoration().screenHeight * 0.02),
              const DoctorsList(),
            ],
          ),
        ),
      ),
    );
  }
}

/*
Stack(
            children: [
              GestureDetector(
                onTap: () {
                  searchCon.closeFiltersContainer();
                },
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        // gradient: AppColors.mainLinarGradient,
                        color: AppColors.greyDesign,
                      ),
                      width: AppDecoration().screenWidth,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: AppDecoration().screenHeight * 0.05,
                                  width: AppDecoration().screenHeight * 0.05,
                                  margin:
                                      const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.greySplash,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      searchCon.willPop();
                                    },
                                    borderRadius: BorderRadius.circular(10),
                                    child: const Icon(
                                      Icons.arrow_back,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ),
                                Text(
                                  AppTexts.doctors,
                                  style: TextStyle(
                                    fontSize:
                                        AppDecoration().screenWidth * 0.07,
                                    color: AppColors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppDecoration.cairo,
                                    height: 2.2,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Filters',
                                  style: TextStyle(
                                    fontSize:
                                        AppDecoration().screenWidth * 0.05,
                                    color: AppColors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppDecoration.cairo,
                                    height: 2.5,
                                  ),
                                ),
                                GetBuilder<SearchCon>(
                                  builder: (controller) => IconButton(
                                    onPressed: () {
                                      controller.filterOpen();
                                    },
                                    icon: Icon(
                                      controller.specialityFilters.isEmpty
                                          ? Icons.filter_alt_outlined
                                          : Icons.filter_alt,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: AppDecoration().screenHeight * 0.02),
                    const DoctorSearchBar(),
                    SizedBox(height: AppDecoration().screenHeight * 0.02),
                    const DoctorsList(),
                  ],
                ),
              ),
              const SearchFilter(),
            ],
          ),
 */