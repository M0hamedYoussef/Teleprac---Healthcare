import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard/my_products_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/global/custom_container.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/custom_text_form_field.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/date_picker.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/drop_down.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';
import 'package:teleprac/view/widgets/pharmacies/pharmacy_products/product_image.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomContainer(
          listView: true,
          margin: null,
          height: 1,
          decorationImage: const DecorationImage(
            image: AssetImage(
              AppDecoration.homeBg,
            ),
            fit: BoxFit.fill,
          ),
          children: [
            const UpperPart(
              text: AppTexts.addProduct,
            ),
            SizedBox(height: AppDecoration().screenHeight * .02),
            GetBuilder<MyProductsController>(
              builder: (controller) {
                return Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      if (controller.productImage != null)
                        ProductImage(
                          imagePath: controller.productImage!.path,
                          height: 0.35,
                          width: 0.8,
                        ),
                      if (controller.productImage == null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Icon(
                              Icons.image,
                              size: AppDecoration().screenWidth * 0.5,
                            ),
                          ),
                        ),
                      CustomButton(
                        function: () {
                          controller.selectImage();
                        },
                        text: 'Upload Image',
                        buttonIcon: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.upload,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        buttonColor: AppColors.primaryColor,
                      ),
                      SizedBox(height: AppDecoration().screenHeight * 0.02),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Status',
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: AppDecoration().screenWidth * 0.055,
                                ),
                              ),
                            ),
                            Switch(
                              value: controller.status ?? false,
                              activeColor: AppColors.primaryColor,
                              inactiveThumbColor: AppColors.red,
                              inactiveTrackColor:
                                  AppColors.red.withOpacity(0.5),
                              onChanged: (value) {
                                controller.status = value;
                                controller.update();
                              },
                            )
                          ],
                        ),
                      ),
                      CustomTextFormField(
                        textEditingController: controller.productNameCon,
                        focusNode: controller.productNameFocus,
                        nextFocusNode: controller.productPackSizeFocus,
                        label: 'Product Name',
                      ),
                      SizedBox(height: AppDecoration().screenHeight * 0.01),
                      CustomTextFormField(
                        textEditingController: controller.productPackSizeCon,
                        focusNode: controller.productPackSizeFocus,
                        label: 'Pack Size',
                      ),
                      SizedBox(height: AppDecoration().screenHeight * 0.01),
                      CustomDropDown(
                        dropdownList: controller.stockOptions,
                        value: controller.stock ?? '',
                        label: 'Stock',
                        onChanged: (val) {
                          controller.stock = val!;
                          controller.update();
                        },
                      ),
                      SizedBox(height: AppDecoration().screenHeight * 0.01),
                      CustomDropDown(
                        dropdownList: controller.featuredOptions,
                        value: controller.featured ?? '',
                        label: 'Featured',
                        onChanged: (val) {
                          controller.featured = val!;
                          controller.update();
                        },
                      ),
                      SizedBox(height: AppDecoration().screenHeight * 0.01),
                      CustomTextFormField(
                        textEditingController:
                            controller.productManufacturedbyCon,
                        focusNode: controller.productManufacturedbyFocus,
                        nextFocusNode: controller.productShortDescriptionFocus,
                        label: 'Manufactured by',
                      ),
                      SizedBox(height: AppDecoration().screenHeight * 0.01),
                      CustomTextFormField(
                        textEditingController:
                            controller.productShortDescriptionCon,
                        focusNode: controller.productShortDescriptionFocus,
                        nextFocusNode: controller.productDescriptionFocus,
                        label: 'Short Description',
                      ),
                      SizedBox(height: AppDecoration().screenHeight * 0.01),
                      CustomTextFormField(
                        textEditingController: controller.productDescriptionCon,
                        focusNode: controller.productDescriptionFocus,
                        nextFocusNode: controller.productCompsitionFocus,
                        maxLines: null,
                        label: 'Description',
                      ),
                      SizedBox(height: AppDecoration().screenHeight * 0.01),
                      CustomTextFormField(
                        textEditingController: controller.productCompsitionCon,
                        focusNode: controller.productCompsitionFocus,
                        label: 'Compsition',
                      ),
                      SizedBox(height: AppDecoration().screenHeight * 0.01),
                      CustomDropDown(
                        dropdownList: controller.productTypes,
                        value: controller.selectedProductType ?? '',
                        label: 'Product Type',
                        onChanged: (val) {
                          controller.selectedProductType = val!;
                          controller.update();
                        },
                      ),
                      SizedBox(height: AppDecoration().screenHeight * 0.01),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              textEditingController:
                                  controller.productUnitValueCon,
                              focusNode: controller.productUnitValueFocus,
                              label: 'Unit Value',
                              keyboardType: TextInputType.number,
                              padding: const EdgeInsets.only(left: 20),
                            ),
                          ),
                          SizedBox(width: AppDecoration().screenWidth * 0.025),
                          Expanded(
                            child: CustomDropDown(
                              dropdownList: controller.allUnits,
                              value: controller.selectedUnit ?? '',
                              label: 'Unit',
                              padding: const EdgeInsets.only(right: 20),
                              circularRadius: 20,
                              onChanged: (String? val) {
                                controller.selectedUnit = val!;
                                controller.update();
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppDecoration().screenHeight * 0.01),
                      CustomDatePicker(
                        date: controller.expieryDate ?? '',
                        label: 'Expiry Date',
                        onTap: () {
                          controller.selectDate(context: context);
                        },
                      ),
                      SizedBox(height: AppDecoration().screenHeight * 0.01),
                      CustomTextFormField(
                        textEditingController: controller.productPriceCon,
                        focusNode: controller.productPriceFocus,
                        nextFocusNode: controller.productDiscountFocus,
                        keyboardType: TextInputType.number,
                        label: 'Price',
                      ),
                      SizedBox(height: AppDecoration().screenHeight * 0.01),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              textEditingController:
                                  controller.productDiscountCon,
                              focusNode: controller.productDiscountFocus,
                              label: 'Discount',
                              keyboardType: TextInputType.number,
                              onEditingComplete: () {
                                if (controller
                                        .productPriceCon.text.isNotEmpty &&
                                    controller
                                        .productDiscountCon.text.isNotEmpty) {
                                  double discountedPrice = double.parse(
                                          controller.productPriceCon.text
                                              .trim()) -
                                      (double.parse(controller
                                              .productPriceCon.text
                                              .trim()) *
                                          (double.parse(controller
                                                  .productDiscountCon.text
                                                  .trim()) /
                                              100));
                                  controller.productSalePriceCon.text =
                                      discountedPrice.toString();
                                }
                                controller.productSalePriceFocus.requestFocus();
                              },
                              padding: const EdgeInsets.only(left: 20),
                            ),
                          ),
                          SizedBox(width: AppDecoration().screenWidth * 0.025),
                          Expanded(
                            child: CustomTextFormField(
                              textEditingController:
                                  controller.productSalePriceCon,
                              focusNode: controller.productSalePriceFocus,
                              keyboardType: TextInputType.number,
                              label: 'Sale',
                              padding: const EdgeInsets.only(right: 20),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppDecoration().screenHeight * 0.01),
                      CustomDropDown(
                        dropdownList: controller.categories,
                        value: controller.selectedCategory ?? '',
                        label: 'Categorie',
                        onChanged: (String? val) {
                          controller.selectedCategory = val!;
                          for (var element in controller.categories) {
                            if (element['category_id'] == val) {
                              controller.subCategories = null;
                              controller.selectedSubCategory = null;
                              controller.subCategories =
                                  element['sub_cateogory'];
                              break;
                            }
                          }
                          controller.update();
                        },
                      ),
                      if (controller.selectedCategory != null)
                        SizedBox(height: AppDecoration().screenHeight * 0.01),
                      if (controller.selectedCategory != null)
                        CustomDropDown(
                          dropdownList: controller.subCategories!,
                          value: controller.selectedSubCategory ?? '',
                          label: 'Sub Categorie',
                          onChanged: (String? val) {
                            controller.selectedSubCategory = val!;
                            controller.update();
                          },
                        ),
                      SizedBox(height: AppDecoration().screenHeight * 0.01),
                      CustomButton(
                        function: () {
                          controller.addProduct();
                        },
                        text: 'Add Product',
                        circularRadius: 10,
                        buttonColor: AppColors.primaryColor,
                      ),
                    ],
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
