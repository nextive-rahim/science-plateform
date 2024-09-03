import 'package:science_platform/src/core/network/endpoints.dart';
import 'package:science_platform/src/core/network/rest_client.dart';

class NoticeRepository {
  Future<dynamic> fetchNotices() async {
    final res = await RestClient().get(
      APIType.PUBLIC,
      API.notice,
    );
    return res.data;
  }

  Future<dynamic> fetchNoticeDetails(String slug) async {
    final res = await RestClient().get(APIType.PUBLIC, API.noticeDetails(slug));
    return res.data;
  }
}
