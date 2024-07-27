import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/account_settings/account_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:flutter/material.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/global/shimmer_placeholder.dart';

class SettingStack extends GetView<AccountController> {
  const SettingStack({super.key});

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
            // gradient: AppColors.mainLinarGradient,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
          ),
          child: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    SystemChrome.setSystemUIOverlayStyle(
                      const SystemUiOverlayStyle(
                        statusBarColor: AppColors.lightGrey1,
                        statusBarIconBrightness: Brightness.light,
                      ),
                    );
                    Get.back();
                  },
                  icon: Icon(
                    CupertinoIcons.back,
                    color: AppColors.secondaryColor,
                    size: AppDecoration().screenWidth * 0.09,
                  ),
                ),
                Text(
                  AppTexts.settings,
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
        ),
        Positioned(
          top: AppDecoration().screenHeight * .2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage(
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
            ),
          ),
        ),
      ],
    );
  }
}
