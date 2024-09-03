import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:science_platform/src/feature/home/model_test/controller/model_test_view_controller.dart';
import 'package:science_platform/src/feature/home/model_test/widget/model_test_list_builder.dart';

class ModelTestPage extends GetView<ModelTestViewController> {
  const ModelTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Model Test'),
      // ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getModelTestData();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ModelTestsBuilder(controller: controller),
          ),
        ),
      ),
    );
  }
}
