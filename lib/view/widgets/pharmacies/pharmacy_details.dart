import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/pharmacies/pharmacy_model.dart';

class PharmacyDetails extends StatelessWidget {
  const PharmacyDetails({super.key, required this.pharmacyModel});
  final PharmacyModel pharmacyModel;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            pharmacyModel.pharmacyName!.length > 23
                ? '${pharmacyModel.pharmacyName!.substring(0, 23)}....'
                : pharmacyModel.pharmacyName!,
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w500,
              fontFamily: AppDecoration.cairo,
              fontSize: AppDecoration().screenWidth * 0.045,
            ),
          ),
          SizedBox(
            height: AppDecoration().screenHeight * 0.015,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on,
                color: AppColors.grey,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    pharmacyModel.address1!,
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppDecoration.cairo,
                      fontSize: AppDecoration().screenWidth * 0.035,
                    ),
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
