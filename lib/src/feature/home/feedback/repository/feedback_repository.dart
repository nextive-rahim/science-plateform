import 'package:science_platform/src/core/network/endpoints.dart';
import 'package:science_platform/src/core/network/rest_client.dart';

class FeedbackRepository {
  Future<dynamic> feedback(Map<String, dynamic> data) async {
    final res = await RestClient.dev().post(
      APIType.PROTECTED,
      API.feedback,
      data,
    );
    return res.data;
  }
}
