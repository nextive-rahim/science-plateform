import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/feature/exam/controller/group_exam_view_controller.dart';
import 'package:science_platform/src/feature/home/model_test/models/model_test_models/group_exam_subject_model.dart';
import 'package:science_platform/src/utils/assets.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubjectCard extends StatelessWidget {
  const SubjectCard({
    super.key,
    required this.controller,
  });
  final GroupExamViewController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.pageState == PageState.loading) {
          LoadingIndicator.list();
        }
        return ListView.builder(
          itemCount: controller.groupSubjects.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: ((context, index) {
            GroupExamSubjectModel groupSubject =
                controller.groupSubjects[index];
            return Obx(
              () => GestureDetector(
                onTap: () => groupSubject.isRequired == false
                    ? controller.selectedSubject(groupSubject)
                    : null,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: controller.selectedSubjects
                              .any((element) => element == groupSubject)
                          ? AppColors.primary10
                          : AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: controller.selectedSubjects
                                .any((element) => element == groupSubject)
                            ? AppColors.primary
                            : AppColors.white,
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        title: Text(groupSubject.name ?? ''),
                        trailing: groupSubject.isRequired == true
                            ? SizedBox(
                                height: 22,
                                width: 22,
                                child: Image.asset(Assets.check),
                              )
                            : const Offstage(),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
