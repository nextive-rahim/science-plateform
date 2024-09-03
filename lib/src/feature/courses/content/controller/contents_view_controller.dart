import 'package:get/get.dart';
import 'package:science_platform/src/core/exception/error_handler.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/courses/content/model/content_model.dart';
import 'package:science_platform/src/feature/courses/root/repository/course_repository.dart';
import 'package:science_platform/src/feature/courses/sections/model/section_model.dart';

class ContentsViewController extends GetxController {
  final CourseRepository _repository = CourseRepository();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);
  get pageState => _pageStateController.value;
  bool get isLoading => pageState == PageState.loading;
  bool get hasError => pageState == PageState.error;

  final Rx<PageState> _singleContentStateController = Rx(PageState.initial);
  get singleContentState => _singleContentStateController.value;
  bool get singleContentIsLoading => singleContentState == PageState.loading;
  bool get singleContentHasError => singleContentState == PageState.error;

  /// Course
  SectionModel? _sectionModel;
  ContentModel? contentModel;
  String? contentSlugToFetch;
  List<ContentModel> contents = [];

  String? pdfLink;
  ContentModel? pdfContent;
  int? contentIdOfVideoExam;

  bool get contentHasData => contents.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    contentIdOfVideoExam = null;
  }

  Future<void> updateContentIdOfVideoExam() async {
    if (contentIdOfVideoExam != null) {
      await updateContentsList();
    }
  }

  Future<void> getContentList(SectionModel section) async {
    _sectionModel = section;
    updateContentsList();
  }

  Future<void> updateContentsList() async {
    if (_sectionModel == null) {
      return;
    }

    _pageStateController(PageState.loading);
    try {
      final res = await _repository.fetchSectionContents(_sectionModel!.slug!);
      contents =
          List.from(res['data']).map((e) => ContentModel.fromJson(e)).toList();
      _pageStateController(PageState.success);
    } catch (e, stackTrace) {
      _pageStateController(PageState.error);
      errorHandler(e, stackTrace);
    }
  }

  Future<void> getContent(String contentSlug, {String? contentType}) async {
    contentSlugToFetch = contentSlug;
    _singleContentStateController(PageState.loading);
    try {
      final res = await _repository.fetchContent(contentSlug);
      contentModel = ContentModel.fromJson(res['data']);
      if (contentModel?.type == 'pdf') {
        getPdfLink();
      }
      _singleContentStateController(PageState.success);
    } catch (e, stackTrace) {
      _singleContentStateController(PageState.error);
      errorHandler(e, stackTrace);
    }
  }

  void getPdfLink() {
    pdfContent = contentModel;

    if (pdfContent?.pdf?.link != null) {
      pdfLink = pdfContent?.pdf?.link ?? '';
    }
  }
}
