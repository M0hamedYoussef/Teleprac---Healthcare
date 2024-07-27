import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/main_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/model/home/blogs_model.dart';
import 'package:teleprac/view/widgets/home/blogs/blog_container.dart';
import 'package:teleprac/view/widgets/global/shimmer_placeholder.dart';

class Blogs extends GetView<MainController> {
  const Blogs({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTexts.healthBlogs,
            style: TextStyle(
              fontSize: AppDecoration().screenWidth * 0.04,
              fontWeight: FontWeight.bold,
              fontFamily: AppDecoration.cairo,
              color: AppColors.grey,
            ),
          ),
          SizedBox(
            height: AppDecoration().screenHeight * 0.02,
          ),
          SizedBox(
            height: AppDecoration().screenHeight * 0.2,
            child: GetBuilder<MainController>(
              builder: (_) {
                if (controller.blogsList.isEmpty) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const CustomShimmerPlaceHolder(
                        width: 0.25,
                        margin: EdgeInsets.only(left: 10, right: 10),
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemCount: controller.blogsList.length,
                    itemBuilder: (context, index) {
                      BlogsModel blogModel =
                          BlogsModel.fromJson(controller.blogsList[index]);

                      return BlogContainer(
                        blogModel: blogModel,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
