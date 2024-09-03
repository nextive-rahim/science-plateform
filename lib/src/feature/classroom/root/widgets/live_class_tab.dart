import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/classroom/root/controller/live_activity_controller.dart';
import 'package:science_platform/src/feature/classroom/root/model/today_event_model.dart';
import 'package:science_platform/src/feature/courses/root/controller/course_details_view_controller.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/enums.dart';
import 'package:science_platform/src/utils/extensions/string_extension.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/has_no_data_feedback.dart';
import 'package:science_platform/src/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveClassTab extends StatelessWidget {
  const LiveClassTab({
    super.key,
    required this.controller,
  });

  final LiveActivityController controller;

  @override
  Widget build(BuildContext context) {
    return controller.todaysClasses.isEmpty
        ? SizedBox(
            height: 150,
            child: HasNoDataFeedback(
              imageHeight: 100,
              onRefresh: () async {
                controller.fetchHappeningToday();
              },
            ),
          )
        : RefreshIndicator(
            onRefresh: () async {
              controller.fetchHappeningToday();
            },
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              primary: true,
              shrinkWrap: true,
              itemCount: controller.todaysClasses.length,
              itemBuilder: (BuildContext context, int index) {
                TodayEventModel todaysClass = controller.todaysClasses[index];
                return _LiveClassCard(liveClass: todaysClass);
              },
            ),
          );
  }
}

class _LiveClassCard extends StatefulWidget {
  const _LiveClassCard({
    required this.liveClass,
  });

  final TodayEventModel liveClass;

  @override
  State<_LiveClassCard> createState() => _LiveClassCardState();
}

class _LiveClassCardState extends State<_LiveClassCard> {
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
                  widget.liveClass.title,
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
                  widget.liveClass.course.title,
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
              _buildButton()
            ],
          ),
        ],
      ),
    );
  }

  _buildButton() {
    return RoundedButton(
      title: widget.liveClass.isAvailableClass
          ? TextConstants.joinClass
          : getFormattedTime(widget.liveClass.availableFrom),
      onPressed: widget.liveClass.isAvailableClass
          ? () async {
              if (widget.liveClass.course.subscriptionStatus?.status !=
                  'active') {
                Get.find<CourseDetailsViewController>()
                    .fetchCourseDetails(widget.liveClass.course.slug);
                Get.toNamed(Routes.courseDetails);
              } else {
                if (widget.liveClass.video?.source ==
                        VideoSourceType.youtube.name ||
                    widget.liveClass.video?.source ==
                        VideoSourceType.vimeo.name ||
                    widget.liveClass.video?.source ==
                        VideoSourceType.embedded.name) {
                  Get.toNamed(
                    Routes.courseVideo,
                    arguments: widget.liveClass.video,
                  );
                } else {
                  await _launchUrl(widget.liveClass.video?.link ?? '');
                }
              }
            }
          : null,
    );
  }

  Future<void> _launchUrl(String videoLink) async {
    if (await canLaunchUrl(Uri.parse(videoLink))) {
      await launchUrl(
        Uri.parse(videoLink),
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
