import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/feature/exam/controller/exam_view_controller.dart';
import 'package:science_platform/src/feature/exam/controller/group_exam_view_controller.dart';
import 'package:science_platform/src/feature/home/model_test/models/model_test_models/group_exam_subject_model.dart';
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

class GroupExamPage extends StatefulWidget {
  const GroupExamPage({super.key});

  @override
  State<GroupExamPage> createState() => _GroupExamPageState();
}

class _GroupExamPageState extends State<GroupExamPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final examInfoController = Get.find<GroupExamViewController>();
  final controller = Get.find<ExamViewController>();

  @override
  void initState() {
    controller.getExamDetails(Get.arguments);

    _tabController = TabController(
      length: examInfoController.selectedSubjects.length,
      vsync: this,
    );

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.isLoading) {
          return false;
        }
        return false;
      },
      child: DefaultTabController(
        length: examInfoController.selectedSubjects.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(TextConstants.mcqQuestion),
            bottom: PreferredSize(
              preferredSize: Size(
                double.infinity,
                MediaQuery.of(context).viewPadding.top + 85,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                            padding: const EdgeInsets.all(5.0),
                            child: Center(
                              child: Obx(
                                () => controller.isLoading
                                    ? const CupertinoActivityIndicator()
                                    : CommonTimer(
                                        showHour: true,
                                        timerDuration: Duration(
                                          minutes:
                                              controller.examModel.duration ??
                                                  0,
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
                          height: 35,
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
                    const PillTitle(title: TextConstants.yourSubjects),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: 35,
                      child: TabBar(
                        onTap: (int index) {
                          examInfoController.subSelected(index);
                        },
                        isScrollable: true,
                        indicator: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        controller: _tabController,
                        tabs: List<Tab>.generate(
                          examInfoController.selectedSubjects.length,
                          (index) => Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(examInfoController
                                      .selectedSubjects[index].name ??
                                  ''),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const PillTitle(title: TextConstants.question),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          body: Obx(() {
            if (controller.isLoading) {
              return LoadingIndicator.list();
            } else if (controller.pageState == PageState.error) {
              return const GenericErrorFeedback();
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  controller: _tabController,
                  children: List<Tab>.generate(
                    examInfoController.selectedSubjects.length,
                    (index) => Tab(
                      child: _groupExamQuestionBuilder(
                        examInfoController,
                        _tabController,
                      ),
                    ),
                  ),
                ),
              );
            }
          }),
        ),
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

_groupExamQuestionBuilder(
  GroupExamViewController examInfoViewController,
  TabController tabController,
) {
  return Obx(
    () {
      GroupExamSubjectModel? selectedSubject = examInfoViewController
          .selectedSubjects[examInfoViewController.isSubSelected.value!];
      return ListView.builder(
        padding: const EdgeInsets.only(bottom: 50),
        itemCount: selectedSubject.mcqs?.length,
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          return MCQQuestionCard(
            tabBar: tabController,
            index: index,
            mcqModel: selectedSubject.mcqs![index],
            examMode: examInfoViewController.exam.mode!,
          );
        }),
      );
    },
  );
}