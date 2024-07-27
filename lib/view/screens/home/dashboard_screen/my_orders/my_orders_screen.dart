import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:teleprac/controller/home/dashboard/my_orders_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/model/home/dashboard/orders/order_model.dart';
import 'package:teleprac/view/screens/global/image_view_screen.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyOrdersController controller = Get.put(MyOrdersController());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: SafeArea(
        child: Column(
          children: [
            const UpperPart(
              text: AppTexts.myOrders,
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.02),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemCount: controller.myOrders.length,
                itemBuilder: (context, index) {
                  OrderModel orderModel =
                      OrderModel.fromJson(controller.myOrders[index]);
                  return Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.secondaryColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Order ID: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppDecoration.cairo,
                                  fontSize: AppDecoration().screenWidth * 0.045,
                                  color: AppColors.black,
                                ),
                              ),
                              TextSpan(
                                text: orderModel.orderUserDetailsId!,
                                style: TextStyle(
                                  fontFamily: AppDecoration.cairo,
                                  fontWeight: FontWeight.w400,
                                  fontSize: AppDecoration().screenWidth * 0.045,
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (orderModel.phoneno != null)
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Phone Number: ',
                                  style: TextStyle(
                                    fontFamily: AppDecoration.cairo,
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        AppDecoration().screenWidth * 0.045,
                                    color: AppColors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: '+91 ',
                                  style: TextStyle(
                                    fontFamily: AppDecoration.cairo,
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        AppDecoration().screenWidth * 0.045,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                TextSpan(
                                  text: orderModel.phoneno!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: AppDecoration.cairo,
                                    fontSize:
                                        AppDecoration().screenWidth * 0.045,
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (orderModel.pharmacyName != null)
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Pharmacy Name: ',
                                  style: TextStyle(
                                    fontFamily: AppDecoration.cairo,
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        AppDecoration().screenWidth * 0.045,
                                    color: AppColors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: orderModel.pharmacyName!,
                                  style: TextStyle(
                                    fontFamily: AppDecoration.cairo,
                                    fontWeight: FontWeight.w400,
                                    fontSize:
                                        AppDecoration().screenWidth * 0.045,
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (orderModel.prescriptionImage != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Prescription Image:',
                                  style: TextStyle(
                                    fontFamily: AppDecoration.cairo,
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        AppDecoration().screenWidth * 0.045,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => ImageViewScreen(
                                      imageUrl: orderModel.prescriptionImage!,
                                      appBarTitle: 'Prescription Image',
                                    ),
                                    transition: Transition.downToUp,
                                  );
                                },
                                child: const Icon(
                                  Icons.open_in_new,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Order Date: ',
                                style: TextStyle(
                                    fontFamily: AppDecoration.cairo,
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        AppDecoration().screenWidth * 0.045,
                                    color: AppColors.black),
                              ),
                              TextSpan(
                                text: Jiffy(orderModel.createdAt!).yMMMEd,
                                style: TextStyle(
                                  fontFamily: AppDecoration.cairo,
                                  fontWeight: FontWeight.w400,
                                  fontSize: AppDecoration().screenWidth * 0.045,
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Order Price: ${AppTexts.indianRupee}',
                                style: TextStyle(
                                    fontFamily: AppDecoration.cairo,
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        AppDecoration().screenWidth * 0.045,
                                    color: AppColors.black),
                              ),
                              TextSpan(
                                text: orderModel.totalAmount!,
                                style: TextStyle(
                                  fontFamily: AppDecoration.cairo,
                                  fontWeight: FontWeight.w400,
                                  fontSize: AppDecoration().screenWidth * 0.045,
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: AppDecoration().screenHeight * 0.01),
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                function: () {
                                  controller.trackOrder(orderModel: orderModel);
                                },
                                margin: null,
                                buttonColor: AppColors.primaryColor,
                                text: 'Track',
                              ),
                            ),
                            SizedBox(width: AppDecoration().screenWidth * 0.01),
                            Expanded(
                              child: CustomButton(
                                function: () {
                                  controller.viewOrder(orderModel: orderModel);
                                },
                                margin: null,
                                text: 'View',
                                buttonColor: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
