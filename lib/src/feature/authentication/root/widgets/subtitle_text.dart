import 'package:flutter/material.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';

class SubtitleText extends StatelessWidget {
  final String text;

  const SubtitleText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: AppTextStyle.regular14.copyWith(
        color: AppColors.lightBlack60,
      ),
    );
  }
}
