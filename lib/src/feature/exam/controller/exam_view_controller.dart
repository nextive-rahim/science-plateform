import 'dart:async';

import 'package:science_platform/src/core/exception/error_handler.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/courses/content/controller/contents_view_controller.dart';
import 'package:science_platform/src/feature/courses/content/model/contents/contents_b.dart';
import 'package:science_platform/src/feature/exam/controller/group_exam_view_controller.dart';
import 'package:science_platform/src/feature/exam/model/submit_exam_model.dart';
import 'package:science_platform/src/feature/exam/repository/exam_repository.dart';
import 'package:science_platform/src/feature/home/model_test/models/model_test_models/exam_result_model.dart';
import 'package:get/get.dart';

class ExamViewController extends GetxController {
  final ExamRepository _repository = ExamRepository();
  final ContentsViewController _contentsViewController =
      Get.find<ContentsViewController>();
  final GroupExamViewController _examInfoViewController =
      Get.find<GroupExamViewController>();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);

  get pageState => _pageStateController.value;

  bool get isLoading => pageState == PageState.loading;

  late ExamModel examModel;
  late SubmitExamModel submitModel;
  late ExamResultModel resultModel;
  List<SubmitExamAnswerModel> selectedAnswersList = [];

  ExamModel? practiceExamModel;

  bool startTimer = false;

  Future<void> getExamDetails(id) async {
    _pageStateController(PageState.loading);

    try {
      final res = await _repository.fetchExamDetails(id);
      examModel = ExamModel.fromJson(res['data']);
      startTimer = true;

      if (examModel.isPracticeExam) {
        practiceExamModel = examModel;
      }

      if (examModel.isExamAttended) {
        resultModel = examModel.result!;
      }

      if (!examModel.isPracticeExam) {
        if (examModel.isExamAvailable) {
          await sendExamStartingTime(examModel.id!);
        }
      }

      clearData();
      _pageStateController(PageState.success);
    } catch (e, stackTrace) {
      _pageStateController(PageState.error);
      errorHandler(e, stackTrace);
    }
  }

  Future<void> sendExamStartingTime(int examId) async {
    submitModel = SubmitExamModel(
      examId: examId,
      submitted: 0,
      answers: [],
    );

    await _repository.submitExam(submitModel.toJson());
  }

  void clearData() {
    selectedAnswersList = [];
    submitModel = SubmitExamModel();
    submitModel.answers?.clear();
  }

  void updateSelectedAnswerList(SubmitExamAnswerModel selectedOption) {
    selectedAnswersList.add(selectedOption);
    if (examModel.isPracticeExam &&
        practiceExamModel != null &&
        practiceExamModel!.mcqs != null &&
        practiceExamModel!.mcqs!.isNotEmpty) {
      for (var mcq in practiceExamModel!.mcqs!) {
        if (mcq?.id == selectedOption.mcqId) {
          mcq!.userAnswer = selectedOption.userAnswer;
        }
      }
    }
  }

  Future<void> submitAnswer() async {
    _pageStateController(PageState.loading);

    if (examModel.isPracticeExam) {
      startTimer = false;
      _pageStateController(PageState.success);
      return;
    }

    submitModel = SubmitExamModel(
      examId: examModel.id,
      submitted: 1,
      answers: selectedAnswersList,
      subjects: _examInfoViewController.selectedSubjects
          .map((element) => element.id)
          .toList(),
    );

    try {
      final res = await _repository.submitExam(submitModel.toJson());
      resultModel = ExamResultModel.fromJson(res['data']);
      startTimer = false;
      final examDetailsResponse =
          await _repository.fetchExamDetails(examModel.id);
      examModel = ExamModel.fromJson(examDetailsResponse['data']);
      await _contentsViewController.updateContentIdOfVideoExam();
      _pageStateController(PageState.success);
    } catch (e, stackTrace) {
      _pageStateController(PageState.error);
      errorHandler(e, stackTrace);
    }
  }

  @override
  void onClose() {
    super.onClose();
    clearData();
  }
}
