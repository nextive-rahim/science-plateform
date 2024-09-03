import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/utils/assets.dart';
import 'package:science_platform/src/utils/extensions/generic_extension.dart';
import 'package:flutter/material.dart';

class GenericErrorFeedback extends StatelessWidget {
  const GenericErrorFeedback({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset(Assets.error),
          const Text(
            "Opps!",
            style: TextStyle(
              color: AppColors.darkerGrey,
              fontWeight: FontWeight.bold,
              fontSize: 35,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Looks like something went wrong. Please try again later",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.darkerGrey,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          Visibility(
            visible: onTap.isNotNull,
            child: TextButton(
              onPressed: onTap,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.refresh),
                  SizedBox(width: 10),
                  Text(
                    "Try Again",
                    textScaleFactor: 1,
                    style: AppTextStyle.bold16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
