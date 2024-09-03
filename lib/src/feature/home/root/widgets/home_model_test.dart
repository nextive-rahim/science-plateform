import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/feature/home/model_test/widget/model_test_card.dart';
import 'package:science_platform/src/feature/home/root/controllers/home_view_controller.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';

class HomeModelTest extends GetView<HomeViewController> {
  const HomeModelTest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Obx(
            () {
              if (controller.isLoading) {
                return LoadingIndicator.card();
              }
              if (controller.pageState == PageState.error) {
                return const Offstage();
              }
              if (controller.featuredModelTests.isNotEmpty) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'মডেল টেস্টসমূহ',
                          style: AppTextStyle.bold16.copyWith(
                            height: 25 / 16,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 50),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        mainAxisExtent: 228,
                      ),
                      itemCount: controller.featuredModelTests.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, index) {
                        CourseModel modelTest =
                            controller.featuredModelTests[index];
                        return ModelTestCard(
                          modelTest: modelTest,
                        );
                      },
                    ),
                  ],
                );
              } else {
                return const Offstage();
              }
            },
          ),
        ],
      ),
    );
  }
}
