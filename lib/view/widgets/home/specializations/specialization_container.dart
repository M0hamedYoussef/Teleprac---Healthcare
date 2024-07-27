import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/specializations/specializations_model.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/view/widgets/global/shimmer_placeholder.dart';

class SpecializationContainer extends StatelessWidget {
  const SpecializationContainer(
      {super.key, required this.specializationModel, required this.selected});
  final SpecializationModel specializationModel;
  final Function() selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: FittedBox(
        child: GestureDetector(
          onTap: selected,
          child: CachedNetworkImage(
            imageUrl: specializationModel.specializationImg!,
            width: AppDecoration().screenHeight * 0.12,
            height: AppDecoration().screenHeight * 0.12,
            placeholder: (context, _) {
              return CustomShimmerPlaceHolder(
                height: 0.12,
                width: 0.12,
                margin: null,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(100),
                ),
              );
            },
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
