import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:science_platform/src/core/service/cache/cache_keys.dart';
import 'package:science_platform/src/core/service/cache/cache_service.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/classroom/root/controller/live_activity_controller.dart';
import 'package:science_platform/src/feature/classroom/root/model/today_event_exam_model.dart';
import 'package:science_platform/src/feature/classroom/root/model/today_event_model.dart';
import 'package:science_platform/src/feature/courses/root/controller/course_details_view_controller.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/enums.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/has_no_data_feedback.dart';
import 'package:flutter/material.dart';
import 'package:science_platform/src/widgets/rounded_button.dart';

class LiveExamTab extends StatelessWidget {
  const LiveExamTab({
    super.key,
    required this.controller,
  });

  final LiveActivityController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.todaysExam.isEmpty) {
      return SizedBox(
        height: 150,
        child: HasNoDataFeedback(
          imageHeight: 100,
          onRefresh: () async {
            controller.fetchHappeningToday();
          },
        ),
      );
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          controller.fetchHappeningToday();
        },
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.todaysExam.length,
          itemBuilder: (BuildContext context, int index) {
            TodayEventModel exam = controller.todaysExam[index];

            return _LiveExamCard(exam: exam);
          },
        ),
      );
    }
  }
}

class _LiveExamCard extends StatefulWidget {
  final TodayEventModel exam;

  const _LiveExamCard({
    required this.exam,
  });

  @override
  State<_LiveExamCard> createState() => _LiveExamCardState();
}

class _LiveExamCardState extends State<_LiveExamCard> {
  TaskCondition? taskCondition;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? currentTime;

  bool isExam = true;

  TodayEventExamModel? normalExam;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: AppColors.primary,
          width: 0.5,
        ),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.exam.title,
                  style: AppTextStyle.bold16.copyWith(
                    height: 24 / 16,
                    color: AppColors.lightBlack90,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.exam.course.title,
                  style: AppTextStyle.bold12.copyWith(
                    height: 18 / 12,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  TextConstants.today,
                  style: AppTextStyle.bold12.copyWith(
                    height: 18 / 12,
                    color: AppColors.darkGreen,
                  ),
                ),
              ),
              _buildButton(todaysExam: widget.exam),
            ],
          ),
        ],
      ),
    );
  }

  _buildButton({required TodayEventModel todaysExam}) {
    String token = CacheService.boxAuth.read(CacheKeys.token);
    return RoundedButton(
      backgroundColor:
          todaysExam.exam!.isAvailableExam ? AppColors.primary : Colors.grey,
      title: todaysExam.exam!.getExamButtonTitle,
      onPressed: todaysExam.exam!.isAvailableExam
          ? () {
              if (todaysExam.course.subscriptionStatus?.status != 'active') {
                Get.find<CourseDetailsViewController>()
                    .fetchCourseDetails(todaysExam.course.slug);
                Get.toNamed(Routes.courseDetails);
              } else {
                if (!isExam) {
                  Get.toNamed(Routes.writtenExamInfo,
                      arguments: todaysExam.exam!.id);
                  return;
                }
                Get.toNamed(Routes.examWebviewPage, arguments: [
                  'https://exam-esquare-app.vercel.app/exams/${todaysExam.slug}/$token',
                  todaysExam.title,
                ]);
              }
            }
          : null,
    );
  }
}
