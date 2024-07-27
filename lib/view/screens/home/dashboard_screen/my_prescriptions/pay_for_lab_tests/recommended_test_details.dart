import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/home/dashboard/recommended_test_model.dart';
import 'package:teleprac/view/widgets/global/custom_container.dart';
import 'package:teleprac/view/widgets/global/shimmer_placeholder.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';

class RecommendedLabTestDetails extends StatelessWidget {
  const RecommendedLabTestDetails({
    super.key,
    required this.recommendedTestModel,
  });
  final RecommendedTestModel recommendedTestModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomContainer(
        margin: null,
        height: 1,
        children: [
          const UpperPart(
            text: 'Test Details',
          ),
          Container(
            color: AppColors.primaryColor,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: AppDecoration().screenWidth * 0.5,
                      child: Text(
                        'Patient Details',
                        style: TextStyle(
                          fontSize: AppDecoration().screenWidth * 0.05,
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppDecoration().screenWidth * 0.5,
                      child: Text(
                        recommendedTestModel.patientName!,
                        style: TextStyle(
                          fontSize: AppDecoration().screenWidth * 0.04,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppDecoration().screenWidth * 0.5,
                      child: Text(
                        recommendedTestModel.address!,
                        style: TextStyle(
                          fontSize: AppDecoration().screenWidth * 0.04,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      width: AppDecoration().screenWidth * 0.4,
                      child: Text(
                        'Doctor Details',
                        style: TextStyle(
                          fontSize: AppDecoration().screenWidth * 0.05,
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppDecoration().screenWidth * 0.4,
                      child: Text(
                        recommendedTestModel.doctorName!,
                        style: TextStyle(
                          fontSize: AppDecoration().screenWidth * 0.04,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: AppDecoration().screenHeight * 0.01),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Date :',
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    recommendedTestModel.createdDate!,
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppDecoration().screenHeight * 0.01),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Gender :',
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    recommendedTestModel.gender!,
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppDecoration().screenHeight * 0.01),
          SizedBox(height: AppDecoration().screenHeight * 0.01),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Age :',
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    recommendedTestModel.age!,
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppDecoration().screenHeight * 0.01),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Chief Complaints :\n\t\t${recommendedTestModel.chiefComplaints!}',
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppDecoration().screenHeight * 0.01),
          Container(
            color: AppColors.primaryColor,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Test Name',
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.04,
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: AppDecoration().screenWidth * 0.02),
                Expanded(
                  flex: 4,
                  child: Text(
                    'Preparation before test',
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.04,
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Time',
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.04,
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8, right: 8),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.black.withOpacity(0.12), width: 2.0),
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                ...List.generate(
                  recommendedTestModel.labtestDetails!.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: AppDecoration().screenWidth * 0.25,
                                child: Text(
                                  recommendedTestModel
                                          .labtestDetails![index].testName ??
                                      '',
                                  style: TextStyle(
                                    fontSize:
                                        AppDecoration().screenWidth * 0.04,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: AppDecoration().screenWidth * 0.12),
                              SizedBox(
                                width: AppDecoration().screenWidth * 0.2,
                                child: Text(
                                  recommendedTestModel.labtestDetails![index]
                                          .prepBeforeTest ??
                                      '',
                                  style: TextStyle(
                                    fontSize:
                                        AppDecoration().screenWidth * 0.04,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: AppDecoration().screenWidth * 0.12),
                              SizedBox(
                                width: AppDecoration().screenWidth * 0.2,
                                child: Text(
                                  recommendedTestModel
                                          .labtestDetails![index].time ??
                                      '',
                                  style: TextStyle(
                                    fontSize:
                                        AppDecoration().screenWidth * 0.04,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (recommendedTestModel.labtestDetails!.length !=
                              index + 1)
                            const Divider(thickness: 1.6),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: AppDecoration().screenHeight * 0.01),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Signature :',
                    style: TextStyle(
                      fontSize: AppDecoration().screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: AppDecoration().screenWidth * 0.3,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black.withOpacity(0.12),
                              width: 2.0),
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: CachedNetworkImage(
                          imageUrl: recommendedTestModel.signatureImage!,
                          width: AppDecoration().screenWidth * 0.3,
                          height: AppDecoration().screenHeight * 0.1,
                          placeholder: (context, url) {
                            return const CustomShimmerPlaceHolder(
                              width: 0.3,
                              height: 0.1,
                            );
                          },
                        ),
                      ),
                      Text(
                        'Dr. ${recommendedTestModel.doctorName!}',
                        style: TextStyle(
                          fontSize: AppDecoration().screenWidth * 0.035,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
