import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/exam/model/exam_analysis_card_model.dart';
import 'package:flutter/material.dart';

class ExamAnalysisCard extends StatelessWidget {
  const ExamAnalysisCard({
    super.key,
    required this.analysisCard,
  });

  final ExamAnalysisCardModel analysisCard;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              analysisCard.title ?? '',
              style: AppTextStyle.bold20.copyWith(
                fontSize: 12,
                height: 15 / 10,
              ),
            ),
            Expanded(
              flex: 2,
              child: Image.asset(
                analysisCard.icon ?? '',
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5.0,
              ),
              child: Text(
                analysisCard.result ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
