import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/doctors/doctors_model.dart';

class DoctorDetails extends StatelessWidget {
  const DoctorDetails({super.key, required this.doctorModel});
  final DoctorModel doctorModel;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: AppDecoration().screenWidth * 0.5,
            child: Text(
              doctorModel.fullName!.length > 21
                  ? '${doctorModel.fullName!.substring(0, 21)}....'
                  : doctorModel.fullName!,
              style: TextStyle(
                fontSize: AppDecoration().screenWidth * 0.04,
                fontWeight: FontWeight.w500,
                fontFamily: AppDecoration.cairo,
                color: AppColors.grey,
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(width: AppDecoration().screenWidth * 0.01),
              Text(
                'EXP: ',
                style: TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppDecoration.cairo,
                  fontSize: AppDecoration().screenWidth * 0.03,
                ),
              ),
              Text(
                '${doctorModel.experience} Years',
                style: TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppDecoration.cairo,
                  fontSize: AppDecoration().screenWidth * 0.03,
                ),
              ),
            ],
          ),
          SizedBox(
            height: AppDecoration().screenHeight * 0.005,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                doctorModel.specializationImg!,
                height: AppDecoration().screenHeight * 0.02,
                width: AppDecoration().screenHeight * 0.02,
              ),
              SizedBox(width: AppDecoration().screenWidth * 0.01),
              SizedBox(
                width: AppDecoration().screenWidth * 0.5,
                child: Text(
                  '${doctorModel.speciality}',
                  style: TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppDecoration.cairo,
                    fontSize: AppDecoration().screenWidth * 0.035,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: AppColors.primaryColor,
                size: AppDecoration().screenHeight * 0.02,
              ),
              SizedBox(width: AppDecoration().screenWidth * 0.01),
              SizedBox(
                width: AppDecoration().screenWidth * 0.3,
                child: Text(
                  doctorModel.fullAddress!,
                  style: TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppDecoration.cairo,
                    fontSize: AppDecoration().screenWidth * 0.035,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: AppDecoration().screenHeight * 0.005,
          ),
          Row(
            children: [
              Icon(
                Icons.star,
                color: AppColors.amber,
                size: AppDecoration().screenWidth * 0.05,
              ),
              SizedBox(width: AppDecoration().screenWidth * 0.01),
              Text(
                '${doctorModel.ratingValue} ',
                style: TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppDecoration.cairo,
                  fontSize: AppDecoration().screenWidth * 0.03,
                ),
              ),
              Text(
                '(${doctorModel.ratingCount} reviews)',
                style: TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppDecoration.cairo,
                  fontSize: AppDecoration().screenWidth * 0.03,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
