import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard/my_family_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/custom_text_form_field.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/date_picker.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/drop_down.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class FamilyMemberScreen extends GetView<MyFamilyController> {
  const FamilyMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: WillPopScope(
        onWillPop: controller.addFamilyWillPop,
        child: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            children: [
              UpperPart(
                text: AppTexts.addFamilyMember,
                customBackFunction: controller.addFamilyWillPop,
              ),
              SizedBox(height: AppDecoration().screenHeight * .01),
              GetBuilder<MyFamilyController>(
                builder: (_) {
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Column(
                      children: [
                        CustomTextFormField(
                          leading: const Icon(
                            Icons.person,
                            color: AppColors.primaryColor,
                          ),
                          textEditingController: controller.nameCon,
                          focusNode: controller.nameFocus,
                          nextFocusNode: controller.phoneNumberFocus,
                          oldDesign: false,
                          label: 'Name',
                        ),
                        SizedBox(height: AppDecoration().screenHeight * .02),
                        CustomTextFormField(
                          leading: const Icon(
                            Icons.phone,
                            color: AppColors.primaryColor,
                          ),
                          textEditingController: controller.phoneNumberCon,
                          focusNode: controller.phoneNumberFocus,
                          nextFocusNode: controller.addressFocus,
                          oldDesign: false,
                          label: 'Phone Number',
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: AppDecoration().screenHeight * .02),
                        CustomTextFormField(
                          leading: const Icon(
                            Icons.location_city,
                            color: AppColors.primaryColor,
                          ),
                          textEditingController: controller.addressCon,
                          oldDesign: false,
                          label: 'Address',
                          focusNode: controller.addressFocus,
                          nextFocusNode: controller.relationFocus,
                        ),
                        SizedBox(height: AppDecoration().screenHeight * .02),
                        CustomTextFormField(
                          textEditingController: controller.relationCon,
                          focusNode: controller.relationFocus,
                          oldDesign: false,
                          label: 'Relation',
                        ),
                        SizedBox(height: AppDecoration().screenHeight * .02),
                        CustomDatePicker(
                          date: controller.dob,
                          label: 'Date Of Birth',
                          oldDesgin: false,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          onTap: () {
                            controller.selectDate(context: context);
                          },
                        ),
                        SizedBox(height: AppDecoration().screenHeight * .02),
                        CustomDropDown(
                          leading: Icon(
                            controller.gender.toLowerCase() == 'male'
                                ? Icons.man
                                : Icons.woman,
                            color: AppColors.primaryColor,
                          ),
                          dropdownList: controller.genders,
                          value: controller.gender,
                          label: 'Gender',
                          oldDesign: false,
                          onChanged: (String? val) {
                            controller.gender = val!;
                            controller.update();
                          },
                        ),
                        SizedBox(height: AppDecoration().screenHeight * .02),
                        CustomDropDown(
                          leading: const Icon(
                            Icons.bloodtype_sharp,
                            color: AppColors.primaryColor,
                          ),
                          dropdownList: controller.bloodGroups,
                          value: controller.bloodGroup,
                          oldDesign: false,
                          label: 'Blood Group',
                          onChanged: (String? val) {
                            controller.bloodGroup = val!;
                            controller.update();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: AppDecoration().screenHeight * .02),
              CustomButton(
                function: controller.addFamilyMember,
                circularRadius: 10,
                buttonColor: AppColors.primaryColor,
                text: 'Confirm',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
