import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/home/job_circular/model/circular_category_model.dart';
import 'package:science_platform/src/feature/home/job_circular/model/circular_details_model.dart';
import 'package:science_platform/src/feature/home/job_circular/model/circular_list_model.dart';
import 'package:science_platform/src/feature/home/job_circular/repository/circular_repository.dart';
import 'package:get/get.dart';

class CircularViewController extends GetxController {
  final JobCircularRepository _repository = JobCircularRepository();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);

  get pageState => _pageStateController.value;

  final Rx<PageState> _circularListStateController = Rx(PageState.initial);

  get circularListState => _circularListStateController.value;

  CircularCategoryResponseModel? _circularCategoryResponseModel;
  List<CircularCategoryModel> circularCategories = [];
  CircularResponseModel? _circularListResponseModel;
  List<JobCircularModel> circularList = [];

  CircularDetailsResponseModel? _circularDetailsResponseModel;
  JobCircularModel? circularDetails;
  CircularCategoryModel? selectedCategory;

  Future<void> getCircularCategories() async {
    _pageStateController(PageState.loading);

    try {
      final res = await _repository.fetchCircularCategories();
      _circularCategoryResponseModel =
          CircularCategoryResponseModel.fromJson(res);
      circularCategories = _circularCategoryResponseModel?.data ?? [];
      _pageStateController(PageState.success);
      await getCircularList();
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
    }
  }

  Future<void> getCircularList({String? slug}) async {
    _circularListStateController(PageState.loading);

    try {
      final res = await _repository.fetchCirculars(slug);
      _circularListResponseModel = CircularResponseModel.fromJson(res);
      circularList = _circularListResponseModel?.jobCircular?.data! ?? [];
      _circularListStateController(PageState.success);
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _circularListStateController(PageState.error);
    }
  }

  Future<void> getCircularDetails(String slug) async {
    _pageStateController(PageState.loading);

    try {
      final res = await _repository.fetchCircularDetails(slug);
      _circularDetailsResponseModel =
          CircularDetailsResponseModel.fromJson(res);
      circularDetails = _circularDetailsResponseModel?.data;

      _pageStateController(PageState.success);
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
    }
  }
}
