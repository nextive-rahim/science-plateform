import 'dart:async';

import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/authentication/forgot_password/controller/forgot_password_view_controller.dart';
import 'package:science_platform/src/feature/authentication/root/repository/auth_repository.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpViewController extends GetxController {
  final AuthenticationRepository _repository = AuthenticationRepository();

  late Timer timer;
  final RxInt remainingTime = 30.obs;
  RxBool showTimer = true.obs;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    showTimer(true);
    if (remainingTime.value == 0) {
      remainingTime.value = 30;
    }
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (remainingTime.value == 0) {
          timer.cancel();
          showTimer(false);
        } else {
          remainingTime.value--;
        }
      },
    );
  }

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);

  get pageState => _pageStateController.value;

  Future<void> resendOTP() async {
    String phoneNumber = Get.find<ForgotPasswordViewController>()
        .phoneController
        .text
        .replaceAll('-', '');

    try {
      await _repository.otp(phoneNumber);

      Get.snackbar(
        'Success',
        'OTP Sent Successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
      startTimer();
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      Get.snackbar(
        'Failed',
        'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
  }

  Future<void> checkOtpAndContinue() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    _pageStateController(PageState.loading);
    Get.toNamed(Routes.setNewPassword);
    _pageStateController(PageState.success);
  }

  /// Form key
  final formKey = GlobalKey<FormState>();

  /// Text Editing Controllers
  TextEditingController otpController = TextEditingController();
}
