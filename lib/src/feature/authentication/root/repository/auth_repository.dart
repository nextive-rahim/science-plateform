import 'package:science_platform/src/core/network/endpoints.dart';
import 'package:science_platform/src/core/network/rest_client.dart';
import 'package:science_platform/src/core/service/cache/cache_keys.dart';
import 'package:science_platform/src/core/service/cache/cache_service.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationRepository {
  Future<dynamic> login(Map<String, dynamic> data) async {
    final res = await RestClient.dev().post(
      APIType.PUBLIC,
      API.login,
      data,
    );
    return res.data;
  }

  Future<dynamic> signUp(Map<String, dynamic> data) async {
    final res = await RestClient.dev().post(
      APIType.PUBLIC,
      API.signup,
      data,
    );
    return res.data;
  }

  Future<dynamic> otp(String phoneNumber) async {
    final res = await RestClient().get(
      APIType.PUBLIC,
      API.otp,
      data: {
        'phone': phoneNumber,
      },
    );
    return res.data;
  }

  Future<dynamic> phoneNumberVerification(Map<String, dynamic> data) async {
    final box = GetStorage('Auth');
    final apiToken = await box.read(CacheKeys.token);
    final res = await RestClient().post(
      APIType.PROTECTED,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiToken',
      },
      API.phoneNumberVerification,
      data,
    );
    return res.data;
  }

  Future<dynamic> resetPassword(Map<String, dynamic> data) async {
    final res = await RestClient().post(
      APIType.PUBLIC,
      API.resetPassword,
      data,
    );
    return res.data;
  }

  Future<dynamic> signOut() async {
    //TODO: Implement Sign out API
    CacheService().dispose();
  }
}
