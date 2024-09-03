import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/courses/content/model/contents/contents_b.dart';
import 'package:science_platform/src/feature/exam/controller/exam_info_view_controller.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/enums.dart';
import 'package:science_platform/src/utils/extensions/string_extension.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/common_dialog.dart';
import 'package:science_platform/src/widgets/error_feedback.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';
import 'package:science_platform/src/widgets/pill_title.dart';
import 'package:science_platform/src/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExamInfoPage extends GetView<ExamInfoViewController> {
  ExamInfoPage({super.key}) {
    controller.getExamInformation(Get.arguments[0]);
  }

  @override
  Widget build(BuildContext context) {
    String examTitle = Get.arguments[1] ?? 'Exam Details';
    return Scaffold(
      appBar: AppBar(title: Text(examTitle)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(
          () {
            if (controller.isLoading) {
              return LoadingIndicator.card();
            } else if (controller.pageState == PageState.error) {
              return const GenericErrorFeedback();
            } else {
              return Column(
                children: [
                  _MarkDistributionTable(
                    tableName: TextConstants.markDistribution,
                    exam: controller.exam,
                  ),
                  if (controller.exam.mode != ExamType.practice.name)
                    _ExamTimingTable(
                      tableName: TextConstants.examTiming,
                      exam: controller.exam,
                    ),
                  const SizedBox(height: 10),
                  const Spacer(),
                  PrimaryButton(
                    onTap: () {
                      // controller.selectedSubjects.clear();

                      /// Practice Exam
                      if (controller.exam.isPracticeExam) {
                        Get.offNamed(
                          Routes.examPage,
                          arguments: controller.exam.id,
                        );
                        return;
                      }

                      /// Exam has not started yet
                      if (controller.exam.examHasNotStarted) {
                        Get.snackbar(
                          "Sorry",
                          "Exam has not started yet, please wait.",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        return;
                      }

                      /// If user didn't participate before and exam time isn't over
                      if (controller.exam.isExamAvailable) {
                        if (controller.exam.isGroupExam) {
                          // Get.find<GroupExamViewController>()
                          //     .getExamInformation(controller.exam.id!);
                          Get.offNamed(
                            Routes.subjectChoice,
                            arguments: controller.exam.id!,
                          );
                        }
                        controller.exam.isGroupExam
                            ? null
                            : commonDialog(
                                context: context,
                                title: TextConstants.areYouSure,
                                description: TextConstants.examStartDisclosure,
                                onYesPressed: () {
                                  Get
                                    ..back()
                                    ..offNamed(
                                      Routes.examPage,
                                      arguments: controller.exam.id,
                                    );
                                },
                              );
                        return;
                      }

                      // Go to analysis page
                      Get.offNamed(
                        Routes.examAnalysis,
                        arguments: controller.exam.id,
                      );
                    },
                    widget: Text(
                      controller.buttonTitle,
                      style:
                          AppTextStyle.bold16.copyWith(color: AppColors.white),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class _MarkDistributionTable extends StatelessWidget {
  const _MarkDistributionTable({
    required this.exam,
    required this.tableName,
  });

  final ExamModel exam;
  final String tableName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PillTitle(title: tableName),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: DataTable(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.white,
                ),
                border: TableBorder.all(
                  color: AppColors.primary,
                  style: BorderStyle.solid,
                  width: 1,
                  borderRadius: BorderRadius.circular(10),
                ),
                headingRowHeight: 38,
                dataRowHeight: 38,
                horizontalMargin: 12,
                columnSpacing: 12,
                columns: [
                  DataColumn(
                    label: _buildHeaderText(
                      TextConstants.examMode,
                    ),
                  ),
                  DataColumn(
                    label: _buildDataText(exam.mode!.toUpperCase()),
                  ),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(
                      _buildHeaderText(TextConstants.totalQuestion),
                    ),
                    DataCell(
                      _buildDataText('${exam.totalQuestions ?? '0 '} টি'),
                    ),
                  ]),
                  DataRow(cells: [
                    DataCell(
                      _buildHeaderText(TextConstants.totalTime),
                    ),
                    DataCell(
                      _buildDataText('${exam.duration ?? '0.00'} মিনিট'),
                    ),
                  ]),
                  DataRow(cells: [
                    DataCell(
                      _buildHeaderText(TextConstants.markPerQuestion),
                    ),
                    DataCell(
                      _buildDataText(exam.perQuestionMark ?? ''),
                    ),
                  ]),
                  DataRow(cells: [
                    DataCell(
                      _buildHeaderText(TextConstants.negativeMarking),
                    ),
                    DataCell(
                      _buildDataText(exam.negativeMark ?? ''),
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ExamTimingTable extends StatelessWidget {
  const _ExamTimingTable({
    required this.exam,
    required this.tableName,
  });

  final ExamModel exam;
  final String tableName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          PillTitle(title: tableName),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: DataTable(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.white,
                  ),
                  border: TableBorder.all(
                    color: AppColors.primary,
                    style: BorderStyle.solid,
                    width: 1,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  headingRowHeight: 38,
                  dataRowHeight: 38,
                  horizontalMargin: 12,
                  columnSpacing: 12,
                  columns: [
                    DataColumn(
                      label: _buildHeaderText(
                        TextConstants.examStartTime,
                      ),
                    ),
                    DataColumn(
                      label: _buildDataText(
                          DateFormat.yMMMMd().format(exam.startTime!)),
                    ),
                    DataColumn(
                      label: _buildDataText(
                          getFormattedTime(exam.startTime) ?? ''),
                    ),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(
                        _buildHeaderText(TextConstants.examEndTime),
                      ),
                      DataCell(
                        _buildDataText(
                            DateFormat.yMMMMd().format(exam.endTime!)),
                      ),
                      DataCell(
                        _buildDataText(getFormattedTime(exam.endTime) ?? ''),
                      ),
                    ]),
                    DataRow(cells: [
                      DataCell(
                        _buildHeaderText(TextConstants.resultPublishTime),
                      ),
                      DataCell(
                        _buildDataText(DateFormat.yMMMMd()
                            .format(exam.resultPublishTime!)),
                      ),
                      DataCell(
                        _buildDataText(
                          getFormattedTime(exam.resultPublishTime) ?? '',
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Text _buildHeaderText(String title) {
  return Text(
    title,
    style: AppTextStyle.semibold12,
  );
}

Widget _buildDataText(String title) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        title,
        textAlign: TextAlign.left,
        style: AppTextStyle.bold12,
      ),
    ],
  );
}
