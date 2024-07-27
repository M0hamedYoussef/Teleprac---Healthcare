import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class DoctorOptions extends StatelessWidget {
  const DoctorOptions(
      {super.key, required this.viewProfile, required this.bookNow});
  final void Function() viewProfile;
  final void Function() bookNow;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(17),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: IntrinsicHeight(
              child: ElevatedButton(
                onPressed: () {
                  viewProfile();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.secondaryColor,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(17),
                    ),
                  ),
                ),
                child: Text(
                  AppTexts.viewProfile,
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: AppDecoration().screenWidth * 0.05,
                    fontFamily: AppDecoration.cairo,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: AppDecoration().screenWidth * 0.005),
          Expanded(
            child: IntrinsicHeight(
              child: ElevatedButton(
                onPressed: () {
                  bookNow();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.secondaryColor,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(17),
                    ),
                  ),
                ),
                child: Text(
                  AppTexts.bookNow,
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: AppDecoration().screenWidth * 0.05,
                    fontFamily: AppDecoration.cairo,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
