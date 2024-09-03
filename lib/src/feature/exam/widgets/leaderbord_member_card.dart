import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/exam/model/leader_board_model.dart';
import 'package:science_platform/src/utils/assets.dart';
import 'package:flutter/material.dart';

class LeaderboardMemberCard extends StatelessWidget {
  const LeaderboardMemberCard({
    super.key,
    required this.leading,
    required this.leaderBoardItemModel,
  });

  final String leading;

  final LeaderBoardItemModel leaderBoardItemModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.lightBlack10,
          width: 0.5,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 8,
        ),
        dense: true,
        minVerticalPadding: 0,
        visualDensity: VisualDensity.compact,
        leading: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: AppColors.lightPink,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              leading.toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
        title: Text(
          leaderBoardItemModel.user?.name ?? '',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: AppTextStyle.bold12.copyWith(
            color: AppColors.lightBlack90,
          ),
        ),
        subtitle: Text(leaderBoardItemModel.user?.currentInstitution ?? ''),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
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
            const SizedBox(width: 5),
            Row(
              mainAxisSize: MainAxisSize.min,
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
      ),
    );
  }
}
