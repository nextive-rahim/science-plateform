import 'package:science_platform/src/core/network/endpoints.dart';
import 'package:science_platform/src/core/network/rest_client.dart';

class HomeRepository {
  Future<dynamic> fetchHomeContents() async {
    final res = await RestClient().get(
      APIType.PROTECTED,
      API.home,
    );

    return res.data;
  }
}
