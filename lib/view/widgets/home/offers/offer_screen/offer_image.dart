import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/offers_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/view/widgets/global/shimmer_placeholder.dart';

class OfferImage extends GetView<OffersController> {
  const OfferImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: controller.offerModel.id!,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              width: 1,
              color: AppColors.grey,
            ),
          ),
          width: AppDecoration().screenHeight * 0.3,
          height: AppDecoration().screenHeight * 0.3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: controller.offerModel.image!,
              placeholder: (context, _) {
                return const CustomShimmerPlaceHolder(
                  width: 0.3,
                  height: 0.3,
                  margin: null,
                );
              },
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
