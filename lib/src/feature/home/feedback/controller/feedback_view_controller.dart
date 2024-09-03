import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/home/feedback/repository/feedback_repository.dart';
import 'package:science_platform/src/feature/profile/controller/profile_view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FeedbackViewController extends GetxController {
  final FeedbackRepository _repository = FeedbackRepository();

  /// Page State
  final Rx<PageState> pageStateController = Rx(PageState.initial);

  bool get isLoading => pageState == PageState.loading;

  get pageState => pageStateController.value;

  Future<void> feedbackMessage() async {
    if (feedbackController.text.isEmpty || subjectController.text.isEmpty) {
      Get.snackbar(
        'Failed',
        'Please provide the required information!',
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }
    pageStateController(PageState.loading);

    Map<String, String> requestBody = {
      "phone": phoneController.text,
      "name": nameController.text,
      "message": feedbackController.text,
      "subject": subjectController.text,
    };

    try {
      await _repository.feedback(requestBody);

      pageStateController(PageState.success);

      clearTextField();
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      pageStateController(PageState.error);
      Get.snackbar(
        'Failed',
        'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void clearTextField() {
    feedbackController.clear();
    subjectController.clear();
  }

  void populateTextFields() {
    final profileController = Get.find<ProfileViewController>();
    nameController.text = profileController.userModel.name;
    phoneController.text = profileController.userModel.phone;
  }

  final formKey = GlobalKey<FormState>();

  /// Text Editing Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();
}
