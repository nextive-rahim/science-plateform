import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/exception/error_handler.dart';
import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/courses/content/controller/contents_view_controller.dart';
import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/feature/courses/root/repository/course_repository.dart';
import 'package:science_platform/src/feature/courses/sections/model/section_model.dart';

class CourseSectionsViewController extends GetxController {
  final CourseRepository _repository = CourseRepository();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);

  get pageState => _pageStateController.value;

  late int rating;
  late int totalRatings;
  bool ratingGiven = false;

  int userRating = 4;
  String? sectionsCourseSlug;

  /// Course
  CourseModel? courseModel;
  late List<SectionModel> sections = [];

  bool get sectionHasData => sections.isNotEmpty;

  @override
  void onInit() {
    Get.put(ContentsViewController());
    super.onInit();
  }

  Future<void> getCourseSectionsAndContents(String slug) async {
    _pageStateController(PageState.loading);
    courseModel = null;
    sections = [];
    sectionsCourseSlug = slug;
    try {
      final res = await _repository.fetchCourseSectionsAndContents(slug);
      courseModel = CourseModel.fromJson(res);
      sections = courseModel?.sections ?? [];
      _pageStateController(PageState.success);
    } catch (e, stackTrace) {
      _pageStateController(PageState.error);
      errorHandler(e, stackTrace);
    }
  }

  Future<void> rateCourse() async {
    //TODO: Implement rateCourse()
    Log.debug('User rating $userRating');
  }

  /// Controller
  TextEditingController reviewController = TextEditingController();
}
