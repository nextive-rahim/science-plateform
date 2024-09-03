import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/home/affiliation/models/dashboardb_banner_model.dart';
import 'package:science_platform/src/feature/home/root/repository/home_repository.dart';
import 'package:get/get.dart';

class DashboardBannerViewController extends GetxController {
  final HomeRepository repository = HomeRepository();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);

  get pageState => _pageStateController.value;

  DashbaordBannerData? dashbaordBannerData;

  // Future<void> dashboardBanner() async {
  //   _pageStateController(PageState.loading);

  //   try {
  //     final res = await repository.fetchDashboardBanner();
  //     _dashBoardBannerResponseModel =
  //         DashBoardBannerResponseModel.fromJson(res);
  //     dashbaordBannerData = _dashBoardBannerResponseModel.data!;
  //     _pageStateController(PageState.success);
  //   } catch (e, stackTrace) {
  //     Log.error(e.toString());
  //     Log.error(stackTrace.toString());
  //     _pageStateController(PageState.error);
  //     Get.snackbar(
  //       'Failed',
  //       'Fetching dashboard banner failed',
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   }
  // }
}
