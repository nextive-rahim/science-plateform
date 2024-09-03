import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/exam/controller/group_exam_view_controller.dart';
import 'package:science_platform/src/feature/home/model_test/widget/subject_card.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/common_dialog.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';
import 'package:science_platform/src/widgets/pill_title.dart';
import 'package:science_platform/src/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubjectChoicePage extends GetView<GroupExamViewController> {
  SubjectChoicePage({super.key}) {
    controller.getExamInformation(Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(TextConstants.unitExamSubject)),
      body: Obx(() {
        if (controller.pageState == PageState.success) {
          return SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Column(
              children: [
                const SizedBox(height: 25),
                PillTitle(
                    title: '${controller.exam.totalSubject} '
                        '${TextConstants.selectUnitExamSubject}'),
                const SizedBox(height: 15),
                SubjectCard(controller: controller)
              ],
            ),
          );
        }
        return LoadingIndicator.list();
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: PrimaryButton(
          onTap: () {
            if (controller.selectedSubjects.length !=
                controller.exam.totalSubject) {
              Get.snackbar(
                'Warning',
                '${controller.exam.totalSubject} '
                    '${TextConstants.selectUnitExamSubject}',
                snackPosition: SnackPosition.TOP,
              );
            } else {
              commonDialog(
                context: context,
                title: TextConstants.areYouSure,
                description: TextConstants.examStartDisclosure,
                onYesPressed: () {
                  Get.find<GroupExamViewController>()
                      .getExamInformation(controller.exam.id!);
                  Get
                    ..back()
                    ..offNamed(
                      Routes.groupExamPage,
                      arguments: controller.exam.id,
                    );
                },
              );
            }
          },
          widget: Text(
            TextConstants.attendExam,
            style: AppTextStyle.bold16.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
