import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/settings/models/setting_model.dart';
import 'package:science_platform/src/feature/settings/repository/setting_repository.dart';
import 'package:science_platform/src/utils/enums.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsController extends GetxController {
  final SettingsRepository _repository = SettingsRepository();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);

  get pageState => _pageStateController.value;

  bool get isLoading => pageState == PageState.loading;

  bool get hasError => pageState == PageState.error;

  /// My courses
  PackageInfo? packageInfo;

  late SettingsResponseModel settingsResponseModel;
  List<SettingModel> settings = [];

  bool? hasNewUpdate = false;
  bool? isForceUpdate = false;
  bool? showUpdateDialog = false;

  String? _appVersion;
  String? _appUpdate;

  @override
  void onInit() async {
    super.onInit();
    packageInfo = await PackageInfo.fromPlatform();
    // await getAllSettings();
  }

  Future<void> getAllSettings() async {
    _pageStateController(PageState.loading);
    try {
      final res = await _repository.fetchSettings();
      settingsResponseModel = SettingsResponseModel.fromJson(res);
      settings = settingsResponseModel.data ?? [];
      await getInformation();
      _pageStateController(PageState.success);
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
      Get.snackbar(
        'Failed',
        'Fetching app settings failed',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
  }

  Future<void> getInformation() async {
    _appVersion = settings
        .firstWhere(
            (setting) => setting.key == SettingsKeyType.app_version.name)
        .value;

    _appUpdate = settings
        .firstWhere((setting) => setting.key == SettingsKeyType.app_update.name)
        .value;

    if (_appVersion == '${packageInfo?.version}+${packageInfo?.buildNumber}') {
      hasNewUpdate = false;
    } else {
      hasNewUpdate = true;
      showUpdateDialog = true;
      isForceUpdate = _appUpdate == 'mandatory' ? true : false;
    }
  }
}
