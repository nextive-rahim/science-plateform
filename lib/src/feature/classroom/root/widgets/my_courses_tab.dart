import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/core/widgets/shimmer_gradview_builder.dart';
import 'package:science_platform/src/feature/classroom/root/controller/classroom_view_controller.dart';
import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/feature/dashboard/controller/dashboard_view_controller.dart';
import 'package:science_platform/src/widgets/course_card.dart';

class MyCoursesTab extends StatelessWidget {
  const MyCoursesTab({
    super.key,
    required this.controller,
  });

  final ClassroomViewController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
        top: 20,
      ),
      child: Obx(
        () {
          if (controller.isLoading) {
            return const SizedBox(
              height: 180,
              child: ShimmerGridViewBuilder(
                itemCount: 2,
                childAspectRatio: .9,
              ),
            );
          }
          if (controller.hasError) {
            return const Offstage();
          } else {
            if (controller.myCourses.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  controller.fetchMyCourses();
                },
                child: SizedBox(
                  height: 180,
                  child: GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.myCourses.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: .9,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    itemBuilder: (context, index) {
                      CourseModel courseModel = controller.myCourses[index];
                      return CourseCard(
                        course: courseModel,
                        showDetails: false,
                      );
                    },
                  ),
                ),
              );
            } else {
              return Container(
                height: 150,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.white,
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.5),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'You have not enrolled in any courses yet!',
                        style: AppTextStyle.semibold14.copyWith(
                          color: AppColors.lightBlack60,
                        ),
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          Get.find<DashboardViewController>().updateIndex(1);
                        },
                        child: Text(
                          'Browse Our Courses',
                          style: AppTextStyle.bold14.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
