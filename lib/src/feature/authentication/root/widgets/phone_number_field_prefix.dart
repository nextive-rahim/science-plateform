import 'package:flutter/material.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';

class PhoneNumberFieldPrefix extends StatelessWidget {
  const PhoneNumberFieldPrefix({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 9.0),
      child: Text(
        '+88',
        style: AppTextStyle.regular14.copyWith(
          color: AppColors.lightBlack80,
          fontWeight: FontWeight.w400,
          height: 21 / 14,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
