import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/model/doctors/doctors_model.dart';

class DoctorRating extends StatelessWidget {
  const DoctorRating({super.key, required this.doctorModel});

  final DoctorModel doctorModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, top: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Icon(
            Icons.star,
            color: AppColors.amber,
          ),
          Text(
            '${doctorModel.ratingValue}(${doctorModel.ratingCount})',
            style: const TextStyle(
              color: AppColors.amber,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
