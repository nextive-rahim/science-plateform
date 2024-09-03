import 'dart:async';

import 'package:get/get.dart';
import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/authentication/root/repository/auth_repository.dart';

class OtpVerificationViewController extends GetxController {
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

  Future<void> getOTP(String userNumber) async {
    _pageStateController(PageState.loading);

    try {
      await _repository.otp(userNumber);
      _pageStateController(PageState.success);
      Get.snackbar(
        'Success',
        'OTP Sent Successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
      Get.snackbar(
        'Failed',
        'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    _pageStateController(PageState.success);
  }

  Future<void> resendOTP(String userNumber) async {
    _pageStateController(PageState.loading);

    try {
      await _repository.otp(userNumber);

      Get.snackbar(
        'Success',
        'OTP Sent Successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
      _pageStateController(PageState.success);
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
}
