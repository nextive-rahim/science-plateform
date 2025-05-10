import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/feature/classroom/root/controller/classroom_view_controller.dart';
import 'package:science_platform/src/feature/classroom/root/controller/live_activity_controller.dart';
import 'package:science_platform/src/feature/classroom/root/widgets/live_activity_tabs.dart';
import 'package:science_platform/src/feature/classroom/root/widgets/my_courses_tab.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/pill_title.dart';

class ClassroomPage extends GetView<ClassroomViewController> {
  ClassroomPage({super.key});
  final liveActivityController = Get.find<LiveActivityController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextConstants.classroom),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.updateProfilePage);
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // controller.getMyModelTest();
          controller.fetchMyCourses();
          liveActivityController.fetchHappeningToday();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const PillTitle(title: 'Special Feature'),
                MyCoursesTab(
                  controller: controller,
                ),
                // const MyModelTestCard(),
                const LiveActivityTabs(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
