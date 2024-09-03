import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/exam/controller/leaderboard_view_controller.dart';
import 'package:science_platform/src/feature/exam/widgets/leaderbord_member_card.dart';
import 'package:science_platform/src/feature/exam/widgets/leadership_top_three_member_card.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/error_feedback.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';
import 'package:science_platform/src/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExamLeaderboardPage extends GetView<LeaderboardViewController> {
  ExamLeaderboardPage({super.key}) {
    controller.getLeaderBoard(Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(TextConstants.leaderBoard)),
      body: Obx(
        () {
          if (controller.isLoading) {
            return LoadingIndicator.list();
          }
          if (controller.pageState == PageState.error) {
            return const GenericErrorFeedback();
          } else {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(
                top: 10,
                left: 20,
                right: 20,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 155,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (controller.leaderBoardItems.length >= 2)
                          LeadershipTopThreeMemberCard(
                            leaderBoardItemModel:
                                controller.leaderBoardItems[1],
                            badgeDetails: controller.topThreeLeaderBoard[1],
                          ),
                        if (controller.leaderBoardItems.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: LeadershipTopThreeMemberCard(
                              leaderBoardItemModel:
                                  controller.leaderBoardItems[0],
                              badgeDetails: controller.topThreeLeaderBoard[0],
                            ),
                          ),
                        if (controller.leaderBoardItems.length >= 3)
                          LeadershipTopThreeMemberCard(
                            leaderBoardItemModel:
                                controller.leaderBoardItems[2],
                            badgeDetails: controller.topThreeLeaderBoard[2],
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  (controller.leaderBoardItems.length >= 4)
                      ? ListView.builder(
                          itemCount:
                              controller.leaderBoardItems.sublist(3).length,
                          primary: false,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: ((context, index) {
                            int newIndex = (index + 3);

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: LeaderboardMemberCard(
                                leaderBoardItemModel:
                                    controller.leaderBoardItems[newIndex],
                                leading: (newIndex + 1).toString(),
                              ),
                            );
                          }),
                        )
                      : const SizedBox(),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10,
        ),
        child: PrimaryButton(
          onTap: () {
            Get.back();
          },
          widget: Text(
            'ফিরে যান',
            style: AppTextStyle.bold16.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
