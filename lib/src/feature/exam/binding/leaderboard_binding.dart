import 'package:science_platform/src/feature/exam/controller/leaderboard_view_controller.dart';
import 'package:get/get.dart';

class LeaderboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LeaderboardViewController(), fenix: true);
  }
}
