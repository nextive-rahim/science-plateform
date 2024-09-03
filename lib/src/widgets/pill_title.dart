import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class PillTitle extends StatelessWidget {
  const PillTitle({
    super.key,
    required this.title,
    this.fontSize,
  });

  final String title;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
            height: 10,
            width: 4,
            decoration: const BoxDecoration(color: AppColors.primary),
            padding: const EdgeInsets.only(top: 15),
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              title,
              maxLines: 3,
              style: AppTextStyle.bold16.copyWith(
                height: 0,
                fontSize: fontSize ?? 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
