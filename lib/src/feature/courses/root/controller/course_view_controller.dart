import 'package:get/get.dart';
import 'package:science_platform/src/core/exception/error_handler.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/courses/root/model/categories_with_courses_model.dart';
import 'package:science_platform/src/feature/courses/root/model/category_model.dart';
import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/feature/courses/root/repository/course_repository.dart';

class CourseTabViewController extends GetxController {
  final CourseRepository repository = CourseRepository();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);
  PageState get pageState => _pageStateController.value;
  bool get isLoading => pageState == PageState.loading;
  bool get hasError => pageState == PageState.error;

  /// Models
  CategoriesWithCoursesResponseModel? categoriesWithCoursesResponseModel;
  List<CategoryModel> courseCategories = [];
  List<CourseModel> allCourses = [];
  // ignore: unnecessary_cast
  Rx<CategoryModel?> selectedCategory = (null as CategoryModel?).obs;

  Future<void> selectCategory(CategoryModel? category) async {
    selectedCategory.value = category;
  }

  @override
  void onInit() {
    super.onInit();
    getCourses();
  }

  Future<void> getCourses() async {
    _pageStateController(PageState.loading);

    try {
      final res = await repository.fetchCategoryWithCourses();
      categoriesWithCoursesResponseModel =
          CategoriesWithCoursesResponseModel.fromJson(res);
      courseCategories = categoriesWithCoursesResponseModel?.data ?? [];
      if (courseCategories.isNotEmpty) {
        selectCategory(courseCategories.first);
      }

      allCourses.clear();
      for (var category in courseCategories) {
        category.courses?.forEach((course) {
          allCourses.addIf(!allCourses.contains(course), course);
        });
      }

      _pageStateController(PageState.success);
    } catch (e, stackTrace) {
      _pageStateController(PageState.error);
      errorHandler(e, stackTrace);
    }
  }
}
