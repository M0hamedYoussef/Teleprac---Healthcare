import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard/my_invoices_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/model/home/dashboard/invoice/invoice_model.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';
import 'package:teleprac/view/widgets/global/user_image.dart';

class MyInvoicesScreen extends StatelessWidget {
  const MyInvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyInvoicesController controller = Get.put(MyInvoicesController());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: SafeArea(
        child: Column(
          children: [
            const UpperPart(
              text: AppTexts.myInvoices,
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.02),
            Expanded(
              child: ListView.builder(
                itemCount: controller.myInvoices.length,
                physics:
                    const BouncingScrollPhysics(parent: PageScrollPhysics()),
                itemBuilder: (context, index) {
                  InvoiceModel invoiceModel =
                      InvoiceModel.fromJson(controller.myInvoices[index]);

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.secondaryColor,
                    ),
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            UserImage(
                              image: invoiceModel.profile!,
                              withGradient: false,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: AppDecoration().screenWidth * 0.5,
                                  child: Text(
                                    invoiceModel.name!,
                                    style: TextStyle(
                                      fontSize:
                                          AppDecoration().screenWidth * 0.045,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: AppDecoration().screenHeight * 0.02,
                                ),
                                SizedBox(
                                  width: AppDecoration().screenWidth * 0.5,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Invoice Date: ',
                                          style: TextStyle(
                                            fontSize:
                                                AppDecoration().screenWidth *
                                                    0.035,
                                            color: AppColors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: invoiceModel.date!,
                                          style: TextStyle(
                                            fontSize:
                                                AppDecoration().screenWidth *
                                                    0.035,
                                            color: AppColors.blue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                CustomButton(
                                  function: () {
                                    controller.invoiceDetails(
                                      invoiceModel: invoiceModel,
                                    );
                                  },
                                  margin: const EdgeInsets.only(
                                    left: 2,
                                    top: 8,
                                  ),
                                  buttonColor: AppColors.primaryColor,
                                  height: 0.03,
                                  width: 0.24,
                                  circularRadius: 10,
                                  fontSize: 0.05,
                                  fontHeight: 1.5,
                                  text: AppTexts.view,
                                ),
                              ],
                            ),
                          ],
                        ),
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
