import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/model/home/blogs_model.dart';
import 'package:teleprac/routes.dart';
import 'package:teleprac/view/widgets/global/shimmer_placeholder.dart';

class BlogContainer extends StatelessWidget {
  const BlogContainer({
    super.key,
    required this.blogModel,
  });
  final BlogsModel blogModel;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'BLOG:${blogModel.id!}',
      placeholderBuilder: (context, heroSize, child) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(
                AppRoutes.blogScreen,
                arguments: {
                  'blogModel': blogModel,
                },
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: blogModel.uploadPreviewImageUrl!,
                errorWidget: (context, url, error) {
                  return const SizedBox();
                },
                placeholder: (context, _) {
                  return const CustomShimmerPlaceHolder(
                    width: 0.25,
                    margin: null,
                  );
                },
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: GestureDetector(
          onTap: () {
            Get.toNamed(
              AppRoutes.blogScreen,
              arguments: {
                'blogModel': blogModel,
              },
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: blogModel.uploadPreviewImageUrl!,
              errorWidget: (context, url, error) {
                return const SizedBox();
              },
              placeholder: (context, _) {
                return const CustomShimmerPlaceHolder(
                  width: 0.25,
                  margin: null,
                );
              },
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
