import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard/accounts/doctor_accounts_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/model/home/dashboard/accounts/account_model.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class DoctorAccountsScreen extends StatelessWidget {
  const DoctorAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DoctorAccountsController controller = Get.put(DoctorAccountsController());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: SafeArea(
        child: Column(
          children: [
            const UpperPart(text: 'Accounts'),
            SizedBox(
              height: AppDecoration().screenHeight * 0.01,
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: [
                  GetBuilder<DoctorAccountsController>(
                    builder: (_) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.secondaryColor,
                        ),
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(20),
                        width: AppDecoration().screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Account Details',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppDecoration.cairo,
                                      fontSize:
                                          AppDecoration().screenWidth * 0.045,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                    overlayColor: MaterialStatePropertyAll(
                                      AppColors.primaryColor.withOpacity(0.1),
                                    ),
                                  ),
                                  onPressed: () {
                                    controller.goToUpdateAccountDetails();
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        color: AppColors.primaryColor,
                                        size:
                                            AppDecoration().screenWidth * 0.05,
                                      ),
                                      SizedBox(
                                          width: AppDecoration().screenWidth *
                                              0.01),
                                      const Text(
                                        'Edit',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontFamily: AppDecoration.cairo,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Bank Name : ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppDecoration.cairo,
                                      fontSize:
                                          AppDecoration().screenWidth * 0.045,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: controller.accountDetailsModel
                                        .accountDetails!.bankName,
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
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Branch Name : ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppDecoration.cairo,
                                      fontSize:
                                          AppDecoration().screenWidth * 0.045,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: controller.accountDetailsModel
                                        .accountDetails!.branchName,
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
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Account Number : ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppDecoration.cairo,
                                      fontSize:
                                          AppDecoration().screenWidth * 0.045,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: controller.accountDetailsModel
                                        .accountDetails!.accountNo,
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
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Account Name : ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppDecoration.cairo,
                                      fontSize:
                                          AppDecoration().screenWidth * 0.045,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: controller.accountDetailsModel
                                        .accountDetails!.accountName,
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
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'IFSC CODE : ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppDecoration.cairo,
                                      fontSize:
                                          AppDecoration().screenWidth * 0.045,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: controller.accountDetailsModel
                                        .accountDetails!.ifscCode,
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
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'UPI ID: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppDecoration.cairo,
                                      fontSize:
                                          AppDecoration().screenWidth * 0.045,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: controller.accountDetailsModel
                                        .accountDetails!.upiId,
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
                          ],
                        ),
                      );
                    },
                  ),
                  GetBuilder<DoctorAccountsController>(
                    builder: (_) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.secondaryColor,
                        ),
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        width: AppDecoration().screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Your Balance',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppDecoration.cairo,
                                      fontSize:
                                          AppDecoration().screenWidth * 0.045,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                    overlayColor: MaterialStatePropertyAll(
                                      AppColors.primaryColor.withOpacity(0.1),
                                    ),
                                  ),
                                  onPressed: () {
                                    controller.requestBalance();
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.request_page_rounded,
                                        color: AppColors.primaryColor,
                                        size:
                                            AppDecoration().screenWidth * 0.05,
                                      ),
                                      SizedBox(
                                          width: AppDecoration().screenWidth *
                                              0.01),
                                      const Text(
                                        'Request',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontFamily: AppDecoration.cairo,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Earned : ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppDecoration.cairo,
                                      fontSize:
                                          AppDecoration().screenWidth * 0.045,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '${controller.earned} ${AppTexts.indianRupee}',
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
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Requested : ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppDecoration.cairo,
                                      fontSize:
                                          AppDecoration().screenWidth * 0.045,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '${controller.requested} ${AppTexts.indianRupee}',
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
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Balance : ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppDecoration.cairo,
                                      fontSize:
                                          AppDecoration().screenWidth * 0.045,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '${controller.balance} ${AppTexts.indianRupee}',
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
                          ],
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 20),
                    child: Text(
                      'Accounts List',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: AppDecoration.cairo,
                        fontSize: AppDecoration().screenWidth * 0.045,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                  ...List.generate(
                    controller.accounts.length,
                    (index) {
                      AccountModel accountModel =
                          AccountModel.fromJson(controller.accounts[index]);
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.secondaryColor,
                        ),
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        width: AppDecoration().screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Date : ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppDecoration.cairo,
                                      fontSize:
                                          AppDecoration().screenWidth * 0.045,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: accountModel.date,
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
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Patient Name : ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppDecoration.cairo,
                                      fontSize:
                                          AppDecoration().screenWidth * 0.045,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: accountModel.patientName,
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
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Amount : ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppDecoration.cairo,
                                      fontSize:
                                          AppDecoration().screenWidth * 0.045,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: accountModel.amount,
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
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Status : ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppDecoration.cairo,
                                      fontSize:
                                          AppDecoration().screenWidth * 0.045,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: accountModel.statustxt,
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
      ),
    );
  }
}
