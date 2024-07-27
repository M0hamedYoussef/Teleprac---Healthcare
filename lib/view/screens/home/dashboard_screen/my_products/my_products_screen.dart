import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard/my_products_controller.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/pharmacies/product_model.dart';
import 'package:teleprac/view/widgets/home/dashboard/my_products/product_container.dart';
import 'package:teleprac/view/widgets/home/dashboard/my_products/upper_part.dart';

class MyProductsScreen extends StatelessWidget {
  const MyProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyProductsController controller = Get.put(MyProductsController());
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppDecoration.homeBg),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              const UpperPart(),
              SizedBox(
                height: AppDecoration().screenHeight * 0.02,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.myProductsList.length,
                  physics:
                      const BouncingScrollPhysics(parent: PageScrollPhysics()),
                  itemBuilder: (context, index) {
                    ProductModel productModel = ProductModel.fromJson(
                      controller.myProductsList[index],
                    );
                    return GestureDetector(
                      onTap: () {
                        controller.goToEditProductScreen(
                          productModel: productModel,
                        );
                      },
                      child: MyProductContainer(
                        productModel: productModel,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
