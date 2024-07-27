import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/pharmacies/product_details_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/global/custom_container.dart';
import 'package:teleprac/view/widgets/global/shimmer_placeholder.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    ProductDetailsController controller = Get.put(ProductDetailsController());
    return Scaffold(
      body: WillPopScope(
        onWillPop: controller.willPop,
        child: CustomContainer(
          listView: false,
          margin: null,
          height: 1,
          children: [
            const UpperPart(
              text: AppTexts.productDetails,
            ),
            CustomContainer(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              height: 0.75,
              children: [
                Stack(
                  children: [
                    Hero(
                      tag: controller.productModel.id!,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          imageUrl: controller.productModel.uploadImageUrl ??
                              controller.productModel.savedImage!,
                          errorWidget: (context, url, error) {
                            return const SizedBox();
                          },
                          placeholder: (context, _) {
                            return const CustomShimmerPlaceHolder(
                              margin: null,
                            );
                          },
                          width: AppDecoration().screenWidth,
                          height: AppDecoration().screenHeight * 0.3,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    if (controller.productModel.discount
                                .toString()
                                .removeAllWhitespace !=
                            '0' &&
                        controller.productModel.discount != null &&
                        controller.productModel.discount!.isNotEmpty &&
                        controller.productModel.price !=
                            controller.productModel.salePrice)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              AppDecoration.discount,
                              width: AppDecoration().screenWidth * 0.14,
                            ),
                            Text(
                              '${controller.productModel.discount}%\noff',
                              style: TextStyle(
                                fontSize: AppDecoration().screenWidth * 0.037,
                                color: AppColors.secondaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: AppDecoration().screenWidth * 0.6,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 15, 8, 0),
                        child: Text(
                          controller.productModel.medicineType == '1'
                              ? "Prescription Requried"
                              : "Prescription Not Requried",
                          style: TextStyle(
                            color: AppColors.red,
                            fontSize: AppDecoration().screenWidth * 0.05,
                            fontFamily: AppDecoration.cairo,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 15, 8, 0),
                      child: Text(
                        controller.productModel.name!,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: AppDecoration().screenWidth * 0.08,
                          fontFamily: AppDecoration.cairo,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
                      child: Text(
                        controller.productModel.manufacturedBy!.length >= 10
                            ? controller.productModel.manufacturedBy!
                            : controller.productModel.manufacturedBy!,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: AppDecoration().screenWidth * 0.04,
                          fontFamily: AppDecoration.cairo,
                          fontWeight: FontWeight.bold,
                          decorationStyle: TextDecorationStyle.wavy,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Text(
                        controller.productModel.composition ?? '',
                        style: TextStyle(
                          color: AppColors.black.withOpacity(0.8),
                          fontSize: AppDecoration().screenWidth * 0.05,
                          fontFamily: AppDecoration.cairo,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Text(
                      (controller.productModel.shortDescription != null &&
                              controller.productModel.shortDescription
                                  .toString()
                                  .isNotEmpty)
                          ? 'Description'
                          : '',
                      style: TextStyle(
                        fontSize: AppDecoration().screenWidth * 0.08,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                        fontFamily: AppDecoration.cairo,
                        height: 1.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: Text(
                        controller.productModel.shortDescription != null
                            ? controller.productModel.shortDescription!.trim()
                            : '',
                        style: TextStyle(
                          color: AppColors.black.withOpacity(0.8),
                          fontWeight: FontWeight.w300,
                          fontSize: AppDecoration().screenWidth * .05,
                          wordSpacing: 2,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (controller.productModel.discount == '0' ||
                          controller.productModel.discount == null ||
                          controller.productModel.discount!.isEmpty ||
                          controller.productModel.price ==
                              controller.productModel.salePrice)
                        SizedBox(
                          width: AppDecoration().screenWidth * 0.5,
                          child: Text(
                            'Price : ${AppTexts.indianRupee} ${controller.productModel.price}',
                            style: TextStyle(
                              fontSize: AppDecoration().screenWidth * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      if (controller.productModel.discount != '0' &&
                          controller.productModel.discount != null &&
                          controller.productModel.discount!.isNotEmpty &&
                          controller.productModel.discount!.isNotEmpty &&
                          controller.productModel.price !=
                              controller.productModel.salePrice)
                        Row(
                          children: [
                            Text(
                              'Price : ${AppTexts.indianRupee} ',
                              style: TextStyle(
                                fontSize: AppDecoration().screenWidth * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: AppDecoration().screenWidth * 0.2,
                                maxHeight: AppDecoration().screenHeight * 0.03,
                              ),
                              child: Text(
                                controller.productModel.price!,
                                style: TextStyle(
                                  fontSize: AppDecoration().screenWidth * 0.035,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.lineThrough,
                                  decorationThickness: 2.5,
                                  height: 0.5,
                                ),
                              ),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: AppDecoration().screenWidth * 0.3,
                                maxHeight: AppDecoration().screenHeight * 0.03,
                              ),
                              child: Text(
                                controller.productModel.salePrice!,
                                style: TextStyle(
                                  fontSize: AppDecoration().screenWidth * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  SizedBox(height: AppDecoration().screenHeight * .005),
                  GetBuilder<ProductDetailsController>(
                    builder: (_) {
                      bool inCart = controller.cartProducts
                          .contains(controller.productModel.id);

                      return CustomButton(
                        function: () {
                          if (inCart) {
                            controller.removeFromCart();
                          } else {
                            controller.addToCart();
                          }
                        },
                        text: inCart ? 'Remove From Cart' : 'Add To Cart',
                        buttonColor: AppColors.primaryColor,
                        width: .9,
                        height: .05,
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        circularRadius: 10,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
