import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class ConfirmationText extends StatelessWidget {
  final String text;

  const ConfirmationText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyle.regular14.copyWith(
        color: AppColors.lightBlack60,
      ),
    );
  }
}
