import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/view/widgets/global/shimmer_placeholder.dart';

class PharmacyImage extends StatelessWidget {
  const PharmacyImage({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: CachedNetworkImage(
          imageUrl: image,
          placeholder: (context, _) {
            return const CustomShimmerPlaceHolder(
              width: 0.15,
              height: 0.15,
              margin: null,
            );
          },
          width: AppDecoration().screenHeight * 0.15,
          height: AppDecoration().screenHeight * 0.15,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
