import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/courses/free_courses/controller/free_courses_view_controller.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FreeCoursesPage extends GetView<FreeCoursesViewController> {
  const FreeCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextConstants.freeCourses),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemCount: controller.freeCoursePageItems.length,
        itemBuilder: (BuildContext context, int index) {
          final item = controller.freeCoursePageItems[index];

          return GestureDetector(
            onTap: item['onTap'],
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.lightBlack20,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    item['icon'],
                    fit: BoxFit.cover,
                    scale: 1,
                    height: 65,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    item['title'],
                    style: AppTextStyle.semiBold16.copyWith(
                      color: AppColors.lightBlack90,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
