import 'package:get/get.dart';
import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/courses/root/model/course_list_response_model.dart';
import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/feature/courses/root/repository/course_repository.dart';
import 'package:science_platform/src/feature/home/model_test/repository/model_test_repository.dart';

class ClassroomViewController extends GetxController {
  final CourseRepository _courseRepository = CourseRepository();
  final ModelTestRepository _modelTestrepository = ModelTestRepository();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);
  final Rx<PageState> _modeltestStateController = Rx(PageState.initial);

  get pageState => _pageStateController.value;
  get modeltestState => _pageStateController.value;

  bool get isLoading => pageState == PageState.loading;

  bool get hasError => pageState == PageState.error;

  /// My courses
  late CourseListResponseModel courseModel;
  List<CourseModel> myCourses = [];
  List<CourseModel> myModelTests = [];

  @override
  void onInit() async {
    super.onInit();
    fetchMyCourses();
    // getMyModelTest();
  }

  Future<void> fetchMyCourses() async {
    _pageStateController(PageState.loading);
    try {
      final res = await _courseRepository.fetchMyCourse();
      courseModel = CourseListResponseModel.fromJson(res);
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
      Get.snackbar(
        'Failed',
        'Fetching my courses failed',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    myCourses = courseModel.data!;
    _pageStateController(PageState.success);
  }

  Future<void> getMyModelTest() async {
    _modeltestStateController(PageState.loading);
    try {
      final res = await _modelTestrepository.fetchMyModelTest();
      courseModel = CourseListResponseModel.fromJson(res);
      myModelTests = courseModel.data!;
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
      Get.snackbar(
        'Failed',
        'Fetching my Model Test failed',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    _modeltestStateController(PageState.success);
  }
}
