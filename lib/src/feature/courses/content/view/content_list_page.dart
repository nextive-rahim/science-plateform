import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/feature/courses/content/controller/contents_view_controller.dart';
import 'package:science_platform/src/feature/courses/content/model/content_model.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/course_content_card.dart';
import 'package:science_platform/src/widgets/error_feedback.dart';
import 'package:science_platform/src/widgets/has_no_data_feedback.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';

class ContentListPage extends GetView<ContentsViewController> {
  const ContentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    String sectionTitle = Get.arguments ?? TextConstants.aboutCourseContent;
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColorDark,
      appBar: AppBar(title: Text(sectionTitle)),
      body: Obx(() {
        if (controller.isLoading) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: LoadingIndicator.list(),
          );
        }
        if (controller.hasError) {
          return const GenericErrorFeedback();
        } else {
          return _ContentBuilder(controller: controller);
        }
      }),
    );
  }
}

class _ContentBuilder extends StatelessWidget {
  const _ContentBuilder({
    required this.controller,
  });

  final ContentsViewController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.contentHasData) {
      return RefreshIndicator(
        onRefresh: () async {
          await controller.updateContentsList();
        },
        child: ListView.builder(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: 50,
          ),
          itemCount: controller.contents.length,
          itemBuilder: (BuildContext context, int index) {
            ContentModel content = controller.contents[index];
            return CourseContentCard(
              content: content,
              isEnrolled: true,
              liveModel: content.live,
            );
          },
        ),
      );
    } else {
      return HasNoDataFeedback(
        onRefresh: () async {
          await controller.updateContentsList();
        },
      );
    }
  }
}
