import 'package:science_platform/src/feature/home/model_test/controller/model_test_view_controller.dart';
import 'package:science_platform/src/feature/home/model_test/models/question_bank_unit_model.dart';
import 'package:science_platform/src/feature/home/model_test/models/question_bank_varsity_model.dart';
import 'package:science_platform/src/feature/home/model_test/widget/unit_card.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/has_no_data_feedback.dart';
import 'package:science_platform/src/widgets/pill_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnitSelectionPage extends GetView<ModelTestViewController> {
  const UnitSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionBankVarsityModel varsity = controller.selectedVarsity;

    return Scaffold(
      appBar: AppBar(title: Text(varsity.name ?? '')),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            const SizedBox(height: 31),
            const PillTitle(title: TextConstants.modelTestUnit),
            const SizedBox(height: 31),
            _UnitBuilder(controller: controller),
          ],
        ),
      ),
    );
  }
}

class _UnitBuilder extends StatelessWidget {
  const _UnitBuilder({
    required this.controller,
  });

  final ModelTestViewController controller;

  @override
  Widget build(BuildContext context) {
    QuestionBankVarsityModel varsity = controller.selectedVarsity;

    return Expanded(
      child: controller.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : controller.hasUnits
              ? RefreshIndicator(
                  onRefresh: () async {
                    controller.getSelectedVarsity(varsity.id!);
                  },
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 158 / 70,
                      crossAxisSpacing: 19,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: varsity.modelTests?.length,
                    itemBuilder: (BuildContext context, index) {
                      QuestionBankUnitModel unit = varsity.modelTests![index];
                      return UnitCard(unit: unit);
                    },
                  ),
                )
              : HasNoDataFeedback(
                  onRefresh: () async {
                    controller.getSelectedVarsity(varsity.id!);
                  },
                ),
    );
  }
}
