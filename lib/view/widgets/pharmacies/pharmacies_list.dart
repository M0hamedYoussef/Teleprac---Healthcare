import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/pharmacies/pharmacies_controller.dart';
import 'package:teleprac/controller/search_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/model/pharmacies/pharmacy_model.dart';
import 'package:teleprac/view/widgets/pharmacies/pharmacy_details.dart';
import 'package:teleprac/view/widgets/pharmacies/pharmacy_image.dart';
import 'package:teleprac/view/widgets/pharmacies/pharmacy_options.dart';

class PharmaciesList extends GetView<PharmaciesController> {
  const PharmaciesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<SearchCon>(
        builder: (searchCon) {
          return ListView.builder(
            itemCount: controller.pharmacies.length,
            physics: const BouncingScrollPhysics(parent: PageScrollPhysics()),
            itemBuilder: (context, index) {
              PharmacyModel pharmacyModel = PharmacyModel.fromJson(
                controller.pharmacies[index],
              );

              if (searchCon.pharmaciesSearchValidate(
                  pharmacyModel: pharmacyModel)) {
                return Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.secondaryColor,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          PharmacyImage(
                            image: pharmacyModel.profileimage!,
                          ),
                          PharmacyDetails(
                            pharmacyModel: pharmacyModel,
                          ),
                        ],
                      ),
                      PharmacyOptions(
                        details: () {
                          controller.pharmacyDetails(
                            selectedPharmacyModel: pharmacyModel,
                          );
                        },
                        viewProducts: () {
                          controller.pharmacyProducts(
                            pharmacyModel: pharmacyModel,
                          );
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          );
        },
      ),
    );
  }
}
