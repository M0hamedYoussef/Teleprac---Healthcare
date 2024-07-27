import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:teleprac/controller/home/dashboard/my_family_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/model/home/dashboard/family_member_model.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class MyFamilyScreen extends StatelessWidget {
  const MyFamilyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyFamilyController controller = Get.put(MyFamilyController());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: SafeArea(
        child: Column(
          children: [
            UpperPart(
              text: AppTexts.myFamily,
              trIcon: Icons.add,
              trFunction: () {
                controller.goToAddFamilyMember();
              },
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.02),
            GetBuilder<MyFamilyController>(
              builder: (controller) {
                return Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemCount: controller.myFamily.length,
                    itemBuilder: (context, index) {
                      FamilyMemberModel familyMemberModel =
                          FamilyMemberModel.fromJson(
                              controller.myFamily[index]);
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
                            if (familyMemberModel.name != null)
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Name: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            AppDecoration().screenWidth * 0.045,
                                        color: AppColors.black,
                                        fontFamily: AppDecoration.cairo,
                                      ),
                                    ),
                                    TextSpan(
                                      text: familyMemberModel.name!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            AppDecoration().screenWidth * 0.043,
                                        color: AppColors.grey,
                                        fontFamily: AppDecoration.cairo,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (familyMemberModel.contact != null)
                              SizedBox(
                                  height: AppDecoration().screenHeight * 0.01),
                            if (familyMemberModel.contact != null)
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Phone Number: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            AppDecoration().screenWidth * 0.045,
                                        color: AppColors.black,
                                        fontFamily: AppDecoration.cairo,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '+91${familyMemberModel.contact!.replaceAll('+91', '')}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            AppDecoration().screenWidth * 0.043,
                                        color: AppColors.grey,
                                        fontFamily: AppDecoration.cairo,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (familyMemberModel.gender != null)
                              SizedBox(
                                  height: AppDecoration().screenHeight * 0.01),
                            if (familyMemberModel.gender != null)
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Gender: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            AppDecoration().screenWidth * 0.045,
                                        color: AppColors.black,
                                        fontFamily: AppDecoration.cairo,
                                      ),
                                    ),
                                    TextSpan(
                                      text: familyMemberModel
                                          .gender!.capitalizeFirst!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            AppDecoration().screenWidth * 0.043,
                                        color: AppColors.grey,
                                        fontFamily: AppDecoration.cairo,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (familyMemberModel.dob != null)
                              SizedBox(
                                  height: AppDecoration().screenHeight * 0.01),
                            if (familyMemberModel.dob != null)
                              Row(
                                children: [
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Date Of Birth: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  AppDecoration().screenWidth *
                                                      0.045,
                                              color: AppColors.black,
                                              fontFamily: AppDecoration.cairo,
                                            ),
                                          ),
                                          TextSpan(
                                            text: Jiffy(familyMemberModel.dob!)
                                                .yMMMEd,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  AppDecoration().screenWidth *
                                                      0.043,
                                              color: AppColors.grey,
                                              fontFamily: AppDecoration.cairo,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            if (familyMemberModel.address != null)
                              SizedBox(
                                  height: AppDecoration().screenHeight * 0.01),
                            if (familyMemberModel.address != null)
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Address: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            AppDecoration().screenWidth * 0.045,
                                        color: AppColors.black,
                                        fontFamily: AppDecoration.cairo,
                                      ),
                                    ),
                                    TextSpan(
                                      text: familyMemberModel.address!
                                          .replaceAll(',India', '')
                                          .replaceAll(',india', '')
                                          .replaceAll(', India', '')
                                          .replaceAll(', india', ''),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            AppDecoration().screenWidth * 0.043,
                                        color: AppColors.grey,
                                        fontFamily: AppDecoration.cairo,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (familyMemberModel.relation != null)
                              SizedBox(
                                  height: AppDecoration().screenHeight * 0.01),
                            if (familyMemberModel.relation != null)
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Relation: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            AppDecoration().screenWidth * 0.045,
                                        color: AppColors.black,
                                        fontFamily: AppDecoration.cairo,
                                      ),
                                    ),
                                    TextSpan(
                                      text: familyMemberModel.relation!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            AppDecoration().screenWidth * 0.043,
                                        color: AppColors.grey,
                                        fontFamily: AppDecoration.cairo,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (familyMemberModel.bloodGroup != null)
                              SizedBox(
                                  height: AppDecoration().screenHeight * 0.01),
                            if (familyMemberModel.bloodGroup != null)
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Blood Group: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            AppDecoration().screenWidth * 0.045,
                                        color: AppColors.black,
                                        fontFamily: AppDecoration.cairo,
                                      ),
                                    ),
                                    TextSpan(
                                      text: familyMemberModel.bloodGroup!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            AppDecoration().screenWidth * 0.043,
                                        color: AppColors.grey,
                                        fontFamily: AppDecoration.cairo,
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
