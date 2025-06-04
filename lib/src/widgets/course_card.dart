import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/feature/courses/sections/controller/course_sections_view_controller.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/app_constants.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.course,
    this.showDetails = true,
  });

  final CourseModel course;
  final bool? showDetails;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.white,
          border: Border.all(
            width: 1,
            color: AppColors.lightBlack10,
          ),
        ),
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CachedNetworkImage(
                    imageUrl: course.image?.link ?? noImageFoundURL,
                    cacheKey: course.image?.link ?? noImageFoundURL,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    memCacheHeight: 260,
                    memCacheWidth: 426,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.title!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textScaleFactor: 1,
                        style: AppTextStyle.medium14.copyWith(
                          height: 0,
                          color: AppColors.lightBlack90,
                        ),
                      ),
                      // const Spacer(),
                      // (showDetails == true)
                      //     ? Row(
                      //         crossAxisAlignment: CrossAxisAlignment.end,
                      //         children: [
                      //           _buildPrice(course),
                      //         ],
                      //       )
                      //     : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTap() {
    if (course.isSubscribed) {
      Get.find<CourseSectionsViewController>()
          .getCourseSectionsAndContents(course.slug!);
      Get.toNamed(
        Routes.courseSections,
        arguments: course.title,
      );
    } else {
      Get.toNamed(
        Routes.courseDetails,
        arguments: course.slug,
      );
    }
  }

  Widget _buildPrice(CourseModel course) {
    if (course.isSubscribed) {
      return Text(
        'Subscribed',
        style: AppTextStyle.bold14.copyWith(
          height: 0,
          color: AppColors.lightGreen,
        ),
      );
    }

    if (course.isFreeCourse) {
      return Text(
        'Free',
        style: AppTextStyle.bold14.copyWith(
          height: 0,
          color: AppColors.primary,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Text(
                '৳${double.parse(course.netPrice).truncate()}',
                style: AppTextStyle.bold14.copyWith(
                  height: 0,
                  color: AppColors.primary,
                ),
              ),
            ),
            course.hasDiscount
                ? Text(
                    '৳${course.price?.amount}',
                    style: AppTextStyle.medium12.copyWith(
                      height: 0,
                      color: AppColors.lightBlack80,
                      decoration: TextDecoration.lineThrough,
                    ),
                  )
                : const SizedBox(),
          ],
        )
      ],
    );
  }
}
