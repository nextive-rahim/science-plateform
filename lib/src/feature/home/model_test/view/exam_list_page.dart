import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/home/model_test/controller/model_test_view_controller.dart';
import 'package:science_platform/src/feature/home/model_test/models/model_test_model.dart';
import 'package:science_platform/src/feature/home/model_test/widget/exam_card.dart';
import 'package:science_platform/src/widgets/error_feedback.dart';
import 'package:science_platform/src/widgets/has_no_data_feedback.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExamListPage extends GetView<ModelTestViewController> {
  const ExamListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return (controller.isLoading)
              ? const Text('')
              : Text(controller.modelTest.title ?? '');
        }),
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return LoadingIndicator.list();
        }
        if (controller.pageState == PageState.error) {
          return GenericErrorFeedback(
            onTap: () {
              controller.getModelTestDetails(controller.modelTest.slug);
            },
          );
        }
        if (controller.hasContents) {
          return RefreshIndicator(
            onRefresh: () async {
              controller.getModelTestDetails(controller.modelTest.slug);
            },
            child: ListView.builder(
              itemCount: controller.modelTest.contents?.length,
              padding: const EdgeInsets.only(
                top: 25,
                left: 20,
                right: 20,
                bottom: 50,
              ),
              itemBuilder: ((context, index) {
                ModelTestContentModel contentModel =
                    controller.modelTest.contents![index];
                return ExamCard(
                  contentModel: contentModel,
                );
              }),
            ),
          );
        } else {
          return HasNoDataFeedback(
            onRefresh: () async {
              controller.getModelTestDetails(controller.modelTest.slug);
            },
          );
        }
      }),
    );
  }
}
