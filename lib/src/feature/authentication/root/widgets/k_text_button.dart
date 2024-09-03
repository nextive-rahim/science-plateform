import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class KTextButton extends StatelessWidget {
  final Function() onTap;
  final bool? isBig;
  final String label;

  const KTextButton({
    super.key,
    required this.onTap,
    required this.label,
    this.isBig = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: isBig == true
            ? AppTextStyle.bold14.copyWith(
                color: AppColors.primary,
              )
            : AppTextStyle.medium12.copyWith(
                color: AppColors.primary,
              ),
      ),
    );
  }
}
