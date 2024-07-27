import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class DesignImageContainer extends StatelessWidget {
  const DesignImageContainer({
    super.key,
    required this.onTap,
    required this.imagePath,
    required this.text,
  });
  final Function onTap;
  final String imagePath;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: SizedBox(
        width: AppDecoration().screenWidth * 0.45,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: AppColors.greyDesign,
                  // image: DecorationImage(
                  //   image: AssetImage(
                  //     AppDecoration.homeBg,
                  //   ),
                  //   fit: BoxFit.fill,
                  // ),
                ),
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: AppDecoration().screenWidth * 0.033,
                    color: AppColors.black,
                    fontFamily: AppDecoration.cairo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // Padding(
    //   padding: const EdgeInsets.all(5.0),
    //   child: Ink(
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(10),
    //       color: AppColors.secondaryColor,
    //       border: Border.all(
    //         width: 0.5,
    //         color: AppColors.greySplash,
    //       ),
    //     ),
    //     child: InkWell(
    //       onTap: () {
    //         onTap();
    //       },
    //       borderRadius: BorderRadius.circular(10),
    //       child: Padding(
    //         padding: const EdgeInsets.all(5),
    //         child: Row(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             SizedBox(width: AppDecoration().screenWidth * 0.02),
    //             Center(
    //               child: Image.asset(
    //                 imagePath,
    //                 height: AppDecoration().screenHeight * 0.1,
    //               ),
    //             ),
    //             SizedBox(width: AppDecoration().screenWidth * 0.01),
    //             SizedBox(
    //               width: AppDecoration().screenWidth * 0.4,
    //               child: Center(
    //                 child: Text(text),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

/*
GestureDetector(
      onTap: () {
        onTap();
      },
      child: SizedBox(
        width: AppDecoration().screenWidth * 0.45,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: AssetImage(
                      AppDecoration.homeBg,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: AppDecoration().screenWidth * 0.033,
                    color: AppColors.black,
                    fontFamily: AppDecoration.cairo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
 */
