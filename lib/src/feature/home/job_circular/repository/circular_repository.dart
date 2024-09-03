import 'package:science_platform/src/core/network/endpoints.dart';
import 'package:science_platform/src/core/network/rest_client.dart';
import 'package:science_platform/src/utils/extensions/generic_extension.dart';

class JobCircularRepository {
  Future<dynamic> fetchCircularCategories() async {
    final res = await RestClient.dev().get(
      APIType.PUBLIC,
      API.circularCategories,
    );
    return res.data;
  }

  Future<dynamic> fetchCirculars(String? slug) async {
    final res = await RestClient.dev().get(
      APIType.PUBLIC,
      slug.isNotNull ? API.circularList(slug) : API.allCirculars,
    );
    return res.data;
  }

  Future<dynamic> fetchCircularDetails(String slug) async {
    final res = await RestClient.dev().get(
      APIType.PROTECTED,
      API.circularDetails + slug,
    );
    return res.data;
  }
}
