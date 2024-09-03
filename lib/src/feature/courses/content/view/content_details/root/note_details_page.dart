import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/feature/courses/content/controller/contents_view_controller.dart';
import 'package:science_platform/src/widgets/error_feedback.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';

class NoteDetailsPage extends GetView<ContentsViewController> {
  const NoteDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.singleContentIsLoading
                ? ''
                : (controller.contentModel?.title ?? ''),
          ),
        ),
      ),
      body: Obx(
        () {
          if (controller.singleContentIsLoading) {
            return LoadingIndicator.list();
          }
          if (controller.singleContentHasError) {
            return const GenericErrorFeedback();
          } else {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lightBlack20.withOpacity(0.7),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: HtmlWidget(controller.contentModel?.note?.body ?? ''),
              ),
            );
          }
        },
      ),
    );
  }
}
