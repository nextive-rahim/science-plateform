import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/courses/root/controller/category_details_view_controller.dart';
import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/widgets/course_card.dart';
import 'package:science_platform/src/widgets/error_feedback.dart';
import 'package:science_platform/src/widgets/has_no_data_feedback.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';

class CategoryDetailsPage extends GetView<CategoryDetailsViewController> {
  CategoryDetailsPage({
    super.key,
  }) {
    controller.getCourseList(Get.arguments);
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
            return Text(controller.categoryModel?.title ?? 'Category');
          } else {
            return const Text('Category');
          }
        }),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getCourseList(Get.arguments);
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

              return Column(
                children: [
                  if (controller.categoryModel?.courseCategories?.isNotEmpty ??
                      false)
                    GridView.builder(
                      padding: const EdgeInsets.only(bottom: 20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 3,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          controller.categoryModel?.courseCategories?.length ??
                              0,
                      itemBuilder: (BuildContext context, int index) {
                        final subcategory =
                            controller.categoryModel?.courseCategories![index];

                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              Routes.subCategoryDetails,
                              arguments: [
                                subcategory?.slug,
                                controller.categoryModel?.title,
                              ],
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.primaryDark,
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                subcategory?.title ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: AppTextStyle.bold14.copyWith(
                                  color: AppColors.primaryDark,
                                  height: 1,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  _CourseListBuilder(controller: controller),
                ],
              );
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

  final CategoryDetailsViewController controller;

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
