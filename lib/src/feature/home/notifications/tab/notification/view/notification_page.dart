import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        TextConstants.comingSoon,
        style: AppTextStyle.bold16,
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 10,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(
          color: const Color(0xFF2B2B2B).withOpacity(0.20),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "আপনার কোর্সটি সফলভাবে সাবস্ক্রাইব হয়েছে",
              style: AppTextStyle.regular14.copyWith(
                color: AppColors.darkerGrey,
              ),
            ),
            DefaultTextStyle(
              style: AppTextStyle.regular12.copyWith(
                color: AppColors.primary,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("জুন,০৬,২০২২"),
                  SizedBox(height: 5),
                  Text("বিকাল ৫:২০"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
