import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/exam/model/leader_board_model.dart';
import 'package:science_platform/src/utils/assets.dart';
import 'package:flutter/material.dart';

class LeadershipTopThreeMemberCard extends StatelessWidget {
  const LeadershipTopThreeMemberCard({
    super.key,
    required this.leaderBoardItemModel,
    required this.badgeDetails,
  });

  final LeaderBoardItemModel leaderBoardItemModel;
  final Map<String, dynamic> badgeDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: badgeDetails['width'].toDouble(),
      padding: const EdgeInsets.all(6),
      margin: EdgeInsets.symmetric(
        vertical: badgeDetails['padding'].toDouble() ?? 0,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.primary,
          width: 0.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            badgeDetails['badgeIcon'],
            height: badgeDetails['badgeSize'].toDouble(),
          ),
          const SizedBox(height: 5),
          Text(
            leaderBoardItemModel.user?.name ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: AppTextStyle.bold12.copyWith(
              color: AppColors.primary,
            ),
          ),
          Text(
            leaderBoardItemModel.user?.currentInstitution ?? '',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 15,
                    height: 15,
                    child: Image.asset(
                      Assets.timer,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    leaderBoardItemModel.timeTaken,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.medium12.copyWith(
                      fontSize: 10,
                      height: 11 / 10,
                      color: AppColors.lightBlack80,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 15,
                    height: 15,
                    child: Image.asset(
                      Assets.result,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    leaderBoardItemModel.scoreEarned,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.medium12.copyWith(
                      fontSize: 10,
                      height: 11 / 10,
                      color: AppColors.lightBlack80,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
