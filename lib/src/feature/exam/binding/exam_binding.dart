import 'package:science_platform/src/feature/exam/controller/exam_analysis_view_controller.dart';
import 'package:science_platform/src/feature/exam/controller/exam_view_controller.dart';
import 'package:science_platform/src/feature/exam/controller/group_exam_view_controller.dart';
import 'package:get/get.dart';

class ExamInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GroupExamViewController(), fenix: true);
  }
}

class ExamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExamViewController(), fenix: true);
  }
}

class ExamAnalysisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExamAnalysisViewController(), fenix: true);
  }
}
