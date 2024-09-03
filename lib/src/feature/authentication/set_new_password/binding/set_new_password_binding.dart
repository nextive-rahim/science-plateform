import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:science_platform/src/feature/authentication/set_new_password/controller/set_new_password_view_controller.dart';

class SetNewPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SetNewPasswordViewController(), fenix: true);
  }
}
