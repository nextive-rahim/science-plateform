import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/courses/content/controller/contents_view_controller.dart';
import 'package:science_platform/src/feature/courses/sections/model/section_model.dart';
import 'package:science_platform/src/routes/app_pages.dart';

class CourseSectionCard extends StatelessWidget {
  const CourseSectionCard({
    super.key,
    required this.section,
    required this.index,
  });

  final SectionModel section;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.lightBlack20.withOpacity(0.7),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.tabBackgroundColor,
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.all(2),
              child: Center(
                child: FittedBox(
                  child: Text(
                    '${index + 1}',
                    style: AppTextStyle.bold14.copyWith(
                      color: AppColors.lightBlack80,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                section.title ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.semiBold16.copyWith(
                  height: 18 / 14,
                  color: AppColors.lightBlack90,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap() {
    Get.find<ContentsViewController>().getContentList(section);
    Get.toNamed(
      Routes.courseSectionContents,
      arguments: section.title,
    );
  }
}
