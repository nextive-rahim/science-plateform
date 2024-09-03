import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/courses/root/model/course_list_response_model.dart';
import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/feature/home/model_test/models/model_test_model.dart';
import 'package:science_platform/src/feature/home/model_test/models/question_bank_item_model.dart';
import 'package:science_platform/src/feature/home/model_test/models/question_bank_varsity_model.dart';
import 'package:science_platform/src/feature/home/model_test/repository/model_test_repository.dart';
import 'package:science_platform/src/utils/extensions/generic_extension.dart';
import 'package:get/get.dart';

class ModelTestViewController extends GetxController {
  final ModelTestRepository _repository = ModelTestRepository();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);

  get pageState => _pageStateController.value;

  bool get isLoading => pageState == PageState.loading;

  // bool get hasError => pageState == PageState.error;

  /// Subject Selection
  Rx<int?> isSubSelected = (-1).obs;

  void subSelectedIndex(index) {
    isSubSelected.value = index;
  }

  /// Question Page
  RxBool isAppbarShow = false.obs;

  bool get hasQuestionBankData =>
      modelTests.isNotNull && modelTests.isNotNull && modelTests.isNotEmpty;

  bool get hasVarsities =>
      questionBankItemModel.children.isNotNull &&
      questionBankItemModel.children.isNotNull &&
      questionBankItemModel.children!.isNotEmpty;

  bool get hasUnits =>
      selectedVarsity.modelTests.isNotNull &&
      selectedVarsity.modelTests.isNotNull &&
      selectedVarsity.modelTests!.isNotEmpty;

  bool get hasContents =>
      modelTest.contents.isNotNull &&
      modelTest.contents.isNotNull &&
      modelTest.contents!.isNotEmpty;

  late CourseListResponseModel _modelTestResponseData;
  late CourseModel courseModel;
  List<CourseModel> modelTests = [];

  late QuestionBankItemModel questionBankItemModel;

  late QuestionBankVarsityModel selectedVarsity;
  late ModelTestModel modelTest = ModelTestModel();
  late ModelTestContentModel contentModel;

  String examPageRoute = '';
  String infoPageButton = '';
  bool examIsAvailable = true;

  Future<void> getModelTestData() async {
    _pageStateController(PageState.loading);
    try {
      final res = await _repository.fetchModelTestData();
      _modelTestResponseData = CourseListResponseModel.fromJson(res);
      modelTests = _modelTestResponseData.data!;
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
      Get.snackbar(
        'Failed',
        'Model tests fetching failed!',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    _pageStateController(PageState.success);
  }

  // Future<void> getQuestionBankItem(int questionBankId) async {
  //   _pageStateController(PageState.loading);
  //   try {
  //     // questionBankItemModel =
  //     //     modelTests.firstWhere((element) => element.id == questionBankId);
  //   } catch (e, stackTrace) {
  //     Log.error(e.toString());
  //     Log.error(stackTrace.toString());
  //     _pageStateController(PageState.error);
  //     Get.snackbar(
  //       'Failed',
  //       'Varsities fetching failed!',
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //     return;
  //   }
  //   _pageStateController(PageState.success);
  // }

  Future<void> getSelectedVarsity(int varsityId) async {
    _pageStateController(PageState.loading);
    try {
      selectedVarsity = questionBankItemModel.children!
          .firstWhere((element) => element.id == varsityId);
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
      Get.snackbar(
        'Failed',
        'Units fetching failed!',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    _pageStateController(PageState.success);
  }

  Future<void> getModelTestDetails(slug) async {
    _pageStateController(PageState.loading);
    try {
      final res = await _repository.fetchModelTestDetails(slug);
      modelTest = ModelTestModel.fromJson(res['data']);
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
      Get.snackbar(
        'Failed',
        'Model tests fetching failed!',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    _pageStateController(PageState.success);
  }

  Future<void> getSelectedContent(int contentId) async {
    _pageStateController(PageState.loading);
    try {
      final res = await _repository.fetchContentDetails(contentId);
      contentModel = ModelTestContentModel.fromJson(res['data']);
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
      Get.snackbar(
        'Failed',
        'Quiz fetching failed!',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    _pageStateController(PageState.success);
  }
}
