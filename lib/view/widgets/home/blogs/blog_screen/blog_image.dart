import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/home/blogs_model.dart';
import 'package:teleprac/view/widgets/global/shimmer_placeholder.dart';

class BlogImage extends StatelessWidget {
  const BlogImage({super.key, required this.blogModel});
  final BlogsModel blogModel;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: 'BLOG:${blogModel.id!}',
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
              imageUrl: blogModel.uploadPreviewImageUrl!,
              errorWidget: (context, url, error) {
                return const SizedBox();
              },
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
