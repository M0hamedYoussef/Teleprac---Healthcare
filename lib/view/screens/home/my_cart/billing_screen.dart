import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/cart/billing_controller.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/custom_text_form_field.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/drop_down.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';
import 'package:teleprac/core/const/colors.dart';

class BillingScreen extends StatelessWidget {
  const BillingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BillingController controller = Get.put(BillingController());

    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            const UpperPart(
              text: AppTexts.billing,
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.02),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.secondaryColor,
              ),
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: GetBuilder<BillingController>(
                builder: (_) {
                  return Column(
                    children: [
                      SizedBox(height: AppDecoration().screenHeight * 0.02),
                      CustomTextFormField(
                        textEditingController: controller.fullNameCon,
                        focusNode: controller.fullNameFocus,
                        nextFocusNode: controller.firstAddressFocus,
                        validationText: controller.fullNameValidationText,
                        label: 'Full Name',
                        oldDesign: false,
                      ),
                      CustomTextFormField(
                        leading: const Icon(
                          Icons.location_city,
                          color: AppColors.primaryColor,
                        ),
                        textEditingController: controller.firstAddressCon,
                        focusNode: controller.firstAddressFocus,
                        nextFocusNode: controller.secondAddressFocus,
                        validationText: controller.firstAddressValidationText,
                        label: 'First Address',
                        oldDesign: false,
                      ),
                      CustomTextFormField(
                        leading: const Icon(
                          Icons.location_city,
                          color: AppColors.primaryColor,
                        ),
                        textEditingController: controller.secondAddressCon,
                        focusNode: controller.secondAddressFocus,
                        nextFocusNode: controller.phoneFocus,
                        label: 'Second Address',
                        oldDesign: false,
                        validationText: controller.secondAddressValidationText,
                      ),
                      CustomTextFormField(
                        leading: const Icon(
                          Icons.phone,
                          color: AppColors.primaryColor,
                        ),
                        textEditingController: controller.phoneCon,
                        focusNode: controller.phoneFocus,
                        nextFocusNode: controller.emailFocus,
                        keyboardType: TextInputType.number,
                        label: 'Phone Number',
                        oldDesign: false,
                        validationText: controller.phoneValidationText,
                      ),
                      CustomTextFormField(
                        leading: const Icon(
                          Icons.mail,
                          color: AppColors.primaryColor,
                        ),
                        textEditingController: controller.emailCon,
                        focusNode: controller.emailFocus,
                        nextFocusNode: controller.postalCodeFocus,
                        label: 'Email',
                        oldDesign: false,
                        validationText: controller.emailValidationText,
                      ),
                      CustomTextFormField(
                        leading: const Icon(
                          Icons.mail,
                          color: AppColors.primaryColor,
                        ),
                        oldDesign: false,
                        textEditingController: controller.postalCodeCon,
                        focusNode: controller.postalCodeFocus,
                        keyboardType: TextInputType.number,
                        label: 'Postal Code',
                        validationText: controller.postalCodeValidationText,
                      ),
                      CustomDropDown(
                        leading: const Icon(
                          Icons.location_city,
                          color: AppColors.primaryColor,
                        ),
                        dropdownList: controller.states,
                        value: controller.state,
                        label: 'State',
                        oldDesign: false,
                        onChanged: (String? val) {
                          controller.stateSelected(id: val!);
                        },
                      ),
                      if (controller.state != '0' &&
                          controller.state.isNotEmpty)
                        GestureDetector(
                          onTap: () {
                            if (controller.cities.isEmpty) {
                              Get.defaultDialog(
                                  middleText: 'Choose State First');
                            }
                          },
                          child: CustomDropDown(
                            leading: const Icon(
                              Icons.location_city,
                              color: AppColors.primaryColor,
                            ),
                            dropdownList: controller.cities,
                            value: controller.cities.toString().contains(
                                    'value: ${controller.city.trim()},')
                                ? controller.city
                                : '',
                            oldDesign: false,
                            label: 'City',
                            onChanged: (String? val) {
                              controller.city = val!;
                              controller.update();
                            },
                          ),
                        ),
                      SizedBox(height: AppDecoration().screenHeight * 0.02),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.02),
            CustomButton(
              function: () {
                if (controller.validate()) {
                  if (controller.cartProducts != null &&
                      !controller.payForLabTests) {
                    controller.placeOrder();
                  } else {
                    controller.bookTests(context: context);
                  }
                }
              },
              text: 'Confirm',
              textColor: AppColors.secondaryColor,
              buttonColor: AppColors.primaryColor,
              circularRadius: 10,
              width: 0.7,
            ),
            SizedBox(height: AppDecoration().screenHeight * 0.02),
          ],
        ),
      ),
    );
  }
}
