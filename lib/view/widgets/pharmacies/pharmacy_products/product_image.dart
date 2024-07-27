import 'dart:io';
import 'package:flutter/material.dart';
import 'package:teleprac/core/const/decoration.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    this.imageUrl,
    this.imagePath,
    this.height = 0.16,
    this.width = 0.16,
  });
  final String? imageUrl;
  final String? imagePath;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            imageUrl!,
            errorBuilder: (context, error, stackTrace) {
              return SizedBox(
                width: AppDecoration().screenHeight * width,
                height: AppDecoration().screenHeight * height,
              );
            },
            // loadingBuilder: (context, child, loadingProgress) {
            //   return CustomShimmerPlaceHolder(
            //     width: width,
            //     height: height,
            //     margin: null,
            // );
            // },
            // imageUrl: imageUrl!,
            // errorWidget: (context, url, error) {
            //   return const SizedBox();
            // },
            // placeholder: (context, _) {
            //   return CustomShimmerPlaceHolder(
            //     width: width,
            //     height: height,
            //     margin: null,
            //   );
            // },
            width: AppDecoration().screenHeight * width,
            height: AppDecoration().screenHeight * height,
            fit: BoxFit.contain,
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.file(
            File(imagePath!),
            width: AppDecoration().screenHeight * width,
            height: AppDecoration().screenHeight * height,
            fit: BoxFit.contain,
          ),
        ),
      );
    }
  }
}
