import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/view/widgets/global/shimmer_placeholder.dart';

class UserImage extends StatelessWidget {
  const UserImage({
    super.key,
    required this.image,
    this.height = 0.11,
    this.width = 0.11,
    this.circularRadius = 100,
    this.scale = 1,
    this.padding = const EdgeInsets.all(8.0),
    this.withGradient = true,
  });
  final String image;
  final double height;
  final double width;
  final double circularRadius;
  final double scale;
  final EdgeInsets padding;
  final bool withGradient;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Transform.scale(
        scale: scale,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: (AppDecoration().screenHeight * height) + 5,
              width: (AppDecoration().screenHeight * width) + 5,
              decoration: BoxDecoration(
                gradient: withGradient ? AppColors.mainLinarGradient : null,
                borderRadius: BorderRadius.circular(circularRadius),
                boxShadow: withGradient
                    ? null
                    : const [BoxShadow(color: AppColors.greyDesign)],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(circularRadius),
              child: CachedNetworkImage(
                imageUrl: image,
                placeholder: (context, _) {
                  return CustomShimmerPlaceHolder(
                    height: height,
                    width: width,
                    margin: null,
                  );
                },
                height: AppDecoration().screenHeight * height,
                width: AppDecoration().screenHeight * width,
                fit: BoxFit.fill,
                errorWidget: (context, url, error) {
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
