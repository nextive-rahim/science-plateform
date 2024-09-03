import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/service/cache/cache_keys.dart';
import 'package:science_platform/src/core/service/cache/cache_service.dart';
import 'package:science_platform/src/feature/authentication/forgot_password/controller/forgot_password_view_controller.dart';
import 'package:science_platform/src/feature/authentication/otp/controller/otp_view_controller.dart';
import 'package:science_platform/src/feature/authentication/root/repository/auth_repository.dart';
import 'package:science_platform/src/feature/profile/controller/profile_view_controller.dart';
import 'package:science_platform/src/routes/app_pages.dart';

class SetNewPasswordViewController extends GetxController {
  final AuthenticationRepository _repository = AuthenticationRepository();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);

  get pageState => _pageStateController.value;
  final token = CacheService.boxAuth.read(CacheKeys.token);
  final profileViewController = Get.find<ProfileViewController>();
  Future<void> resetPassword(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    _pageStateController(PageState.loading);
    String phoneNumber = token != null
        ? profileViewController.userModel.phone
        : Get.find<ForgotPasswordViewController>()
            .phoneController
            .text
            .replaceAll('-', '');

    String otp = token != null
        ? otpController.text
        : Get.find<OtpViewController>().otpController.text.replaceAll('-', '');
    Map<String, dynamic> requestBody = {
      'phone': phoneNumber,
      'password': passwordController.text,
      'password_confirmation': confirmPasswordController.text,
      '_method': 'PUT',
      'otp': otp,
    };

    try {
      final res = await _repository.resetPassword(requestBody);
      _pageStateController(PageState.success);
      if (res['status'] == 'error') {
        Get.snackbar(
          'Failed',
          token == null ? 'Otp expired!' : 'Invalid Otp or Otp expired!',
          snackPosition: SnackPosition.TOP,
        );
      } else {
        Get.snackbar(
          'Success',
          'Password reset Successfully',
          snackPosition: SnackPosition.TOP,
        );
        clearTextFields();
        token == null
            ? Get.until((route) => Get.currentRoute == Routes.login)
            : Get.offNamed(Routes.profileInfo);
      }
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
      return;
    }
  }

  /// Text Editing Controllers
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  void clearTextFields() {
    passwordController.clear();
    confirmPasswordController.clear();
  }
}
