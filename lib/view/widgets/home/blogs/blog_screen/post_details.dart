import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/home/blogs_model.dart';

class PostDetails extends StatelessWidget {
  const PostDetails({super.key, required this.blogModel});
  final BlogsModel blogModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // SvgPicture.asset(
              //   AppDecoration.accountSvg,
              //   width: AppDecoration().screenWidth * 0.1,
              //   colorFilter: const ColorFilter.mode(
              //     AppColors.primaryColor,
              //     BlendMode.srcIn,
              //   ),
              // ),
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.person,
                  color: AppColors.primaryColor,
                ),
              ),
              Text(
                blogModel.postBy!,
                style: TextStyle(
                  fontSize: AppDecoration().screenWidth * 0.045,
                  fontFamily: AppDecoration.cairo,
                  fontWeight: FontWeight.w500,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () async {
              await Share.share(blogModel.blogLink!);
            },
            icon: const Icon(
              Icons.share,
              color: AppColors.primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
