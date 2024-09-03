import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/home/model_test/controller/model_test_view_controller.dart';
import 'package:science_platform/src/feature/home/model_test/models/question_bank_unit_model.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnitCard extends StatelessWidget {
  const UnitCard({
    super.key,
    required this.unit,
  });

  final QuestionBankUnitModel unit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<ModelTestViewController>().getModelTestDetails(unit.slug);
        Get.toNamed(Routes.examList);
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.lightBlack40,
              width: 1,
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              unit.title ?? '',
              textAlign: TextAlign.center,
              style: AppTextStyle.bold16,
            ),
          ],
        ),
      ),
    );
  }
}
