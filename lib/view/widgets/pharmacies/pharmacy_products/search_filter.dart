// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:teleprac/controller/search_con.dart';
// import 'package:teleprac/core/const/colors.dart';
// import 'package:teleprac/core/const/decoration.dart';
// import 'package:teleprac/model/pharmacies/category_model.dart';

// class CategoriesSearchFilter extends StatelessWidget {
//   const CategoriesSearchFilter({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<SearchCon>(
//       builder: (controller) {
//         return Align(
//           alignment: Alignment.topRight,
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 200),
//             height: AppDecoration().screenHeight * controller.filteringHeight,
//             width: AppDecoration().screenWidth * 0.6,
//             color: AppColors.bg,
//             padding: const EdgeInsets.all(8),
//             child: controller.filteringHeight != 0
//                 ? Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(left: 7),
//                         child: Text(
//                           'Categories Filters',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600,
//                             color: AppColors.black,
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: ListView.builder(
//                           physics: const BouncingScrollPhysics(
//                             parent: AlwaysScrollableScrollPhysics(),
//                           ),
//                           itemCount: controller.pharmaciesCategories.length,
//                           itemBuilder: (context, index) {
//                             CategoryModel categoryModel =
//                                 CategoryModel.fromJson(
//                                     controller.pharmaciesCategories[index]);
//                             bool containsAllSubCategoreis = true;
//                             for (SubCateogory subCategorie
//                                 in categoryModel.subCateogory!) {
//                               if (!controller.filteredSubCategories
//                                   .contains(subCategorie.subCategoryId!)) {
//                                 containsAllSubCategoreis = false;
//                               }
//                             }
//                             bool checked = containsAllSubCategoreis;
//                             // RxBool checked = containsAllSubCategoreis.obs;
//                             return Padding(
//                               padding: const EdgeInsets.only(left: 2),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Obx(
//                                         () => Transform.scale(
//                                           scale: 0.8,
//                                           child: Checkbox(
//                                             value: checked.obs.value,
//                                             checkColor:
//                                                 AppColors.secondaryColor,
//                                             activeColor: AppColors.grey,
//                                             onChanged: (_) {
//                                               controller.checkCategorieFilter(
//                                                 checked: checked,
//                                                 categoryModel: categoryModel,
//                                               );
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                       GestureDetector(
//                                         onTap: () {
//                                           controller.checkCategorieFilter(
//                                             checked: checked,
//                                             categoryModel: categoryModel,
//                                           );
//                                         },
//                                         child: SizedBox(
//                                           width:
//                                               AppDecoration().screenWidth * 0.4,
//                                           child: Text(
//                                             categoryModel.categoryName!,
//                                             style: const TextStyle(
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.w400,
//                                               color: AppColors.blackLighted,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   ...List.generate(
//                                       categoryModel.subCateogory!.length,
//                                       (subIndex) {
//                                     RxBool subChecked = controller
//                                         .filteredSubCategories
//                                         .contains(categoryModel
//                                             .subCateogory![subIndex]
//                                             .subCategoryId)
//                                         .obs;

//                                     return Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Row(
//                                         children: [
//                                           Obx(
//                                             () => Transform.scale(
//                                               scale: 0.5,
//                                               child: Checkbox(
//                                                 value: subChecked.value,
//                                                 checkColor:
//                                                     AppColors.secondaryColor,
//                                                 activeColor: AppColors.grey,
//                                                 onChanged: (_) {
//                                                   controller
//                                                       .checkSubCategorieFilter(
//                                                     checked: subChecked,
//                                                     subCateogory: categoryModel
//                                                             .subCateogory![
//                                                         subIndex],
//                                                   );
//                                                 },
//                                               ),
//                                             ),
//                                           ),
//                                           GestureDetector(
//                                             onTap: () {
//                                               controller
//                                                   .checkSubCategorieFilter(
//                                                 checked: subChecked,
//                                                 subCateogory: categoryModel
//                                                     .subCateogory![subIndex],
//                                               );
//                                             },
//                                             child: SizedBox(
//                                               width:
//                                                   AppDecoration().screenWidth *
//                                                       0.3,
//                                               child: Text(
//                                                 categoryModel
//                                                     .subCateogory![subIndex]
//                                                     .subCategoryName!,
//                                                 style: const TextStyle(
//                                                   fontSize: 15,
//                                                   fontWeight: FontWeight.w400,
//                                                   color: AppColors.blackLighted,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   }),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   )
//                 : const SizedBox(),
//           ),
//         );
//       },
//     );
//   }
// }
