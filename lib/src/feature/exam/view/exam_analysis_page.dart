import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/courses/content/model/contents/exam_model.dart';
import 'package:science_platform/src/feature/exam/controller/exam_analysis_view_controller.dart';
import 'package:science_platform/src/feature/exam/controller/exam_info_view_controller.dart';
import 'package:science_platform/src/feature/exam/model/exam_analysis_card_model.dart';
import 'package:science_platform/src/feature/exam/widgets/exam_analysis_card.dart';
import 'package:science_platform/src/feature/exam/widgets/mcq_analysis_card.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/assets.dart';
import 'package:science_platform/src/utils/extensions/string_extension.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/error_feedback.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';
import 'package:science_platform/src/widgets/pill_title.dart';
import 'package:science_platform/src/widgets/primary_button.dart';
import 'package:science_platform/src/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExamAnalysisPage extends GetView<ExamAnalysisViewController> {
  ExamAnalysisPage({super.key});

  void getExamAnalysis() async {
    await controller.getExamAnalysisReport(Get.arguments);
  }

  final examInfoController = Get.find<ExamInfoViewController>();

  @override
  Widget build(BuildContext context) {
    getExamAnalysis();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(TextConstants.examAnalysis),
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: PrimaryButton(
          onTap: () => Get.back(),
          widget: Text(
            TextConstants.finishExamAnalysis,
            style: AppTextStyle.bold16.copyWith(color: AppColors.white),
          ),
        ).paddingSymmetric(
          horizontal: 20,
          vertical: 10,
        ),
        body: Obx(
          () {
            if (controller.isLoading) {
              return LoadingIndicator.list().paddingAll(20);
            } else if (controller.pageState == PageState.error) {
              return const GenericErrorFeedback().paddingSymmetric(
                horizontal: 20,
              );
            }
            ExamModel exam = controller.exam;
            if (exam.isResultPublished) {
              return SingleChildScrollView(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: 50,
                ),
                child: Column(
                  children: [
                    if (!exam.isPracticeExam)
                      _ExamAnalysis(controller: controller),
                    _groupExamHeader(),
                    const PillTitle(
                      title: TextConstants.questionAnalysis,
                    ),
                    const SizedBox(height: 25),
                    controller.exam.mode == 'group'
                        ? _GroupExamQuestionAnalysis(controller: controller)
                        : _QuestionAnalysis(controller: controller),
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Result and answer sheet will be published on:',
                    ),
                    const SizedBox(height: 10),
                    Text(
                      getFormattedDateTime(exam.resultPublishTime) ?? '',
                      style: AppTextStyle.bold14.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        controller.getExamAnalysisReport(Get.arguments);
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.refresh),
                          SizedBox(width: 10),
                          Text(
                            "Refresh",
                            textScaleFactor: 1,
                            style: AppTextStyle.bold16,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  _groupExamHeader() {
    return controller.exam.mode == 'group'
        ? controller.analysisSubjects.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const PillTitle(title: TextConstants.yourSubjects),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      itemCount: controller.analysisSubjects.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, gobalIndex) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                examInfoController.subSelected(gobalIndex);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Obx(
                                  () => Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                        color: examInfoController
                                                    .isSubSelected.value ==
                                                gobalIndex
                                            ? AppColors.primary
                                            : AppColors.white,
                                        border: Border.all(
                                          width: 1,
                                          color: AppColors.primary,
                                        ),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Text(
                                      controller.analysisSubjects[gobalIndex]
                                              .name ??
                                          '',
                                      style: TextStyle(
                                        color: examInfoController
                                                    .isSubSelected.value ==
                                                gobalIndex
                                            ? AppColors.white
                                            : AppColors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                    child: ListView.builder(
                      itemCount: controller.analysisSubjects.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, gobalIndex) {
                        return Obx(() => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                  color:
                                      examInfoController.isSubSelected.value ==
                                              gobalIndex
                                          ? AppColors.primary
                                          : AppColors.white,
                                  border: Border.all(
                                    width: 1,
                                    color: AppColors.primary,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ));
                      }),
                    ),
                  )
                ],
              )
            : const Offstage()
        : const Offstage();
  }
}

class _QuestionAnalysis extends StatelessWidget {
  const _QuestionAnalysis({
    required this.controller,
  });

  final ExamAnalysisViewController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.pageState == PageState.loading) {
        LoadingIndicator.list();
      }
      return controller.exam.mcqs!.isNotEmpty || controller.exam.mcqs != null
          ? ListView.builder(
              itemCount: controller.exam.mcqs!.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: ((context, index) {
                return MCQAnalysisCard(
                  index: index,
                  mcqModel: controller.exam.mcqs![index]!,
                );
              }),
            )
          : const Offstage();
    });
  }
}

