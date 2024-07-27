import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/main_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/screens/labs/tests/test_details_screen.dart';
import 'package:teleprac/view/widgets/lab_screen/tests_screen/test_options.dart';
import 'package:teleprac/view/widgets/pharmacies/pharmacy_products/product_image.dart';

class LastActivity extends StatelessWidget {
  const LastActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        if (controller.lastViewingType != null) {
          if (controller.lastViewingType == 'product') {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: AppDecoration().screenWidth * 0.8,
                    child: Text(
                      'Want to continue? Where you left:',
                      style: TextStyle(
                        fontSize: AppDecoration().screenWidth * 0.045,
                      ),
                    ),
                  ),
                ),
                IntrinsicHeight(
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 8,
                      top: 8,
                      right: 8,
                      bottom: 20,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.secondaryColor,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          controller.lastActivityProductDetails();
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Hero(
                                    tag: controller.savedProductModel!.id!,
                                    child: ProductImage(
                                      imageUrl: controller
                                          .savedProductModel!.savedImage!,
                                    ),
                                  ),
                                ),
                                if (controller.savedProductModel!.discount
                                            .toString()
                                            .removeAllWhitespace !=
                                        '0' &&
                                    controller.savedProductModel!.discount !=
                                        null &&
                                    controller.savedProductModel!.discount!
                                        .isNotEmpty &&
                                    controller.savedProductModel!.discount!
                                        .isNotEmpty &&
                                    controller.savedProductModel!.price !=
                                        controller.savedProductModel!.salePrice)
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(
                                        AppDecoration.discount,
                                        width:
                                            AppDecoration().screenWidth * 0.14,
                                      ),
                                      Text(
                                        '${controller.savedProductModel!.discount}%\noff',
                                        style: TextStyle(
                                          fontSize:
                                              AppDecoration().screenWidth *
                                                  0.035,
                                          color: AppColors.secondaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                            FittedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: AppDecoration().screenWidth * 0.5,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8, 15, 8, 0),
                                      child: Text(
                                        controller.savedProductModel!.name!,
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontSize:
                                              AppDecoration().screenWidth *
                                                  0.05,
                                          fontFamily: AppDecoration.cairo,
                                          fontWeight: FontWeight.bold,
                                          height: 1.2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppDecoration().screenWidth * 0.5,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8, 15, 8, 0),
                                      child: Text(
                                        controller.savedProductModel!
                                                    .medicineType ==
                                                '1'
                                            ? "Prescription Requried"
                                            : "Prescription Not Requried",
                                        style: TextStyle(
                                          color: AppColors.red,
                                          fontSize:
                                              AppDecoration().screenWidth *
                                                  0.035,
                                          fontFamily: AppDecoration.cairo,
                                          fontWeight: FontWeight.bold,
                                          height: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppDecoration().screenWidth * 0.5,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 2, 8, 0),
                                      child: Text(
                                        controller.savedProductModel!
                                                    .manufacturedBy!.length >=
                                                10
                                            ? '${controller.savedProductModel!.manufacturedBy!.substring(0, 10)}..'
                                            : controller.savedProductModel!
                                                .manufacturedBy!,
                                        style: TextStyle(
                                          color: AppColors.blue,
                                          fontSize:
                                              AppDecoration().screenWidth *
                                                  0.04,
                                          fontFamily: AppDecoration.cairo,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppDecoration().screenWidth * 0.5,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                      child: Text(
                                        controller.savedProductModel!
                                                    .composition !=
                                                null
                                            ? controller.savedProductModel!
                                                        .composition!.length >=
                                                    35
                                                ? '${controller.savedProductModel!.composition!.substring(0, 35)}..'
                                                : controller.savedProductModel!
                                                    .composition!
                                            : '',
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontSize:
                                              AppDecoration().screenWidth *
                                                  0.03,
                                          fontFamily: AppDecoration.cairo,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        if (controller.savedProductModel!
                                                    .discount ==
                                                '0' ||
                                            controller.savedProductModel!
                                                    .discount ==
                                                null ||
                                            controller.savedProductModel!
                                                .discount!.isEmpty ||
                                            controller
                                                    .savedProductModel!.price ==
                                                controller.savedProductModel!
                                                    .salePrice)
                                          SizedBox(
                                            width: AppDecoration().screenWidth *
                                                0.5,
                                            child: Text(
                                              'Price : ${AppTexts.indianRupee} ${controller.savedProductModel!.price}',
                                              style: TextStyle(
                                                fontSize: AppDecoration()
                                                        .screenWidth *
                                                    0.045,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        if (controller.savedProductModel!
                                                    .discount !=
                                                '0' &&
                                            controller.savedProductModel!
                                                    .discount !=
                                                null &&
                                            controller.savedProductModel!
                                                .discount!.isNotEmpty &&
                                            controller
                                                    .savedProductModel!.price !=
                                                controller.savedProductModel!
                                                    .salePrice)
                                          Row(
                                            children: [
                                              Text(
                                                'Price : ${AppTexts.indianRupee} ',
                                                style: TextStyle(
                                                  fontSize: AppDecoration()
                                                          .screenWidth *
                                                      0.045,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Container(
                                                constraints: BoxConstraints(
                                                  maxWidth: AppDecoration()
                                                          .screenWidth *
                                                      0.2,
                                                  maxHeight: AppDecoration()
                                                          .screenHeight *
                                                      0.03,
                                                ),
                                                child: Text(
                                                  controller.savedProductModel!
                                                      .price!,
                                                  style: TextStyle(
                                                    fontSize: AppDecoration()
                                                            .screenWidth *
                                                        0.035,
                                                    fontWeight: FontWeight.w500,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    decorationThickness: 2.5,
                                                    height: 0.5,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                constraints: BoxConstraints(
                                                  maxWidth: AppDecoration()
                                                          .screenWidth *
                                                      0.3,
                                                  maxHeight: AppDecoration()
                                                          .screenHeight *
                                                      0.03,
                                                ),
                                                child: Text(
                                                  controller.savedProductModel!
                                                      .salePrice!,
                                                  style: TextStyle(
                                                    fontSize: AppDecoration()
                                                            .screenWidth *
                                                        0.05,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (controller.lastViewingType == 'test') {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: AppDecoration().screenWidth * 0.8,
                    child: Text(
                      'Want to continue? Where you left:',
                      style: TextStyle(
                        fontSize: AppDecoration().screenWidth * 0.045,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 8,
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.secondaryColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.savedTestModel!.testDetails!
                                        .labTestName!,
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppDecoration.cairo,
                                      fontSize:
                                          AppDecoration().screenWidth * 0.045,
                                    ),
                                  ),
                                  SizedBox(
                                    height: AppDecoration().screenHeight * 0.02,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'LAB: ',
                                          style: TextStyle(
                                            color: AppColors.red,
                                            fontWeight: FontWeight.w400,
                                            fontSize:
                                                AppDecoration().screenWidth *
                                                    0.04,
                                          ),
                                        ),
                                        TextSpan(
                                          text: controller.savedTestModel!
                                              .labDetails!.fullName!,
                                          style: TextStyle(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize:
                                                AppDecoration().screenWidth *
                                                    0.04,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              if (controller.savedTestModel!.testDetails!
                                          .discount !=
                                      '0' &&
                                  controller.savedTestModel!.testDetails!
                                          .discount !=
                                      null &&
                                  controller.savedTestModel!.testDetails!
                                      .discount!.isNotEmpty)
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      AppDecoration.discount,
                                      width: AppDecoration().screenWidth * 0.14,
                                    ),
                                    Text(
                                      '${controller.savedTestModel!.testDetails!.discount}%\noff',
                                      style: TextStyle(
                                        fontSize:
                                            AppDecoration().screenWidth * 0.04,
                                        color: AppColors.secondaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                      // SizedBox(height: AppDecoration().screenHeight * 0.02),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Divider(
                          thickness: 1.2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            if (controller
                                        .savedTestModel!.testDetails!.discount ==
                                    '0' ||
                                controller.savedTestModel!.testDetails!
                                        .discount ==
                                    null ||
                                controller.savedTestModel!.testDetails!
                                    .discount!.isEmpty)
                              SizedBox(
                                width: AppDecoration().screenWidth * 0.5,
                                child: Text(
                                  'Total Price : ${AppTexts.indianRupee} ${controller.savedTestModel!.testDetails!.amount}',
                                  style: TextStyle(
                                    fontSize:
                                        AppDecoration().screenWidth * 0.045,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppDecoration.cairo,
                                  ),
                                ),
                              ),
                            if (controller
                                        .savedTestModel!.testDetails!.discount !=
                                    '0' &&
                                controller.savedTestModel!.testDetails!
                                        .discount !=
                                    null &&
                                controller.savedTestModel!.testDetails!
                                    .discount!.isNotEmpty)
                              Row(
                                children: [
                                  Text(
                                    'Total Price : ${AppTexts.indianRupee} ',
                                    style: TextStyle(
                                      fontSize:
                                          AppDecoration().screenWidth * 0.045,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppDecoration.cairo,
                                    ),
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          AppDecoration().screenWidth * 0.2,
                                      maxHeight:
                                          AppDecoration().screenHeight * 0.03,
                                    ),
                                    child: Text(
                                      controller
                                          .savedTestModel!.testDetails!.mrp!,
                                      style: TextStyle(
                                        fontSize:
                                            AppDecoration().screenWidth * 0.04,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.lineThrough,
                                        decorationThickness: 2.5,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          AppDecoration().screenWidth * 0.3,
                                      maxHeight:
                                          AppDecoration().screenHeight * 0.03,
                                    ),
                                    margin: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      controller
                                          .savedTestModel!.testDetails!.amount!,
                                      style: TextStyle(
                                        fontSize:
                                            AppDecoration().screenWidth * 0.05,
                                        fontWeight: FontWeight.w500,
                                        height: 1.5,
                                        fontFamily: AppDecoration.cairo,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      TestOptions(
                        buttonColor: AppColors.primaryColor,
                        details: () {
                          Get.to(
                            () => TestDetailsScreen(
                              advancedTestModel: controller.savedTestModel!,
                            ),
                            transition: Transition.downToUp,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
