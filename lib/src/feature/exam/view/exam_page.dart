import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/feature/exam/controller/exam_info_view_controller.dart';
import 'package:science_platform/src/feature/exam/controller/exam_view_controller.dart';
import 'package:science_platform/src/feature/home/model_test/widget/mcq_question_card.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/common_dialog.dart';
import 'package:science_platform/src/widgets/common_timer.dart';
import 'package:science_platform/src/widgets/error_feedback.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';
import 'package:science_platform/src/widgets/pill_title.dart';
import 'package:science_platform/src/widgets/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExamPage extends GetView<ExamViewController> {
  ExamPage({super.key}) {
    controller.getExamDetails(Get.arguments);
  }

  final examInfoController = Get.find<ExamInfoViewController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.isLoading) {
          return false;
        }
        return controller.examModel.mode == "practice";
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(TextConstants.mcqQuestion),
          automaticallyImplyLeading: controller.isLoading
              ? false
              : controller.examModel.mode == "practice",
          bottom: PreferredSize(
              preferredSize: Size(
                double.infinity,
                MediaQuery.of(context).viewPadding.top + 30,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(
                      child: PillTitle(
                        title: TextConstants.remainingTime,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.primary,
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Obx(
                            () => controller.isLoading
                                ? const CupertinoActivityIndicator()
                                : CommonTimer(
                                    showHour: true,
                                    timerDuration: Duration(
                                      minutes:
                                          controller.examModel.duration ?? 0,
                                    ),
                                    startTimer: controller.startTimer,
                                    onFinish: () async {
                                      await _navigateToAnalysisPageAfterSubmittingAnswer();
                                    },
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    SizedBox(
                      height: 41,
                      child: RoundedButton(
                        radius: 8,
                        title: TextConstants.submitExam,
                        onPressed: () async {
                          if (!controller.examModel.isPracticeExam) {
                            _submitExamDialog(context);
                          } else {
                            await _navigateToAnalysisPageAfterSubmittingAnswer();
                          }
                        },
                      ),
                    )
                  ],
                ),
              )),
        ),
        body: Obx(() {
          if (controller.isLoading) {
            return LoadingIndicator.list();
          } else if (controller.pageState == PageState.error) {
            return const GenericErrorFeedback();
          } else {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const PillTitle(title: TextConstants.question),
                  const SizedBox(height: 25),
                  _QuestionBuilder(controller: controller),
                ],
              ),
            );
          }
        }),
      ),
    );
  }

  Future<void> _navigateToAnalysisPageAfterSubmittingAnswer({
    bool shouldPopDialog = false,
  }) async {
    await controller.submitAnswer();
    if (controller.pageState == PageState.success) {
      if (shouldPopDialog) Get.back();
      await Get.offNamed(
        Routes.examAnalysis,
        arguments: Get.arguments,
      );
    }
  }

  _submitExamDialog(BuildContext context) {
    commonDialog(
      context: context,
      title: TextConstants.sureAboutEndingExam,
      description: TextConstants.examEndDisclosure,
      onYesPressed: () async {
        await _navigateToAnalysisPageAfterSubmittingAnswer(
            shouldPopDialog: true);
      },
    );
  }
}

class _QuestionBuilder extends StatelessWidget {
  const _QuestionBuilder({
    required this.controller,
  });

  final ExamViewController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 50),
      itemCount: controller.examModel.mcqs?.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: ((context, index) {
        return MCQQuestionCard(
          index: index,
          mcqModel: controller.examModel.mcqs![index]!,
          examMode: controller.examModel.mode!,
        );
      }),
    );
  }
}
