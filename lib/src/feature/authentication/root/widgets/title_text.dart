import 'package:flutter/material.dart';
import 'package:science_platform/src/core/theme/text_style.dart';

class TitleText extends StatelessWidget {
  final String text;

  const TitleText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyle.semibold20,
    );
  }
}
