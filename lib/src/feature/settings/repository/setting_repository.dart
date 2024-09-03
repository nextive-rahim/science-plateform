import 'package:science_platform/src/core/network/endpoints.dart';
import 'package:science_platform/src/core/network/rest_client.dart';
import 'package:science_platform/src/utils/enums.dart';

class SettingsRepository {
  Future<dynamic> fetchSettings({SettingsKeyType? settingType}) async {
    final res = await RestClient().get(
      APIType.PROTECTED,
      '${API.settings}/${settingType?.name ?? ''}',
    );
    return res.data;
  }
}
