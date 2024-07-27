import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/model/pharmacies/product_model.dart';
import 'package:teleprac/view/widgets/pharmacies/pharmacy_products/product_image.dart';

class MyProductContainer extends StatelessWidget {
  const MyProductContainer({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        margin: const EdgeInsets.only(
          left: 8,
          right: 8,
          bottom: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.secondaryColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: productModel.id!,
                    child: ProductImage(
                      imageUrl: productModel.uploadImageUrl!,
                    ),
                  ),
                ),
                if (productModel.discount.toString().removeAllWhitespace !=
                        '0' &&
                    productModel.discount != null &&
                    productModel.discount!.isNotEmpty &&
                    productModel.discount!.isNotEmpty &&
                    productModel.price != productModel.salePrice)
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        AppDecoration.discount,
                        width: AppDecoration().screenWidth * 0.14,
                      ),
                      Text(
                        '${productModel.discount}%\noff',
                        style: const TextStyle(
                          fontSize: 15,
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
                      padding: const EdgeInsets.fromLTRB(8, 15, 8, 0),
                      child: Text(
                        productModel.name!,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: AppDecoration().screenWidth * 0.05,
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
                      padding: const EdgeInsets.fromLTRB(8, 15, 8, 0),
                      child: Text(
                        productModel.medicineType == '1'
                            ? "Prescription Requried"
                            : "Prescription Not Requried",
                        style: TextStyle(
                          color: AppColors.red,
                          fontSize: AppDecoration().screenWidth * 0.035,
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
                      padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
                      child: Text(
                        productModel.manufacturedBy!.length >= 10
                            ? '${productModel.manufacturedBy!.substring(0, 10)}..'
                            : productModel.manufacturedBy!,
                        style: TextStyle(
                          color: AppColors.blue,
                          fontSize: AppDecoration().screenWidth * 0.04,
                          fontFamily: AppDecoration.cairo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: AppDecoration().screenWidth * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Text(
                        productModel.composition != null
                            ? productModel.composition!.length >= 35
                                ? '${productModel.composition!.substring(0, 35)}..'
                                : productModel.composition!
                            : '',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: AppDecoration().screenWidth * 0.03,
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
                        if (productModel.discount == '0' ||
                            productModel.discount == null ||
                            productModel.discount!.isEmpty ||
                            productModel.price == productModel.salePrice)
                          SizedBox(
                            width: AppDecoration().screenWidth * 0.5,
                            child: Text(
                              'Price : ${AppTexts.indianRupee} ${productModel.price}',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        if (productModel.discount != '0' &&
                            productModel.discount != null &&
                            productModel.discount!.isNotEmpty &&
                            productModel.price != productModel.salePrice)
                          Row(
                            children: [
                              const Text(
                                'Price : ${AppTexts.indianRupee} ',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth: AppDecoration().screenWidth * 0.2,
                                  maxHeight:
                                      AppDecoration().screenHeight * 0.03,
                                ),
                                child: Text(
                                  productModel.price!,
                                  style: const TextStyle(
                                    fontSize: 12,
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
                                  maxHeight:
                                      AppDecoration().screenHeight * 0.03,
                                ),
                                child: Text(
                                  productModel.salePrice!,
                                  style: const TextStyle(
                                    fontSize: 20,
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
    );
  }
}
