import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/home/notifications/tab/notice/model/notice_list_model.dart';
import 'package:science_platform/src/feature/home/notifications/tab/notice/repository/notice_repository.dart';
import 'package:get/get.dart';

class NoticeDetailsViewController extends GetxController {
  final NoticeRepository repository = NoticeRepository();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);

  get pageState => _pageStateController.value;
  late NoticeData notice;

  Future<void> fetchNoticeDetails(String slug) async {
    _pageStateController(PageState.loading);

    try {
      final res = await repository.fetchNoticeDetails(slug);
      notice = NoticeData.fromJson(res["data"]);
      _pageStateController(PageState.success);
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
      Get.snackbar(
        'Failed',
        'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
