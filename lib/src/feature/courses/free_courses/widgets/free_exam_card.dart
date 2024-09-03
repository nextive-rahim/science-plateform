import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/home/model_test/models/model_test_model.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/enums.dart';
import 'package:science_platform/src/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FreeExamCard extends StatelessWidget {
  const FreeExamCard({
    super.key,
    required this.contentModel,
    required this.modelTestName,
  });

  final ModelTestContentModel contentModel;
  final String modelTestName;

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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: AppColors.primary,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    contentModel.title!,
                    style: AppTextStyle.bold16.copyWith(
                      height: 24 / 16,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    modelTestName,
                    style: AppTextStyle.medium12.copyWith(
                      height: 18 / 12,
                      color: AppColors.lightBlack80,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    (contentModel.availableAt!.isAfter(DateTime.now()))
                        ? 'Today'
                        : getFormattedDate(contentModel.availableAt)!,
                    style: AppTextStyle.semibold12.copyWith(
                      height: 18 / 12,
                      color: AppColors.darkGreen,
                    ),
                  ),
                ),
                Text(
                  getFormattedTime(contentModel.availableAt)!,
                  style: AppTextStyle.semibold12.copyWith(
                    height: 18 / 12,
                    color: AppColors.darkGreen,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
