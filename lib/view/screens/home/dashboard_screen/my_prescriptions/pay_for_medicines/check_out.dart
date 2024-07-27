import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard/pay_for_medicines_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/model/home/dashboard/custom_product_model.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';
import 'package:teleprac/view/widgets/pharmacies/pharmacy_products/product_image.dart';

class PayForMedicinesCheckoutPreview extends StatelessWidget {
  const PayForMedicinesCheckoutPreview({super.key});

  @override
  Widget build(BuildContext context) {
    PayForMedicinesController controller = Get.put(PayForMedicinesController());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: SafeArea(
        child: Column(
          children: [
            const UpperPart(
              text: 'Pay For Medcicines',
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.02),
            Expanded(
              child: ListView.builder(
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  CustomProductModel customProductModel =
                      CustomProductModel.fromJson(
                    controller.products[index],
                  );

                  return Container(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: ProductImage(
                            imageUrl: customProductModel.image,
                            width: 0.1,
                            height: 0.1,
                          ),
                        ),
                        SizedBox(width: AppDecoration().screenWidth * 0.05),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                                child: Text(
                                  customProductModel.name!,
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize:
                                        AppDecoration().screenWidth * 0.05,
                                    fontFamily: AppDecoration.cairo,
                                    fontWeight: FontWeight.w500,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Price : ${AppTexts.indianRupee} ${customProductModel.price!}',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize:
                                        AppDecoration().screenWidth * 0.05,
                                    fontFamily: AppDecoration.cairo,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.02),
            Container(
              padding: const EdgeInsets.all(20),
              color: AppColors.secondaryColor,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Price',
                        style: TextStyle(
                          fontFamily: AppDecoration.cairo,
                          fontSize: AppDecoration().screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: AppDecoration().screenWidth * 0.5,
                        ),
                        child: Text(
                          '${AppTexts.indianRupee} ${controller.totalPrice}',
                          style: TextStyle(
                            fontFamily: AppDecoration.cairo,
                            fontSize: AppDecoration().screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppDecoration().screenHeight * 0.05),
                  CustomButton(
                    function: () {
                      controller.checkout();
                    },
                    textColor: AppColors.secondaryColor,
                    buttonColor: AppColors.primaryColor,
                    text: 'Checkout',
                    circularRadius: 10,
                    margin: const EdgeInsets.only(left: 5, right: 5),
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
