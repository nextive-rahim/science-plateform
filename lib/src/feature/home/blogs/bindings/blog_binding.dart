import 'package:science_platform/src/feature/home/blogs/controller/blog_view_controller.dart';
import 'package:get/get.dart';

class BlogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BlogViewController(), fenix: true);
  }
}
