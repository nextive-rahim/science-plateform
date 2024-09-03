import 'package:get/get.dart';
import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/courses/root/model/category_model.dart';
import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/feature/home/root/models/advertisement_model.dart';
import 'package:science_platform/src/feature/home/root/models/home_response_model.dart';
import 'package:science_platform/src/feature/home/root/repository/home_repository.dart';

class HomeViewController extends GetxController {
  final HomeRepository _repository = HomeRepository();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);
  get pageState => _pageStateController.value;
  bool get isLoading => pageState == PageState.loading;

  HomeResponseModel? _homeResponseModel;
  List<AdvertisementModel> advertisements = [];
  List<CategoryModel>? courseCategories;
  List<CourseModel> featuredCourses = [];
  List<CourseModel> featuredModelTests = [];

  @override
  void onInit() {
    super.onInit();
    getHomeContents();
  }

  Future<void> getHomeContents() async {
    _pageStateController(PageState.loading);

    try {
      final res = await _repository.fetchHomeContents();
      _homeResponseModel = HomeResponseModel.fromJson(res);
      courseCategories = _homeResponseModel?.courseCategories ?? [];
      featuredCourses = _homeResponseModel?.courses ?? [];
      advertisements = _homeResponseModel?.advertisement ?? [];
      _pageStateController(PageState.success);
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
      Get.snackbar(
        'Failed',
        'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
