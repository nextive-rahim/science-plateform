import 'package:science_platform/src/feature/courses/free_courses/controller/free_courses_view_controller.dart';
import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/course_card.dart';
import 'package:science_platform/src/widgets/error_feedback.dart';
import 'package:science_platform/src/widgets/has_no_data_feedback.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FreeClassesPage extends GetView<FreeCoursesViewController> {
  const FreeClassesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextConstants.freeClass),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _BuildFreeCourses(
          controller: controller,
        ),
      ),
    );
  }
}

class _BuildFreeCourses extends StatelessWidget {
  const _BuildFreeCourses({
    required this.controller,
  });

  final FreeCoursesViewController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading) {
        return LoadingIndicator.list();
      }
      if (controller.hasError) {
        return GenericErrorFeedback(
          onTap: () async => controller.getFreeClasses(),
        );
      } else {
        return (controller.freeCourses.isNotEmpty)
            ? RefreshIndicator(
                onRefresh: () async => controller.getFreeClasses(),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: controller.freeCourses.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 140,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    CourseModel course = controller.freeCourses[index];
                    return CourseCard(
                      course: course,
                      showDetails: false,
                    );
                  },
                ),
              )
            : HasNoDataFeedback(
                onRefresh: () async => controller.getFreeClasses(),
              );
      }
    });
  }
}
