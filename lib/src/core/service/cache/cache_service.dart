import 'package:science_platform/src/core/logger.dart';
import 'package:get_storage/get_storage.dart';

class CacheService {
  static final CacheService _cacheService = CacheService._internal();

  factory CacheService() {
    return _cacheService;
  }

  CacheService._internal();

  Future<void> initialize() async {
    Log.info("Initialising Cache Service");
    await GetStorage.init();
    await GetStorage.init('Auth');
  }

  Future<void> dispose() async {
    box.erase();
    boxAuth.erase();
  }

  static final GetStorage box = GetStorage();
  static final GetStorage boxAuth = GetStorage('Auth');
}
