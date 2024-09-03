import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/feature/courses/sections/controller/course_sections_view_controller.dart';
import 'package:science_platform/src/feature/courses/sections/model/section_model.dart';
import 'package:science_platform/src/feature/courses/sections/widgets/course_section_card.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/error_feedback.dart';
import 'package:science_platform/src/widgets/has_no_data_feedback.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';

class CourseSectionsPage extends GetView<CourseSectionsViewController> {
  const CourseSectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColorDark,
      appBar: AppBar(
        title: Obx(() {
          if (controller.pageState == PageState.loading) {
            return const Text(TextConstants.courseContent);
          }
          return Text(
              controller.courseModel?.title ?? TextConstants.courseContent);
        }),
      ),
      body: Obx(
        () {
          if (controller.pageState == PageState.loading) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: LoadingIndicator.list(),
            );
          } else if (controller.pageState == PageState.error) {
            return const GenericErrorFeedback();
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                controller.getCourseSectionsAndContents(
                    controller.sectionsCourseSlug!);
              },
              child: Stack(
                children: [
                  controller.sectionHasData
                      ? _SectionBuilder(controller: controller)
                      : HasNoDataFeedback(
                          onRefresh: () async {
                            controller.getCourseSectionsAndContents(
                                controller.sectionsCourseSlug!);
                          },
                        )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class _SectionBuilder extends StatelessWidget {
  const _SectionBuilder({
    required this.controller,
  });

  final CourseSectionsViewController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: 50,
      ),
      itemCount: controller.sections.length,
      itemBuilder: (BuildContext context, int index) {
        SectionModel section = controller.sections[index];
        return CourseSectionCard(
          section: section,
          index: index,
        );
      },
    );
  }
}
