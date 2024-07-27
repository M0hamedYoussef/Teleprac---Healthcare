import 'package:flutter/material.dart';
import 'package:teleprac/core/const/colors.dart';

class LockIcon extends StatelessWidget {
  const LockIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.lock,
      color: AppColors.red,
      size: 100,
    );
  }
}
