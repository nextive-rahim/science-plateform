import 'package:science_platform/src/core/exception/custom_exception.dart';
import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/core/network/endpoints.dart';
import 'package:science_platform/src/core/network/rest_client.dart';
import 'package:science_platform/src/core/service/cache/cache_keys.dart';
import 'package:science_platform/src/core/service/cache/cache_service.dart';
import 'package:science_platform/src/feature/profile/model/user_model.dart';
import 'package:science_platform/src/utils/extensions/generic_extension.dart';

class UserRepository {
  /// Try to fetch data from cache first. If empty, fetch from remote
  Future<UserModel> fetchUser() async {
    //FIXME: Cache is not working
    UserModel?
        user; /*= User.fromJson(CacheService.boxAuth.read(CacheKeys.user));*/
    if (user.isNotNull) {
    } else {
      final res = await RestClient.dev().get(
        APIType.PROTECTED,
        API.user,
      );

      if (res.data == null) {
        throw CustomException(000, "Unable to fetch user data", "Error");
      }
      user = UserModel.fromJson(res.data['data']);
      CacheService.boxAuth.write(CacheKeys.user, user.toJson());
    }
    Log.info(user!.toJson().toString());
    return user;
  }

  Future<dynamic> updateUserData(
    Map<String, dynamic> data,
  ) async {
    final res = await RestClient.dev().post(
      APIType.PROTECTED,
      API.user,
      data,
    );
    return res.data;
  }
}
