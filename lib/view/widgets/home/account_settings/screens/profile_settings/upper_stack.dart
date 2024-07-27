import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/account_settings/profile_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:flutter/material.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/global/shimmer_placeholder.dart';

class ProfileStack extends GetView<ProfileController> {
  const ProfileStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          height: AppDecoration().screenHeight * .26,
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  controller.willPop();
                },
                icon: Icon(
                  CupertinoIcons.back,
                  color: AppColors.secondaryColor,
                  size: AppDecoration().screenWidth * 0.09,
                ),
              ),
              Text(
                AppTexts.profileSettings,
                style: TextStyle(
                  fontSize: AppDecoration().screenWidth * 0.07,
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppDecoration.cairo,
                  height: 2.2,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: AppDecoration().screenHeight * .2,
          child: GestureDetector(
            onTap: () {
              controller.choosePicture();
            },
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomRight,
              children: [
                GetBuilder<ProfileController>(builder: (_) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: controller.pfp == null
                        ? CachedNetworkImage(
                            imageUrl: controller.userPFP,
                            placeholder: (context, _) {
                              return const CustomShimmerPlaceHolder(
                                height: 0.1,
                                width: 0.1,
                                margin: null,
                              );
                            },
                            height: AppDecoration().screenHeight * 0.1,
                            width: AppDecoration().screenHeight * 0.1,
                            fit: BoxFit.fill,
                          )
                        : Image.file(
                            controller.pfp!,
                            height: AppDecoration().screenHeight * 0.1,
                            width: AppDecoration().screenHeight * 0.1,
                            fit: BoxFit.fill,
                          ),
                  );
                }),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Icon(
                    Icons.camera_alt,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
