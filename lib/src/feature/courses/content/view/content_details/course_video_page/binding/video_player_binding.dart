import 'package:science_platform/src/feature/courses/content/view/content_details/course_video_page/controller.dart/course_video_view_controller.dart';
import 'package:get/get.dart';

class VideoPlayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CourseVideoViewController(), fenix: true);
  }
}
