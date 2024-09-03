import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/courses/root/controller/course_details_view_controller.dart';
import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/feature/courses/sections/controller/course_sections_view_controller.dart';
import 'package:science_platform/src/routes/app_pages.dart';

class MyCourseCard extends StatelessWidget {
  const MyCourseCard({
    super.key,
    required this.course,
  });

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (course.isSubscribed) {
          Get.find<CourseSectionsViewController>()
              .getCourseSectionsAndContents(course.slug!);
          Get.toNamed(
            Routes.courseSections,
            arguments: course.title,
          );
        } else {
          Get.find<CourseDetailsViewController>()
              .fetchCourseDetails(course.slug!);
          Get.toNamed(Routes.courseDetails);
        }
      },
      child: Container(
        height: 102,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.white,
          border: Border.all(
            color: AppColors.primary,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildCoverImage(),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.bold16.copyWith(
                      height: 24 / 16,
                      letterSpacing: 0.2,
                      color: AppColors.lightBlack90,
                    ),
                  ),
                  const SizedBox(height: 5),
                  course.subscriptionStatus != null
                      ? Text(
                          (course.subscriptionStatus?.status ?? ''),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.bold12.copyWith(
                            height: 0,
                            letterSpacing: 0.2,
                            color: (course.isSubscribed)
                                ? AppColors.lightGreen
                                : (course.isExpired)
                                    ? AppColors.red
                                    : AppColors.lightBlack90,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCoverImage() {
    return SizedBox(
      width: 138,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,
        child: Image.network(
          course.image?.link ?? '',
          fit: BoxFit.cover,
          height: double.infinity,
        ),
      ),
    );
  }
}
