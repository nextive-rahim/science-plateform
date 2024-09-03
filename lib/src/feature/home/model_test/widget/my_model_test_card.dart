import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/classroom/root/controller/classroom_view_controller.dart';
import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/feature/home/model_test/widget/model_test_card.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';
import 'package:science_platform/src/widgets/pill_title.dart';

class MyModelTestCard extends GetView<ClassroomViewController> {
  const MyModelTestCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MyModelTestsBuilder(controller: controller);
  }
}

class MyModelTestsBuilder extends StatelessWidget {
  const MyModelTestsBuilder({
    super.key,
    required this.controller,
  });
  final ClassroomViewController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.modeltestState == PageState.loading) {
          return LoadingIndicator.card().marginOnly(bottom: 20);
        }
        if (controller.pageState == PageState.error) {
          return const Offstage();
        }
        if (controller.myModelTests.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PillTitle(title: 'My Model Test'),
              const SizedBox(height: 20),
              RefreshIndicator(
                onRefresh: () async {
                  controller.getMyModelTest();
                },
                child: SizedBox(
                  height: 205,
                  child: GridView.builder(
                    padding: const EdgeInsets.only(bottom: 50),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: controller.myModelTests.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      CourseModel modelTest = controller.myModelTests[index];
                      return ModelTestCard(
                        modelTest: modelTest,
                        showDetails: false,
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Offstage();
        }
      },
    );
  }
}
