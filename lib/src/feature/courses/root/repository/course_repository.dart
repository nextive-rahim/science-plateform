import 'package:science_platform/src/core/network/endpoints.dart';
import 'package:science_platform/src/core/network/rest_client.dart';

class CourseRepository {
  Future<dynamic> fetchCategories({String? slug = ''}) async {
    final res = await RestClient().get(
      APIType.PROTECTED,
      API.courseCategory(slug: slug),
    );

    return res.data;
  }

  Future<dynamic> fetchCoursesByCategory(String slug) async {
    final res = await RestClient().get(
      APIType.PROTECTED,
      API.coursesByCategories,
      data: {
        'per_page': 20,
        'page': 1,
        'category_slug': slug,
      },
    );

    return res.data;
  }

  Future<dynamic> fetchCategoryWithCourses({String? slug}) async {
    final res = await RestClient().get(
      APIType.PROTECTED,
      slug == null ? API.categoryWithCourses : API.categoryWithCourses + slug,
    );

    return res.data;
  }

  Future<dynamic> fetchCourseDetails(
    String slug, {
    List? params,
  }) async {
    final res = await RestClient().get(
      APIType.PROTECTED,
      API.courseDetails + slug,
    );
    return res.data;
  }

  /// Fetches section list and section wise content list
  Future<dynamic> fetchCourseSectionsAndContents(String slug) async {
    final res = await RestClient().get(
      APIType.PROTECTED,
      API.courseSectionsAndContents(slug),
    );
    return res.data;
  }

  Future<dynamic> fetchFeaturedCourses({
    int perPage = 100,
    int pageNo = 1,
  }) async {
    final res = await RestClient().get(
      APIType.PROTECTED,
      API.featuredCourses(
        perPage: perPage,
        pageNo: pageNo,
      ),
    );
    return res.data;
  }

  Future<dynamic> fetchMyCourse() async {
    final res = await RestClient().get(
      APIType.PROTECTED,
      API.myCourses,
    );
    return res.data;
  }

  Future<dynamic> fetchSectionContents(String slug) async {
    final res = await RestClient().get(
      APIType.PROTECTED,
      API.sectionContentList(slug),
    );
    return res.data;
  }

  Future<dynamic> fetchContent(String slug) async {
    final res = await RestClient().get(
      APIType.PROTECTED,
      API.content(slug),
    );

    return res.data;
  }

  Future<dynamic> applyCoupon(Map<String, dynamic> data) async {
    final res = await RestClient().post(
      APIType.PROTECTED,
      API.coupon,
      data,
    );
    return res.data;
  }

  // fetch courses
  Future<dynamic> fetchCourses({List? filters}) async {
    final res = await RestClient().get(
      APIType.PROTECTED,
      API.courses,
      data: (filters == null || filters.isEmpty)
          ? null
          : {
              'filter': filters,
            },
    );
    return res.data;
  }
}
