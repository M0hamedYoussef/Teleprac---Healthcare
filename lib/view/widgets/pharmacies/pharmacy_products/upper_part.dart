// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:teleprac/controller/pharmacies/pharmacies_controller.dart';
// import 'package:teleprac/controller/search_con.dart';
// import 'package:teleprac/core/const/colors.dart';
// import 'package:teleprac/core/const/decoration.dart';
// import 'package:teleprac/core/const/texts.dart';

// class UpperPart extends StatelessWidget {
//   const UpperPart({super.key});

//   @override
//   Widget build(BuildContext context) {
//     PharmaciesController controller = Get.find();
//     return Container(
//       decoration: const BoxDecoration(
//         // gradient: AppColors.mainLinarGradient,
//         color: AppColors.primaryColor,
//       ),
//       width: AppDecoration().screenWidth,
//       child: Padding(
//         padding: const EdgeInsets.only(left: 8, right: 8),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     if (!controller.pharmacySelected) {
//                       SystemChrome.setSystemUIOverlayStyle(
//                         const SystemUiOverlayStyle(
//                           statusBarColor: AppColors.lightGrey1,
//                           statusBarIconBrightness: Brightness.light,
//                         ),
//                       );
//                     }
//                     Get.back();
//                   },
//                   icon: const Icon(
//                     CupertinoIcons.back,
//                     color: AppColors.secondaryColor,
//                     size: 40,
//                   ),
//                 ),
//                 Text(
//                   AppTexts.onlinePharmacyLabel,
//                   style: TextStyle(
//                     fontSize: AppDecoration().screenWidth * 0.07,
//                     color: AppColors.secondaryColor,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: AppDecoration.cairo,
//                     height: 2.2,
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 const Text(
//                   'Filters',
//                   style: TextStyle(
//                     fontSize: 15,
//                     color: AppColors.secondaryColor,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: AppDecoration.cairo,
//                     height: 2.5,
//                   ),
//                 ),
//                 GetBuilder<SearchCon>(
//                   builder: (controller) => IconButton(
//                     onPressed: () {
//                       controller.filterOpen();
//                     },
//                     icon: Icon(
//                       controller.filteredSubCategories.isEmpty
//                           ? Icons.filter_alt_outlined
//                           : Icons.filter_alt,
//                       color: AppColors.secondaryColor,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
