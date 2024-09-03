import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/core/widgets/shimmer_gradview_builder.dart';
import 'package:science_platform/src/core/widgets/shimmer_listview_builder.dart';
import 'package:science_platform/src/feature/courses/root/controller/course_view_controller.dart';
import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/course_card.dart';
import 'package:science_platform/src/widgets/has_no_data_feedback.dart';

class CourseTabPage extends GetView<CourseTabViewController> {
  const CourseTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextConstants.courses),
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: _CategoryWiseCoursesBuilder(
        controller: controller,
      ),
    );
  }
}

class _CategoryWiseCoursesBuilder extends StatelessWidget {
  const _CategoryWiseCoursesBuilder({
    required this.controller,
  });

  final CourseTabViewController controller;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.getCourses();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 5),
              child: _PillHeader(title: TextConstants.courseCategories),
            ),
            Obx(() {
              if (controller.isLoading) {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ShimmerGridViewBuilder(
                        itemCount: 2,
                        crossAxisCount: 2,
                        childAspectRatio: 3,
                      ),
                      ShimmerGridViewBuilder(
                        itemCount: 4,
                        childAspectRatio: 152 / 164,
                      ),
                    ],
                  ),
                );
              }

              if (controller.hasError) {
                return const Offstage();
              }

              if (controller.courseCategories.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: SizedBox(
                      height: 250,
                      child: HasNoDataFeedback(
                        imageWidth: 120,
                        onRefresh: () => controller.getCourses(),
                      ),
                    ),
                  ),
                );
              }
              return Column(
                children: [
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Obx(
                                () {
                                  if (controller.isLoading) {
                                    return const ShimmerListViewBuilder(
                                      itemHeight: 300,
                                      itemCount: 1,
                                    );
                                  }
                                  return Row(
                                    children: controller.courseCategories.map(
                                      (category) {
                                        return GestureDetector(
                                          onTap: () {
                                            controller.selectCategory(category);
                                          },
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 15,
                                              vertical: 8,
                                            ),
                                            margin:
                                                const EdgeInsets.only(right: 6),
                                            height: 45,
                                            decoration: BoxDecoration(
                                              color: (controller
                                                          .selectedCategory
                                                          .value ==
                                                      category)
                                                  ? AppColors.primaryDark
                                                  : AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: AppColors.primaryDark,
                                                width: 1.5,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                category.title ?? '',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                                style: AppTextStyle.bold14
                                                    .copyWith(
                                                  color: (controller
                                                              .selectedCategory
                                                              .value ==
                                                          category)
                                                      ? AppColors.white
                                                      : AppColors.primaryDark,
                                                  height: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        child: Container(
                          height: 30,
                          width: 18,
                          decoration: BoxDecoration(
                            color: AppColors.lightBlack10.withOpacity(0.8),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              size: 13,
                              color: AppColors.lightBlack90,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _SubCategoriesAndCourses(controller: controller)
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _PillHeader extends StatelessWidget {
  const _PillHeader({
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        top: 10,
        bottom: 15,
      ),
      child: Row(
        children: [
          Text(
            title,
            textAlign: TextAlign.left,
            style: AppTextStyle.bold16.copyWith(
              height: 21 / 16,
              color: AppColors.lightBlack90,
            ),
          ),
        ],
      ),
    );
  }
}

class _CourseBuilder extends StatelessWidget {
  const _CourseBuilder({
    required this.controller,
  });

  final CourseTabViewController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.isLoading) {
          return const Padding(
            padding: EdgeInsets.all(20.0),
            child: ShimmerGridViewBuilder(
              itemCount: 4,
              childAspectRatio: 152 / 164,
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            controller.getCourses();
          },
          child: (controller.allCourses.isNotEmpty)
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 152 / 164,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                  shrinkWrap: true,
                  itemCount: controller.allCourses.length,
                  itemBuilder: (context, index) {
                    CourseModel course = controller.allCourses[index];
                    return CourseCard(course: course);
                  },
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    controller.getCourses();
                  },
                  child: Center(
                    child: SizedBox(
                      height: 300,
                      child: HasNoDataFeedback(
                        imageWidth: 150,
                        imageHeight: 80,
                        onRefresh: () async {
                          controller.getCourses();
                        },
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class _SubCategoriesAndCourses extends StatelessWidget {
  const _SubCategoriesAndCourses({
    required this.controller,
  });

  final CourseTabViewController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Obx(
        () {
          if (controller.isLoading) {
            return const ShimmerGridViewBuilder(
              childAspectRatio: 152 / 164,
              itemCount: 2,
            );
          }

          return Column(
            children: [
              if (controller
                      .selectedCategory.value?.courseCategories?.isNotEmpty ??
                  false)
                GridView.builder(
                  padding: const EdgeInsets.only(bottom: 20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 3.5,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller
                          .selectedCategory.value?.courseCategories?.length ??
                      0,
                  itemBuilder: (BuildContext context, int index) {
                    final subcategory = controller
                        .selectedCategory.value?.courseCategories![index];

                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          Routes.subCategoryDetails,
                          arguments: [
                            subcategory?.slug,
                            controller.selectedCategory.value?.title,
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
                            maxLines: 1,
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
              Builder(builder: (context) {
                if (controller.selectedCategory.value?.courses?.isEmpty ??
                    true) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      controller.getCourses();
                    },
                    child: Center(
                      child: SizedBox(
                        height: 300,
                        child: HasNoDataFeedback(
                          imageWidth: 150,
                          imageHeight: 80,
                          onRefresh: () async {
                            controller.getCourses();
                          },
                        ),
                      ),
                    ),
                  );
                }
                return Column(
                  children: [
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 152 / 164,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          controller.selectedCategory.value?.courses?.length,
                      itemBuilder: (context, index) {
                        CourseModel course =
                            controller.selectedCategory.value!.courses![index];
                        return CourseCard(course: course);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              Routes.categoryDetails,
                              arguments:
                                  controller.selectedCategory.value?.slug,
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 8,
                            ),
                            margin: const EdgeInsets.only(top: 20),
                            height: 35,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                'View All',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: AppTextStyle.bold14.copyWith(
                                  color: AppColors.white,
                                  height: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
