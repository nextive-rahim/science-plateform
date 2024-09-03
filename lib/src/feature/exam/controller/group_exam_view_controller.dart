import 'package:science_platform/src/core/exception/error_handler.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/courses/content/model/contents/exam_model.dart';
import 'package:science_platform/src/feature/exam/repository/exam_repository.dart';
import 'package:science_platform/src/feature/home/model_test/models/model_test_models/group_exam_subject_model.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:get/get.dart';

class GroupExamViewController extends GetxController {
  /// Repository
  final ExamRepository _repository = ExamRepository();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);

  get pageState => _pageStateController.value;

  bool get isLoading => pageState == PageState.loading;
  Rx<int?> isSubSelected = 0.obs;

  void subSelected(index) {
    isSubSelected.value = index;
  }

  late ExamModel exam;
  final groupSubjects = <GroupExamSubjectModel>[].obs;
  final selectedSubjects = <GroupExamSubjectModel>[].obs;

  selectedSubject(GroupExamSubjectModel subject) {
    if (selectedSubjects.contains(subject)) {
      selectedSubjects.remove(subject);
    } else {
      if (selectedSubjects.length != exam.totalSubject) {
        selectedSubjects.add(subject);
      }
    }
  }

  Future<void> getExamInformation(int id) async {
    _pageStateController(PageState.loading);
    try {
      final res = await _repository.fetchExamDetails(id);
      exam = ExamModel.fromJson(res['data']);
      if (exam.isGroupExam) {
        groupSubjects.value = exam.subjects!;
        for (var element in groupSubjects) {
          if (element.isRequired == true) {
            selectedSubjects.add(element);
          }
        }
      }

      _pageStateController(PageState.success);
      _updateButtonTitleBasedOnExamMode();
    } catch (e, stackTrace) {
      _pageStateController(PageState.error);
      errorHandler(e, stackTrace);
    }
  }

  String buttonTitle = '';

  void _updateButtonTitleBasedOnExamMode() {
    if (exam.isPracticeExam) {
      buttonTitle = TextConstants.startPracticeButton;
    } else {
      if (exam.isExamAvailable) {
        buttonTitle = TextConstants.startExamButton;
      } else {
        buttonTitle = TextConstants.checkAnalysis;
      }
    }
  }
}
