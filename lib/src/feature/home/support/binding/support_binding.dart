import 'package:science_platform/src/feature/home/support/controller/support_view_controller.dart';
import 'package:get/get.dart';

class SupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SupportViewController(), fenix: true);
  }
}
