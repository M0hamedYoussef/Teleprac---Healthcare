import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';

class OfferGradientContainer extends StatelessWidget {
  const OfferGradientContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: AppDecoration().screenWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.greenAccent, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  AppDecoration.discount,
                  width: AppDecoration().screenWidth * 0.2,
                ),
                Text(
                  AppTexts.orderOffer,
                  style: TextStyle(
                    fontSize: AppDecoration().screenWidth * 0.03,
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(width: AppDecoration().screenWidth * 0.04),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppTexts.orderTitle,
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: AppDecoration().screenWidth * 0.05,
                      fontFamily: AppDecoration.cairo,
                      wordSpacing: 2,
                      height: 0.4,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.primaryColor,
                    ),
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                    child: Text(
                      AppTexts.orderNow,
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: AppDecoration().screenWidth * 0.03,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: AppDecoration().screenWidth * 0.05,
            ),
            Opacity(
              opacity: 0.5,
              child: Image.asset(
                AppDecoration.writePrescription,
                width: AppDecoration().screenWidth * 0.16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
