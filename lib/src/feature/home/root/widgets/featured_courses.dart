import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/core/widgets/shimmer_gradview_builder.dart';
import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/feature/home/root/controllers/home_view_controller.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/course_card.dart';
import 'package:science_platform/src/widgets/error_feedback.dart';
import 'package:science_platform/src/widgets/has_no_data_feedback.dart';

class HomeFeaturedCourse extends GetView<HomeViewController> {
  const HomeFeaturedCourse({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                TextConstants.featuredCourses,
                style: AppTextStyle.bold16.copyWith(
                  height: 25 / 16,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Obx(() {
            if (controller.pageState == PageState.loading) {
              return const ShimmerGridViewBuilder(
                itemCount: 4,
                childAspectRatio: 148 / 164,
              );
            }
            if (controller.pageState == PageState.error) {
              return const GenericErrorFeedback();
            }

            if (controller.featuredCourses.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(10),
                child: HasNoDataFeedback(
                  canRefresh: false,
                  imageHeight: 60,
                ),
              );
            }

            return SizedBox(
              height: 245,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.featuredCourses.length,
                primary: false,
                padding: const EdgeInsets.only(
                  bottom: 5,
                ),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, courseIndex) {
                  CourseModel course = controller.featuredCourses[courseIndex];
                  return Container(
                    width: 280,
                    margin: const EdgeInsets.only(right: 15),
                    child: CourseCard(course: course),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
