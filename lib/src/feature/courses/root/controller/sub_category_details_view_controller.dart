import 'package:get/get.dart';
import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/courses/root/model/category_model.dart';
import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/feature/courses/root/repository/course_repository.dart';

class SubCategoryDetailsViewController extends GetxController {
  final CourseRepository repository = CourseRepository();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);
  get pageState => _pageStateController.value;

  CategoryModel? categoryModel;
  List<CourseModel> courses = [];
  List<CategoryModel> subCategories = [];

  Future<void> getCourseList(String slug) async {
    _pageStateController(PageState.loading);

    try {
      final res = await repository.fetchCategoryWithCourses(slug: slug);

      categoryModel = CategoryModel.fromJson(res['data']);
      courses = categoryModel?.courses ?? [];
      subCategories = categoryModel?.courseCategories ?? [];
      _pageStateController(PageState.success);
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
      Get.snackbar(
        'Failed',
        'Something went wrong while fetching category wise courses',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
