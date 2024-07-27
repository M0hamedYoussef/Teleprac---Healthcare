import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/model/home/dashboard/orders/advanced_order_model.dart';
import 'package:teleprac/model/home/dashboard/orders/order_model.dart';
import 'package:teleprac/model/home/dashboard/orders/track_order_model.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_orders/order_details.dart';

class MyOrdersController extends GetxController {
  late List myOrders;
  Crud crud = Crud();

  @override
  void onInit() {
    myOrders = Get.arguments['ordersList'];
    super.onInit();
  }

  viewOrder({required OrderModel orderModel}) async {
    loading();
    var res = await orderViewRequest(orderModel: orderModel);
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        AdvancedOrderModel advancedOrderModel =
            AdvancedOrderModel.fromJson(responseModel.data);
        Get.off(
          () => OrderDetailsScreen(
            advancedOrderModel: advancedOrderModel,
          ),
          transition: Transition.downToUp,
        );
      } else {
        Get.back();
        Fluttertoast.showToast(
          msg: 'Something Went Wrong',
          textColor: AppColors.black,
          backgroundColor: AppColors.secondaryColor,
        );
      }
    }
  }

  trackOrder({required OrderModel orderModel}) async {
    loading();
    var res = await orderViewRequest(orderModel: orderModel);
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        AdvancedOrderModel advancedOrderModel =
            AdvancedOrderModel.fromJson(responseModel.data);
        String orderID = advancedOrderModel.orderDetails![0].orderId!;
        var trackOrderRes = await trackOrderRequest(
          id: orderID,
        );

        if (trackOrderRes is RequsetStatus == false) {
          ResponseModel trackOrderResponseModel =
              ResponseModel.fromJson(trackOrderRes);
          TrackOrderModel trackOrderModel =
              TrackOrderModel.fromJson(trackOrderResponseModel.ordersList![0]);
          Get.back();
          Get.defaultDialog(
              title: 'Order Track',
              titleStyle: TextStyle(
                fontSize: AppDecoration().screenWidth * 0.08,
                fontFamily: AppDecoration.cairo,
                color: AppColors.primaryColor,
              ),
              contentPadding: EdgeInsets.zero,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order ID : $orderID',
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.05,
                      fontFamily: AppDecoration.cairo,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: AppDecoration().screenHeight * 0.01),
                  Text(
                    'Order Status : ${trackOrderModel.orderStatus.toString().capitalizeFirst}',
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.05,
                      fontFamily: AppDecoration.cairo,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: AppDecoration().screenHeight * 0.01),
                  Text(
                    'Payment Method : ${trackOrderModel.paymentType}',
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.05,
                      fontFamily: AppDecoration.cairo,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: AppDecoration().screenHeight * 0.01),
                  Text(
                    'Pharmacy Name : ${trackOrderModel.pharmacyName}',
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.05,
                      fontFamily: AppDecoration.cairo,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Get.back();
                  },
                  color: AppColors.primaryColor,
                  child: Text(
                    'Ok',
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: AppDecoration().screenWidth * 0.05,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppDecoration.cairo,
                    ),
                  ),
                ),
              ]);
        }
      } else {
        Get.back();
        Fluttertoast.showToast(
          msg: 'Something Went Wrong',
          textColor: AppColors.black,
          backgroundColor: AppColors.secondaryColor,
        );
      }
    }
  }

  orderViewRequest({
    required OrderModel orderModel,
  }) async {
    var res = await crud.connect(
      link: AppLinks.orderDetails,
      data: {
        'order_id': orderModel.orderUserDetailsId!,
      },
      headers: {
        'token': AppLinks.token,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  trackOrderRequest({required String id}) async {
    var res = await crud.connect(
      link: AppLinks.orderTrack,
      data: {
        'order_id': id,
      },
      headers: {
        'token': AppLinks.token,
      },
    );
    return res.fold((l) => l, (r) => r);
  }
}
