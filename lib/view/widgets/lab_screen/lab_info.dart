import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/labs/lab_model.dart';

class LabDetails extends StatelessWidget {
  const LabDetails({super.key, required this.labModel});
  final LabModel labModel;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labModel.fullName!.length > 23
                ? '${labModel.fullName!.substring(0, 23)}....'
                : labModel.fullName!,
            style: const TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          SizedBox(
            height: AppDecoration().screenHeight * 0.015,
          ),
          Row(
            children: [
              const Icon(Icons.location_on),
              SizedBox(
                width: AppDecoration().screenWidth * 0.3,
                child: Text(
                  labModel.fullAddress!,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
