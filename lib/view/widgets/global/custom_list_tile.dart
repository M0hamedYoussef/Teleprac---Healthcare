import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.onTap,
    required this.title,
    this.icon,
    this.image,
  });
  final void Function() onTap;
  final String title;
  final IconData? icon;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        child: ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          title: Text(
            title,
            style: const TextStyle(
              fontFamily: AppDecoration.cairo,
            ),
          ),
          trailing: image == null
              ? Icon(
                  icon,
                  color: AppColors.black,
                )
              : Image.asset(
                  image!,
                  width: AppDecoration().screenWidth * 0.06,
                ),
        ),
      ),
    );
  }
}
