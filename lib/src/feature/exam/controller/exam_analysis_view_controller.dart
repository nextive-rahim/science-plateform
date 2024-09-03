import 'package:science_platform/src/core/exception/error_handler.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/courses/content/model/contents/exam_model.dart';
import 'package:science_platform/src/feature/exam/controller/exam_view_controller.dart';
import 'package:science_platform/src/feature/exam/repository/exam_repository.dart';
import 'package:science_platform/src/feature/home/model_test/models/model_test_models/exam_result_model.dart';
import 'package:science_platform/src/feature/home/model_test/models/model_test_models/group_exam_subject_model.dart';
import 'package:get/get.dart';

class ExamAnalysisViewController extends GetxController {
  /// Repository
  final ExamRepository _repository = ExamRepository();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);

  get pageState => _pageStateController.value;

  bool get isLoading => pageState == PageState.loading;

  late ExamModel exam;
  ExamResultModel? result;
  ExamModel? practiceExamModel;
  bool examControllerFound = false;
  List<int?>? subjects = [];
  List<GroupExamSubjectModel>? groupSubjects = [];
  List<GroupExamSubjectModel> analysisSubjects = [];

  void checkAndAssignController() {
    examControllerFound = Get.isRegistered<ExamViewController>();
    if (examControllerFound) {
      practiceExamModel = Get.find<ExamViewController>().practiceExamModel;
    }
  }

  Future<void> getExamAnalysisReport(int id) async {
    _pageStateController(PageState.loading);

    checkAndAssignController();

    if (practiceExamModel != null && practiceExamModel!.id == id) {
      exam = practiceExamModel!;
      result = exam.result;
      _pageStateController(PageState.success);
      return;
    }

    try {
      final res = await _repository.fetchExamDetails(id);
      exam = ExamModel.fromJson(res['data']);
      result = exam.result;
      subjects = result != null ? exam.result!.subjects : [];
      groupSubjects = exam.subjects;
      _pageStateController(PageState.success);
      if (exam.mode == 'group') {
        analysisSubjects.clear();
        analysisSubjects.addAll(groupSubjects!
            .where((element) => subjects!
                .where((element2) => element.id == element2)
                .isNotEmpty)
            .toList());
      }
    } catch (e, stackTrace) {
      _pageStateController(PageState.error);
      errorHandler(e, stackTrace);
    }
  }
}
