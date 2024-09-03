import 'package:science_platform/src/core/network/endpoints.dart';
import 'package:science_platform/src/core/network/rest_client.dart';

class ClassroomRepository {
  Future<dynamic> fetchHappeningToday() async {
    final res = await RestClient.dev().get(
      APIType.PROTECTED,
      API.happeningToday,
    );
    return res.data;
  }
}
