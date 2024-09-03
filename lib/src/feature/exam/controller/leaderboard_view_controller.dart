import 'dart:async';

import 'package:science_platform/src/core/exception/error_handler.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/exam/model/leader_board_model.dart';
import 'package:science_platform/src/feature/exam/repository/exam_repository.dart';
import 'package:science_platform/src/utils/assets.dart';
import 'package:get/get.dart';

class LeaderboardViewController extends GetxController {
  final ExamRepository _repository = ExamRepository();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);

  get pageState => _pageStateController.value;

  bool get isLoading => pageState == PageState.loading;

  late LeaderBoardModel leaderBoardModel;
  List<LeaderBoardItemModel> leaderBoardItems = [];
  List<LeaderBoardItemModel> topThreeLeaderBoardItems = [];
  List<LeaderBoardItemModel> allLeaderBoardItems = [];

  List topThreeLeaderBoard = [
    {
      "badgeIcon": Assets.medalFirstPlace,
      "badgeSize": 69,
      "padding": 0,
      "width": 114,
    },
    {
      "badgeIcon": Assets.medalSecondPlace,
      "badgeSize": 55,
      "padding": 4.5,
      "width": 110,
    },
    {
      "badgeIcon": Assets.medalThirdPlace,
      "badgeSize": 55,
      "padding": 4.5,
      "width": 110,
    },
  ];

  Future<void> getLeaderBoard(int contentId) async {
    _pageStateController(PageState.loading);

    try {
      final res = await _repository.fetchLeaderBoard(contentId);
      leaderBoardModel = LeaderBoardModel.fromJson(res);
      leaderBoardItems = leaderBoardModel.data ?? [];
      _pageStateController(PageState.success);
    } catch (e, stackTrace) {
      _pageStateController(PageState.error);
      errorHandler(e, stackTrace);
    }
  }
}
