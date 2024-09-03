import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/feature/home/model_test/controller/model_test_view_controller.dart';
import 'package:science_platform/src/feature/home/model_test/widget/model_test_card.dart';
import 'package:science_platform/src/widgets/error_feedback.dart';
import 'package:science_platform/src/widgets/has_no_data_feedback.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';
import 'package:science_platform/src/widgets/pill_title.dart';

class ModelTestsBuilder extends StatelessWidget {
  const ModelTestsBuilder({
    super.key,
    required this.controller,
  });
  final ModelTestViewController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading) {
        return LoadingIndicator.list();
      }
      if (controller.pageState == PageState.error) {
        return GenericErrorFeedback(
          onTap: () {
            controller.getModelTestData();
          },
        );
      }
      if (!controller.hasQuestionBankData) {
        return RefreshIndicator(
          onRefresh: () async {
            controller.getModelTestData();
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: SizedBox(
              height: 350,
              child: HasNoDataFeedback(
                imageWidth: 150,
                onRefresh: () => controller.getModelTestData(),
              ),
            ),
          ),
        );
      }
      return Column(
        children: [
          const PillTitle(title: 'সকল মডেল টেস্ট'),
          const SizedBox(height: 20),
          RefreshIndicator(
            onRefresh: () async {
              controller.getModelTestData();
            },
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: .7,
              ),
              itemCount: controller.modelTests.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index) {
                CourseModel modelTest = controller.modelTests[index];
                return ModelTestCard(
                  modelTest: modelTest,
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
