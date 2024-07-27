import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/main_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/model/home/offers_model.dart';
import 'package:teleprac/view/widgets/global/shimmer_placeholder.dart';

class OfferContainer extends GetView<MainController> {
  const OfferContainer({
    super.key,
    required this.offerModel,
  });
  final OffersModel offerModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.offerDetails(offerModel: offerModel);
      },
      child: Hero(
        tag: offerModel.id!,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: offerModel.image!,
              placeholder: (context, _) {
                return const CustomShimmerPlaceHolder(
                  // height: 0.165,
                  width: 0.2,
                  margin: null,
                );
              },
              // height: AppDecoration().screenHeight * 0.165,
              // width: AppDecoration().screenHeight * 0.2,
              // fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
