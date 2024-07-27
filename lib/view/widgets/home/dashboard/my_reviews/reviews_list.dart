import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:teleprac/controller/home/dashboard/my_reviews_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/home/dashboard/review_model.dart';
import 'package:teleprac/view/widgets/global/user_image.dart';

class MyReviewsList extends GetView<MyReviewsController> {
  const MyReviewsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: controller.myReviews.length,
        physics: const BouncingScrollPhysics(parent: PageScrollPhysics()),
        itemBuilder: (context, index) {
          ReviewModel reviewModel =
              ReviewModel.fromJson(controller.myReviews[index]);

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.secondaryColor,
            ),
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
              top: 10,
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    UserImage(
                      image: reviewModel.profileimage!,
                      scale: 0.8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: AppDecoration().screenWidth * 0.4,
                              child: Text(
                                reviewModel.fullName!,
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: AppDecoration().screenWidth * 0.05,
                                  fontFamily: AppDecoration.cairo,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: AppColors.amber,
                                ),
                                SizedBox(
                                  width: AppDecoration().screenWidth * 0.07,
                                  child: Text(
                                    reviewModel.rating!,
                                    style: TextStyle(
                                      color: AppColors.amber,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          AppDecoration().screenWidth * 0.035,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppDecoration().screenHeight * 0.02,
                        ),
                        SizedBox(
                          width: AppDecoration().screenWidth * 0.5,
                          child: Text(
                            reviewModel.title!.isEmpty
                                ? 'No Title'
                                : reviewModel.title!,
                            style: TextStyle(
                              color: AppColors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: AppDecoration().screenWidth * 0.045,
                              fontFamily: AppDecoration.cairo,
                              wordSpacing: 2,
                              height: 1,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: AppDecoration().screenHeight * 0.01,
                        ),
                        SizedBox(
                          width: AppDecoration().screenWidth * 0.5,
                          child: Text(
                            reviewModel.review!.isEmpty
                                ? 'No Review'
                                : reviewModel.review!,
                            style: TextStyle(
                              color: AppColors.grey,
                              fontWeight: FontWeight.w300,
                              fontSize: AppDecoration().screenWidth * 0.04,
                              fontFamily: AppDecoration.cairo,
                              wordSpacing: 2,
                              height: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: AppDecoration().screenWidth * 0.8,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Review Date: ',
                            style: TextStyle(
                              color: AppColors.grey,
                              fontWeight: FontWeight.w300,
                              fontSize: AppDecoration().screenWidth * 0.04,
                              fontFamily: AppDecoration.cairo,
                            ),
                          ),
                          TextSpan(
                            text: Jiffy(reviewModel.createdDate).yMMMEdjm,
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w300,
                              fontSize: AppDecoration().screenWidth * 0.04,
                              fontFamily: AppDecoration.cairo,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
