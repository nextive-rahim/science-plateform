import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/home/blogs/model/blog_details_model.dart';
import 'package:science_platform/src/feature/home/blogs/model/blog_model.dart';
import 'package:science_platform/src/feature/home/blogs/repository/blog_repository.dart';
import 'package:get/get.dart';

class BlogViewController extends GetxController {
  final BlogRepository _repository = BlogRepository();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);
  get pageState => _pageStateController.value;

  final Rx<PageState> _blogListStateController = Rx(PageState.initial);
  get blogListState => _blogListStateController.value;

  final Rx<PageState> _blogDetailsStateController = Rx(PageState.initial);
  get blogDetailsState => _blogDetailsStateController.value;

  @override
  void onInit() async {
    super.onInit();
    featuredBlogs();
    getBlogList();
  }

  List<BlogModel> categories = [];
  List<BlogModel> blogList = [];
  BlogModel? selectedCategory;
  BlogModel? blogDetailsData;

  Future<void> featuredBlogs() async {
    _pageStateController(PageState.loading);

    try {
      final res = await _repository.fetchFeaturedBlogs();
      BlogResponseModel responseModel = BlogResponseModel.fromJson(res);
      categories = responseModel.data ?? [];
      _pageStateController(PageState.success);
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
    }
  }

  Future<void> getBlogList({String? slug}) async {
    _blogListStateController(PageState.loading);

    try {
      final res = await _repository.fetchBlogs(slug);
      BlogResponseModel responseModel = BlogResponseModel.fromJson(res);
      blogList = responseModel.data ?? [];
      _blogListStateController(PageState.success);
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _blogListStateController(PageState.error);
    }
  }

  Future<void> getBlogDetails(String slug) async {
    _blogDetailsStateController(PageState.loading);

    try {
      final res = await _repository.fetchBlogDetails(slug);
      BlogDetailsResponseModel responseModel =
          BlogDetailsResponseModel.fromJson(res);
      blogDetailsData = responseModel.data!;
      _blogDetailsStateController(PageState.success);
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
    }
  }
}
