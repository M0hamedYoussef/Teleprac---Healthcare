import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/blogs_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/home/blogs/blog_screen/blog_content.dart';
import 'package:teleprac/view/widgets/home/blogs/blog_screen/blog_date.dart';
import 'package:teleprac/view/widgets/home/blogs/blog_screen/blog_image.dart';
import 'package:teleprac/view/widgets/home/blogs/blog_screen/blog_title.dart';
import 'package:teleprac/view/widgets/home/blogs/blog_screen/post_details.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlogsController controller = Get.put(BlogsController());
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: SafeArea(
        child: Column(
          children: [
            const UpperPart(
              text: AppTexts.blogPost,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListView(
                  children: [
                    SizedBox(height: AppDecoration().screenHeight * 0.03),
                    BlogImage(blogModel: controller.blogModel),
                    SizedBox(height: AppDecoration().screenHeight * 0.01),
                    PostDetails(blogModel: controller.blogModel),
                    SizedBox(height: AppDecoration().screenHeight * 0.01),
                    BlogTitle(title: controller.blogModel.title!),
                    BlogCreatedDate(date: controller.blogModel.createdDate!),
                    SizedBox(height: AppDecoration().screenHeight * 0.01),
                    BlogContent(content: controller.blogModel.content!),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
