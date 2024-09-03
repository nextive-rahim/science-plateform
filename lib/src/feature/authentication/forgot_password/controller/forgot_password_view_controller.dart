import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/authentication/root/repository/auth_repository.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordViewController extends GetxController {
  final AuthenticationRepository _repository = AuthenticationRepository();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);

  get pageState => _pageStateController.value;

  Future<void> getOTP() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    _pageStateController(PageState.loading);

    String phoneNumber = phoneController.text.replaceAll('-', '');

    try {
      await _repository.otp(phoneNumber);

      Get.snackbar(
        'Success',
        'OTP Sent Successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.toNamed(Routes.otp);
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
      return;
    }
    _pageStateController(PageState.success);
  }

  /// Form key
  final formKey = GlobalKey<FormState>();

  /// Text Editing Controllers
  TextEditingController phoneController = TextEditingController();

  void clearTextFields() {
    phoneController.clear();
  }
}
