import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/courses/root/controller/sub_category_details_view_controller.dart';
import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/widgets/course_card.dart';
import 'package:science_platform/src/widgets/error_feedback.dart';
import 'package:science_platform/src/widgets/has_no_data_feedback.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';

class SubCategoryDetailsPage extends GetView<SubCategoryDetailsViewController> {
  SubCategoryDetailsPage({
    super.key,
  }) {
    controller.getCourseList(Get.arguments[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            size: 20,
          ),
          color: AppColors.white,
          onPressed: () {
            Get.back();
          },
        ),
        titleTextStyle: AppTextStyle.bold16.copyWith(
          color: AppColors.white,
        ),
        title: Obx(() {
          if (controller.pageState == PageState.loading) {
            return const Text('');
          }
          if (controller.pageState == PageState.success) {
            if (Get.arguments[1] != null) {
              return Text(
                '${Get.arguments[1]} / ${controller.categoryModel?.title}',
              );
            } else if (controller.categoryModel != null) {
              return Text(controller.categoryModel?.title ?? 'Sub Category');
            } else {
              return const Text('Sub Category');
            }
          } else {
            return const Text('Sub Category');
          }
        }),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getCourseList(Get.arguments[0]);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: 100,
          ),
          child: Obx(
            () {
              if (controller.pageState == PageState.loading) {
                return LoadingIndicator.list();
              }
              if (controller.pageState == PageState.error) {
                return const GenericErrorFeedback();
              }

              return _CourseListBuilder(controller: controller);
            },
          ),
        ),
      ),
    );
  }
}

class _CourseListBuilder extends StatelessWidget {
  const _CourseListBuilder({
    required this.controller,
  });

  final SubCategoryDetailsViewController controller;

  @override
  Widget build(BuildContext context) {
    return (controller.courses.isNotEmpty)
        ? GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.courses.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 152 / 164,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemBuilder: (context, index) {
              CourseModel course = controller.courses[index];
              return CourseCard(course: course);
            },
          )
        : const SizedBox(
            height: 400,
            child: Center(
              child: HasNoDataFeedback(
                imageHeight: 80,
                canRefresh: false,
              ),
            ),
          );
  }
}
