import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/home/job_circular/controller/circular_view_controller.dart';
import 'package:science_platform/src/feature/home/job_circular/model/circular_list_model.dart';
import 'package:science_platform/src/feature/home/job_circular/widgets/circular_card.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/error_feedback.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircularsPage extends GetView<CircularViewController> {
  const CircularsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextConstants.jobCircular),
      ),
      body: RefreshIndicator(
        onRefresh: controller.getCircularList,
        child: Obx(
          () {
            if (controller.circularListState == PageState.loading) {
              return LoadingIndicator.list();
            }
            if (controller.circularListState == PageState.error) {
              return const GenericErrorFeedback();
            } else {
              return ListView.builder(
                padding: const EdgeInsets.only(top: 20),
                itemCount: controller.circularList.length,
                itemBuilder: (context, index) {
                  JobCircularModel notice = controller.circularList[index];
                  return CircularCard(
                    circular: notice,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
