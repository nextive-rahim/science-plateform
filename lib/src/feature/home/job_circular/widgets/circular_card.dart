import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/home/job_circular/controller/circular_view_controller.dart';
import 'package:science_platform/src/feature/home/job_circular/model/circular_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/routes/app_pages.dart';

class CircularCard extends StatelessWidget {
  const CircularCard({
    super.key,
    required this.circular,
  });

  final JobCircularModel circular;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.put(CircularViewController()).getCircularDetails(circular.slug!);
        Get.toNamed(Routes.circularDetails);
      },
      child: Container(
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10,
        ),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              circular.title ?? '',
              style: AppTextStyle.semibold14,
            ),
            const Text(''),
            DefaultTextStyle(
              style: AppTextStyle.regular12.copyWith(
                color: AppColors.primary,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(circular.time ?? ''),
                  Text(circular.date ?? ''),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
