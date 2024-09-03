import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/home/model_test/models/model_test_model.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/assets.dart';
import 'package:science_platform/src/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExamCard extends StatelessWidget {
  const ExamCard({
    super.key,
    required this.contentModel,
  });

  final ModelTestContentModel contentModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (contentModel.exam?.mode == ExamType.group.name) {
          Get.snackbar(
            'Coming Soon!',
            'Not available in app. Check website for group exam.',
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }
        Get.toNamed(
          Routes.examInfo,
          arguments: [
            contentModel.exam!.id!,
            contentModel.title,
          ],
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.lightBlack20,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  Assets.examIcon,
                  fit: BoxFit.cover,
                  height: 30,
                  width: 30,
                ),
                const SizedBox(width: 12),
                Text(
                  contentModel.title ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.medium14,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
