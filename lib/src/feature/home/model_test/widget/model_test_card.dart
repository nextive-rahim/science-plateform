import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/feature/courses/sections/controller/course_sections_view_controller.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/app_constants.dart';

class ModelTestCard extends StatelessWidget {
  const ModelTestCard({
    super.key,
    required this.modelTest,
    this.showDetails = true,
  });

  final CourseModel modelTest;
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
              Flexible(
                flex: 6,
                child: Image.network(
                  modelTest.image?.link ?? noImageFoundURL,
                  fit: BoxFit.cover,
                  height: double.infinity,
                ),
              ),
              Flexible(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(top: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        modelTest.title!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.semibold14.copyWith(
                          height: 0,
                          color: AppColors.lightBlack90,
                        ),
                      ),
                      const Spacer(),
                      (showDetails == true)
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildPrice(modelTest),
                              ],
                            )
                          : const SizedBox(),
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
    if (modelTest.isSubscribed) {
      Get.find<CourseSectionsViewController>()
          .getCourseSectionsAndContents(modelTest.slug!);
      Get.toNamed(
        Routes.courseSections,
        arguments: modelTest.title,
      );
    } else {
      Get.toNamed(
        Routes.courseDetails,
        arguments: modelTest.slug,
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
