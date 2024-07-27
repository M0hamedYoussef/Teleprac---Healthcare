import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/model/home/dashboard/invoice/advanced_invoice_model.dart';
import 'package:teleprac/view/widgets/global/custom_container.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class InvoiceDetailsScreen extends StatelessWidget {
  const InvoiceDetailsScreen({super.key, required this.advancedInvoiceModel});
  final AdvancedInvoiceModel advancedInvoiceModel;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: CustomContainer(
        margin: null,
        height: 1,
        children: [
          const UpperPart(
            text: AppTexts.invoiceDetails,
          ),
          Container(
            color: AppColors.primaryColor,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        advancedInvoiceModel.invoiceList![0].patientName!,
                        style: TextStyle(
                          fontSize: AppDecoration().screenWidth * 0.04,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: AppDecoration().screenHeight * 0.01),
                    SizedBox(
                      width: AppDecoration().screenWidth * 0.5,
                      child: Text(
                        advancedInvoiceModel.invoiceList![0].userFullAddress!,
                        style: TextStyle(
                          fontSize: AppDecoration().screenWidth * 0.035,
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
                        'Details',
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
                        advancedInvoiceModel.invoiceList![0].doctorName ?? '',
                        style: TextStyle(
                          fontSize: AppDecoration().screenWidth * 0.04,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: AppDecoration().screenHeight * 0.01),
                    SizedBox(
                      width: AppDecoration().screenWidth * 0.4,
                      child: Text(
                        advancedInvoiceModel.invoiceList![0].pharFullAddress!,
                        style: TextStyle(
                          fontSize: AppDecoration().screenWidth * 0.035,
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
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Date :',
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Text(
                    advancedInvoiceModel.createdDate!,
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppDecoration().screenHeight * 0.01),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Invoice Number :',
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Text(
                    advancedInvoiceModel.invoiceList![0].invoiceNo!,
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppDecoration().screenHeight * 0.01),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Payment Method :',
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Text(
                    advancedInvoiceModel.invoiceList![0].paymentType!,
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppDecoration().screenHeight * 0.01),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Total Amount:',
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Text(
                    '${AppTexts.indianRupee}${advancedInvoiceModel.userTotalAmount!}',
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                  flex: 4,
                  child: Text(
                    'Description',
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.04,
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Total',
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
                if (advancedInvoiceModel.appoinmentDetails != null &&
                        advancedInvoiceModel.appoinmentDetails!.isEmpty ||
                    advancedInvoiceModel.appoinmentDetails == null)
                  Center(
                    child: Text(
                      'No Appointments Found',
                      style: TextStyle(
                        fontSize: AppDecoration().screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ...List.generate(
                  (advancedInvoiceModel.appoinmentDetails != null &&
                              advancedInvoiceModel.appoinmentDetails!.isEmpty ||
                          advancedInvoiceModel.appoinmentDetails == null)
                      ? 0
                      : advancedInvoiceModel.appoinmentDetails!.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  advancedInvoiceModel
                                          .appoinmentDetails![index].typeText ??
                                      '',
                                  style: TextStyle(
                                    fontSize:
                                        AppDecoration().screenWidth * 0.04,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 0,
                                child: Text(
                                  advancedInvoiceModel
                                          .appoinmentDetails![index].amount ??
                                      '',
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
                          if (advancedInvoiceModel.appoinmentDetails != null &&
                              advancedInvoiceModel.appoinmentDetails!.length !=
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
        ],
      ),
    );
  }
}
