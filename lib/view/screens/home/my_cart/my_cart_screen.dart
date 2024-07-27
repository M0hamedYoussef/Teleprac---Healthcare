import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/cart/my_cart_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/home/my_cart/cart_screen/products_list.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyCartController controller = Get.put(MyCartController());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: WillPopScope(
        onWillPop: controller.willPop,
        child: SafeArea(
          child: Column(
            children: [
              const UpperPart(
                text: AppTexts.cart,
                changeStatusbarColor: true,
              ),
              SizedBox(height: AppDecoration().screenHeight * 0.02),
              const CartProductsList(),
              SizedBox(height: AppDecoration().screenHeight * 0.02),
              GetBuilder<MyCartController>(
                builder: (_) {
                  if (controller.cartProducts.isNotEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      color: AppColors.secondaryColor,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Discount',
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
                                  '${AppTexts.indianRupee} ${controller.discount}',
                                  style: TextStyle(
                                    fontFamily: AppDecoration.cairo,
                                    fontSize:
                                        AppDecoration().screenWidth * 0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                                    fontSize:
                                        AppDecoration().screenWidth * 0.05,
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
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
