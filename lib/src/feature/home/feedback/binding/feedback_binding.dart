import 'package:science_platform/src/feature/home/feedback/controller/feedback_view_controller.dart';
import 'package:get/get.dart';

class FeedbackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FeedbackViewController());
  }
}
