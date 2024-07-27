import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/model/home/dashboard/orders/advanced_order_model.dart';
import 'package:teleprac/view/widgets/global/custom_container.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({
    super.key,
    required this.advancedOrderModel,
  });
  final AdvancedOrderModel advancedOrderModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomContainer(
        margin: null,
        height: 1,
        children: [
          const UpperPart(
            text: 'Order Details',
          ),
          Container(
            color: AppColors.primaryColor,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: AppDecoration().screenWidth * 0.5,
                      child: Text(
                        'Patient Details',
                        style: TextStyle(
                          fontSize: AppDecoration().screenWidth * 0.05,
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppDecoration().screenWidth * 0.5,
                      child: Text(
                        advancedOrderModel.userDetails!.fullName!,
                        style: TextStyle(
                          fontSize: AppDecoration().screenWidth * 0.04,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppDecoration().screenWidth * 0.5,
                      child: Text(
                        advancedOrderModel.userDetails!.address1!,
                        style: TextStyle(
                          fontSize: AppDecoration().screenWidth * 0.04,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppDecoration().screenWidth * 0.5,
                      child: Text(
                        advancedOrderModel.userDetails!.address2!,
                        style: TextStyle(
                          fontSize: AppDecoration().screenWidth * 0.04,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      width: AppDecoration().screenWidth * 0.4,
                      child: Text(
                        'Pharmacy Details',
                        style: TextStyle(
                          fontSize: AppDecoration().screenWidth * 0.05,
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppDecoration().screenWidth * 0.4,
                      child: Text(
                        advancedOrderModel.userDetails!.pharmacyName!,
                        style: TextStyle(
                          fontSize: AppDecoration().screenWidth * 0.04,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppDecoration().screenWidth * 0.4,
                      child: Text(
                        advancedOrderModel.userDetails!.userAddress1!,
                        style: TextStyle(
                          fontSize: AppDecoration().screenWidth * 0.04,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppDecoration().screenWidth * 0.4,
                      child: Text(
                        advancedOrderModel.userDetails!.userAddress2!,
                        style: TextStyle(
                          fontSize: AppDecoration().screenWidth * 0.04,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: AppDecoration().screenHeight * 0.01),
          Container(
            color: AppColors.primaryColor,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Drug Name',
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.04,
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: AppDecoration().screenWidth * 0.02),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Quantity',
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.04,
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Price',
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.04,
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8, right: 8),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.black.withOpacity(0.12), width: 2.0),
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                ...List.generate(
                  advancedOrderModel.orderDetails!.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  advancedOrderModel
                                          .orderDetails![index].name ??
                                      '',
                                  style: TextStyle(
                                    fontSize:
                                        AppDecoration().screenWidth * 0.04,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: AppDecoration().screenWidth * 0.05),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  advancedOrderModel
                                          .orderDetails![index].quantity ??
                                      '',
                                  style: TextStyle(
                                    fontSize:
                                        AppDecoration().screenWidth * 0.04,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: AppDecoration().screenWidth * 0.05),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  AppTexts.indianRupee +
                                      advancedOrderModel
                                          .orderDetails![index].subtotal!,
                                  style: TextStyle(
                                    fontSize:
                                        AppDecoration().screenWidth * 0.04,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (advancedOrderModel.orderDetails!.length !=
                              index + 1)
                            const Divider(thickness: 1.6),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: AppDecoration().screenHeight * 0.01),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: AppDecoration().screenWidth * 0.4,
                  child: Text(
                    'Total Amount:',
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: AppDecoration().screenWidth * 0.4,
                  ),
                  child: Text(
                    '${AppTexts.indianRupee}${advancedOrderModel.userDetails!.totalAmount!}',
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
