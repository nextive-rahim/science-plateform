import 'dart:async';

import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/authentication/root/repository/auth_repository.dart';
import 'package:science_platform/src/feature/authentication/signup/model/phone_number_verification_model.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneNumberVerificationViewController extends GetxController {
  final AuthenticationRepository _repository = AuthenticationRepository();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);

  get pageState => _pageStateController.value;
  PhoneNumberVerificationResponseModel? _phoneNumberVerificationResponseModel;

  Future<void> phoneNumberVerification(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    _pageStateController(PageState.loading);

    Map<String, dynamic> requestBody = {
      'otp': otpController.text,
    };

    try {
      final res = await _repository.phoneNumberVerification(requestBody);
      _phoneNumberVerificationResponseModel =
          PhoneNumberVerificationResponseModel.fromJson(res);

      _pageStateController(PageState.success);

      if (_phoneNumberVerificationResponseModel!.status == 'success') {
        Get.toNamed(Routes.dashboard);
        otpController.clear();
      } else {
        Get.snackbar(
          'Warning',
          'Wrong OTP input',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
    }
  }

  /// Text Editing Controllers
  TextEditingController otpController = TextEditingController();
}