class _GroupExamQuestionAnalysis extends StatelessWidget {
  _GroupExamQuestionAnalysis({
    required this.controller,
  });

  final ExamAnalysisViewController controller;
  final examInfoController = Get.find<ExamInfoViewController>();

  @override
  Widget build(BuildContext context) {
    return controller.analysisSubjects.isNotEmpty
        ? Obx(() => ListView.builder(
              itemCount: controller
                  .analysisSubjects[examInfoController.isSubSelected.value!]
                  .mcqs!
                  .length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: ((context, index) {
                return MCQAnalysisCard(
                  index: index,
                  mcqModel: controller
                      .analysisSubjects[examInfoController.isSubSelected.value!]
                      .mcqs![index],
                );
              }),
            ))
        : const Offstage();
  }
}

class _ExamAnalysis extends StatelessWidget {
  const _ExamAnalysis({
    required this.controller,
  });

  final ExamAnalysisViewController controller;

  @override
  Widget build(BuildContext context) {
    final List<ExamAnalysisCardModel> examAnalysisOptions = [
      ExamAnalysisCardModel(
        title: TextConstants.timeTaken,
        icon: Assets.timer,
        result: controller.result?.timeTaken,
      ),
      ExamAnalysisCardModel(
        title: TextConstants.correctAnswers,
        icon: Assets.score,
        result: controller.result?.correctlyAnswered,
      ),
      ExamAnalysisCardModel(
        title: TextConstants.yourResult,
        icon: Assets.result,
        result: controller.result?.yourResult,
      ),
    ];

    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: PillTitle(title: TextConstants.examAnalysis),
            ),
            RoundedButton(
              onPressed: _onLeaderboardButtonTapped,
              radius: 5,
              child: Text(
                TextConstants.seeTheRanking,
                style: AppTextStyle.bold14.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
        Obx(() {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!controller.exam.isExamAttended) {
            return Container(
              height: 60,
              margin: const EdgeInsets.only(
                top: 15,
                bottom: 25,
              ),
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.lightBlack10,
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'You have missed the exam!',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.bold14.copyWith(
                    color: AppColors.red,
                  ),
                ),
              ),
            );
          }

          return Container(
            height: 130,
            margin: const EdgeInsets.only(
              top: 15,
              bottom: 25,
            ),
            child: _AnalysisBuilder(examAnalysis: examAnalysisOptions),
          );
        }),
      ],
    );
  }

  void _onLeaderboardButtonTapped() {
    Get.toNamed(
      Routes.examLeaderboard,
      arguments: controller.exam.contentId!,
    );
  }
}

class _AnalysisBuilder extends StatelessWidget {
  const _AnalysisBuilder({
    required this.examAnalysis,
  });

  final List<ExamAnalysisCardModel> examAnalysis;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 1.3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: examAnalysis.length,
      itemBuilder: (BuildContext context, index) {
        ExamAnalysisCardModel analysisItem = examAnalysis[index];
        return ExamAnalysisCard(analysisCard: analysisItem);
      },
    );
  }
}
