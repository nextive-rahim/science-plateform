import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/classroom/repository/classroom_repository.dart';
import 'package:science_platform/src/feature/classroom/root/model/today_event_model.dart';
import 'package:get/get.dart';

class LiveActivityController extends GetxController {
  ClassroomRepository repository = ClassroomRepository();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);

  get pageState => _pageStateController.value;

  final Rx<PageState> _assignmentsPageStateController = Rx(PageState.initial);

  get assignmentPageState => _assignmentsPageStateController.value;

  /// Tab Items
  List<TodayEventModel> happeningTodayModel = [];
  List<TodayEventModel> todaysClasses = [];
  List<TodayEventModel> todaysExam = [];

  @override
  void onInit() {
    super.onInit();
    fetchHappeningToday();
  }

  Future<void> fetchHappeningToday() async {
    _pageStateController(PageState.loading);
    todaysExam.clear();

    try {
      final res = await repository.fetchHappeningToday();
      TodayEventResponseModel happeningToday =
          TodayEventResponseModel.fromJson(res);
      happeningTodayModel = happeningToday.data;
      todaysClasses = happeningTodayModel
          .where((element) => element.type == 'video')
          .toList();
      todaysExam = happeningTodayModel
          .where((element) => element.type == 'exam')
          .toList();
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
      Get.snackbar(
        'Failed',
        'Fetching today\'s tasks failed',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    _pageStateController(PageState.success);
  }

  // Future<void> getTodaysAssignments() async {
  //   _assignmentsPageStateController(PageState.loading);

  //   try {
  //     final res = await repository.fetchTodaysAssignment();
  //     todaysAssignmentResponseModel =
  //         TodaysAssignmentResponseModel.fromJson(res);
  //     todaysAssignments = todaysAssignmentResponseModel?.assignments ?? [];
  //     _assignmentsPageStateController(PageState.success);
  //   } catch (e, stackTrace) {
  //     Log.error(e.toString());
  //     Log.error(stackTrace.toString());
  //     _assignmentsPageStateController(PageState.error);
  //     Get.snackbar(
  //       'Failed',
  //       'Fetching today\'s assignments failed',
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //     return;
  //   }
  // }
}
