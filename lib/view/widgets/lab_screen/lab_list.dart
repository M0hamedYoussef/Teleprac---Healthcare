import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/labs/labs_controller.dart';
import 'package:teleprac/controller/search_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/model/labs/lab_model.dart';
import 'package:teleprac/view/widgets/lab_screen/lab_info.dart';
import 'package:teleprac/view/widgets/lab_screen/lab_image.dart';
import 'package:teleprac/view/widgets/lab_screen/lab_options.dart';

class LabsList extends GetView<LabsController> {
  const LabsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<SearchCon>(
        builder: (searchCon) {
          return ListView.builder(
            itemCount: controller.allLabs.length,
            physics: const BouncingScrollPhysics(parent: PageScrollPhysics()),
            itemBuilder: (context, index) {
              LabModel labModel = LabModel.fromJson(
                controller.allLabs[index],
              );

              if (searchCon.labsSearchValidate(labModel: labModel)) {
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
                          LabImage(
                            image: labModel.profileimage!,
                          ),
                          LabDetails(
                            labModel: labModel,
                          ),
                        ],
                      ),
                      LabOptions(
                        details: () {
                          controller.labDetails(labModel: labModel);
                        },
                        viewTests: () {
                          controller.viewLabTests(labModel: labModel);
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
