import 'package:science_platform/src/feature/home/model_test/controller/model_test_view_controller.dart';
import 'package:get/get.dart';

class QuestionBankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ModelTestViewController(), fenix: true);
  }
}
