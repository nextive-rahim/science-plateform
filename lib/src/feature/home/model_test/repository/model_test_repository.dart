import 'package:science_platform/src/core/network/endpoints.dart';
import 'package:science_platform/src/core/network/rest_client.dart';

class ModelTestRepository {
  Future<dynamic> fetchModelTestData() async {
    final res = await RestClient.dev().get(
      APIType.PROTECTED,
      API.modelTests,
    );
    return res.data;
  }

  Future<dynamic> fetchMyModelTest() async {
    final res = await RestClient.dev().get(
      APIType.PROTECTED,
      API.myModelTest,
    );
    return res.data;
  }

  Future<dynamic> fetchModelTestDetails(slug) async {
    final res = await RestClient.dev()
        .get(APIType.PROTECTED, API.modelTestDetails(slug));
    return res.data;
  }

  Future<dynamic> fetchContentDetails(id) async {
    final res = await RestClient.dev().get(APIType.PROTECTED, API.content(id));
    return res.data;
  }
}
