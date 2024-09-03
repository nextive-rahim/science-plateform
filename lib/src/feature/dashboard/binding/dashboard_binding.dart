import 'package:get/get.dart';
import 'package:science_platform/src/feature/classroom/root/controller/classroom_view_controller.dart';
import 'package:science_platform/src/feature/classroom/root/controller/live_activity_controller.dart';
import 'package:science_platform/src/feature/courses/purchase/checkout/controller/checkout_view_controller.dart';
import 'package:science_platform/src/feature/courses/root/controller/category_details_view_controller.dart';
import 'package:science_platform/src/feature/courses/root/controller/course_view_controller.dart';
import 'package:science_platform/src/feature/courses/root/controller/sub_category_details_view_controller.dart';
import 'package:science_platform/src/feature/dashboard/controller/dashboard_view_controller.dart';
import 'package:science_platform/src/feature/exam/controller/exam_info_view_controller.dart';
import 'package:science_platform/src/feature/home/blogs/controller/blog_view_controller.dart';
import 'package:science_platform/src/feature/home/job_circular/controller/circular_view_controller.dart';
import 'package:science_platform/src/feature/home/model_test/controller/model_test_view_controller.dart';
import 'package:science_platform/src/feature/home/notifications/tab/notice/controller/notice_view_controller.dart';
import 'package:science_platform/src/feature/home/root/controllers/home_view_controller.dart';
import 'package:science_platform/src/feature/profile/controller/profile_view_controller.dart';
import 'package:science_platform/src/feature/settings/controller/settings_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingsController());
    Get.lazyPut(() => DashboardViewController(), fenix: true);
    Get.put(ProfileViewController());
    Get.lazyPut(() => HomeViewController(), fenix: true);
    Get.lazyPut(() => ModelTestViewController(), fenix: true);
    Get.lazyPut(() => NoticeViewController(), fenix: true);

    Get.lazyPut(() => CourseTabViewController(), fenix: true);
    Get.lazyPut(() => ClassroomViewController(), fenix: true);
    Get.lazyPut(() => CircularViewController(), fenix: true);
    Get.lazyPut(() => BlogViewController(), fenix: true);
    Get.lazyPut(() => CheckoutViewController(), fenix: true);
    Get.lazyPut(() => LiveActivityController(), fenix: true);
    Get.lazyPut(() => ExamInfoViewController(), fenix: true);

    Get.lazyPut(() => CategoryDetailsViewController(), fenix: true);
    Get.lazyPut(() => SubCategoryDetailsViewController(), fenix: true);
  }
}
