import 'package:science_platform/src/core/network/endpoints.dart';
import 'package:science_platform/src/core/network/rest_client.dart';

class FreeCoursesRepository {
  Future<dynamic> fetchFreeExams({
    List? filters,
    int? perPage = 10,
    int? pageNo,
  }) async {
    final res = await RestClient().get(
      APIType.PROTECTED,
      API.modelTests,
      data: (filters == null || filters.isEmpty)
          ? null
          : {
              'filter': filters,
              'per_page': perPage,
              'page': pageNo,
            },
    );
    return res.data;
  }
}
