import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/classroom/root/controller/live_activity_controller.dart';
import 'package:science_platform/src/feature/classroom/root/widgets/live_class_tab.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/widgets/pill_title.dart';
import 'live_exam_tab.dart';

class LiveActivityTabs extends GetView<LiveActivityController> {
  const LiveActivityTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const PillTitle(title: 'Upcoming Events'),
          TabBar(
            indicatorWeight: 0,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: const BoxDecoration(),
            indicatorPadding: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 0,
            ),
            labelColor: AppColors.black,
            unselectedLabelColor: AppColors.lightBlack60,
            labelPadding: const EdgeInsets.only(
              left: 50,
              right: 50,
            ),
            unselectedLabelStyle: AppTextStyle.medium16.copyWith(
              height: 21 / 16,
            ),
            labelStyle: AppTextStyle.bold16.copyWith(
              height: 21 / 16,
            ),
            tabs: const [
              Tab(text: TextConstants.todaysClass),
              Tab(text: TextConstants.todaysExam),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 250,
            child: Obx(
              () => controller.pageState == PageState.loading ||
                      controller.assignmentPageState == PageState.loading
                  ? LoadingIndicator.list().paddingSymmetric(horizontal: 20)
                  : TabBarView(
                      children: [
                        SingleChildScrollView(
                          child: LiveClassTab(controller: controller),
                        ),
                        SingleChildScrollView(
                          child: LiveExamTab(controller: controller),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
