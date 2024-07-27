import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class ImageViewScreen extends StatelessWidget {
  const ImageViewScreen({
    super.key,
    required this.imageUrl,
    required this.appBarTitle,
  });
  final String imageUrl;
  final String appBarTitle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
              ),
              width: AppDecoration().screenWidth,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          CupertinoIcons.back,
                          color: AppColors.secondaryColor,
                          size: AppDecoration().screenWidth * 0.087,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        appBarTitle,
                        style: TextStyle(
                          fontSize: AppDecoration().screenWidth * 0.076,
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppDecoration.cairo,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: PhotoView(
                imageProvider: CachedNetworkImageProvider(
                  imageUrl,
                ),
                loadingBuilder: (context, event) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
