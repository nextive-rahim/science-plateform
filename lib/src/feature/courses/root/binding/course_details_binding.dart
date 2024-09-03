import 'package:get/get.dart';
import 'package:science_platform/src/feature/courses/purchase/course_purchase/controller/course_purchase_controller.dart';
import 'package:science_platform/src/feature/courses/root/controller/course_details_view_controller.dart';

class CourseDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CourseDetailsViewController(), fenix: true);
    Get.lazyPut(() => CoursePurchaseController(), fenix: true);
  }
}
