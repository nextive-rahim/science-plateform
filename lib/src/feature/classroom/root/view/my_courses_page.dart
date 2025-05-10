import 'package:science_platform/src/feature/classroom/root/controller/classroom_view_controller.dart';
import 'package:science_platform/src/feature/classroom/root/widgets/my_courses_tab.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCoursesPage extends GetView<ClassroomViewController> {
  const MyCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Special Feature'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: MyCoursesTab(
          controller: controller,
        ),
      ),
    );
  }
}
