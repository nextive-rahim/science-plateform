import 'package:get/get.dart';
import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/courses/free_courses/repository/free_courses_repository.dart';
import 'package:science_platform/src/feature/courses/root/model/course_list_response_model.dart';
import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/feature/courses/root/repository/course_repository.dart';
import 'package:science_platform/src/feature/home/model_test/models/model_test_model.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/assets.dart';
import 'package:science_platform/src/utils/enums.dart';
import 'package:science_platform/src/utils/extensions/generic_extension.dart';
import 'package:science_platform/src/utils/text_constants.dart';

class FreeCoursesViewController extends GetxController {
  final CourseRepository _courseRepository = CourseRepository();
  final FreeCoursesRepository _freeCoursesRepository = FreeCoursesRepository();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);

  get pageState => _pageStateController.value;

  bool get isLoading => pageState == PageState.loading;

  bool get hasError => pageState == PageState.error;

  bool get hasPreviousFreeExams =>
      modelTests.isNotNull &&
      modelTests.isNotEmpty &&
      previousFreeExams.isNotEmpty;

  bool get hasRunningFreeExams =>
      modelTests.isNotNull &&
      modelTests.isNotEmpty &&
      runningFreeExams.isNotEmpty;

  /// Tab Items
  late CourseListResponseModel _courseResponseModel;

  List<CourseModel> freeCourses = [];

  late ModelTestResponseData modelTestResponseData;
  List<ModelTestModel> modelTests = [];
  List<ModelTestModel> freeExamCategories = [];

  final List<ModelTestContentModel> freeExams = [];
  List<ModelTestContentModel> previousFreeExams = [];
  List<ModelTestContentModel> runningFreeExams = [];

  int modelTestPageNo = 1;
  final int _modelTestMetaLastPage = 100;

  String getModelTestTitle(int contentableId) {
    return modelTests
        .firstWhere((element) => element.id == contentableId)
        .title!;
  }

  void clearFreeExamLists() {
    modelTests = [];
    modelTestPageNo = 1;
    freeExams.clear();
    previousFreeExams.clear();
    runningFreeExams.clear();
  }

  Future<void> getFreeClasses() async {
    _pageStateController(PageState.loading);

    try {
      final res = await _courseRepository.fetchCourses(
        filters: [ApiFilters.free.name],
      );
      _courseResponseModel = CourseListResponseModel.fromJson(res);
      freeCourses = _courseResponseModel.data!;
      _pageStateController(PageState.success);
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
      Get.snackbar(
        'Failed',
        'Fetching free courses failed',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
  }

  Future<void> getFreeExams() async {
    if (modelTestPageNo > _modelTestMetaLastPage) {
      return;
    }

    _pageStateController(PageState.loading);

    try {
      final res = await _freeCoursesRepository.fetchFreeExams(
        filters: [ApiFilters.free.name],
        perPage: 10,
        pageNo: modelTestPageNo,
      );
      modelTestResponseData = ModelTestResponseData.fromJson(res);
      // freeExamCategories = _modelTestResponseData.data!;
      // modelTests.addAll(_modelTestResponseData.data ?? []);
      // _modelTestMetaLastPage = _modelTestResponseData.meta!.lastPage!;

      _addingExamsToAllExamLists();
      modelTestPageNo++;

      _pageStateController(PageState.success);
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
      Get.snackbar(
        'Failed',
        'Fetching free exams failed!',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
  }

  void _addingExamsToAllExamLists() {
    for (var modelTest in modelTests) {
      if (modelTest.contents != null && modelTest.contents!.isNotEmpty) {
        freeExams.addAll(modelTest.contents!);
      }

      previousFreeExams.clear();
      runningFreeExams.clear();
      _separatingExamsToProperLists(modelTest.contents!);
    }
  }

  void _separatingExamsToProperLists(List<ModelTestContentModel> contents) {
    for (var content in freeExams) {
      if (content.exam != null && content.exam!.didNotAttend) {
        previousFreeExams.add(content);
      } else {
        runningFreeExams.add(content);
      }
    }
  }

  List get freeCoursePageItems => [
        {
          'title': TextConstants.freeClass,
          'icon': Assets.freeClass,
          'onTap': () {
            getFreeClasses();
            Get.toNamed(Routes.freeClasses);
          },
        },
        {
          'title': TextConstants.freeExam,
          'icon': Assets.freeExam,
          'onTap': () {
            clearFreeExamLists();
            getFreeExams();
            Get.toNamed(Routes.freeExams);
          },
        }
      ];

  @override
  void onClose() {
    clearFreeExamLists();
    super.onClose();
  }
}
