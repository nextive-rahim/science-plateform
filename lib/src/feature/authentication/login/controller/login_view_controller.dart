import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/service/cache/cache_keys.dart';
import 'package:science_platform/src/core/service/cache/cache_service.dart';
import 'package:science_platform/src/feature/authentication/root/repository/auth_repository.dart';
import 'package:science_platform/src/feature/profile/model/user_model.dart';
import 'package:science_platform/src/routes/app_pages.dart';

class LoginViewController extends GetxController {
  final AuthenticationRepository _repository = AuthenticationRepository();

  RxBool rememberMe = false.obs;

  toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);

  get pageState => _pageStateController.value;
  late UserModel userModel;

  /// User
  Future<void> login(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    _pageStateController(PageState.loading);

    try {
      Map<String, dynamic> requestBody = {
        'phone': phoneController.text.replaceAll('-', ''),
        'password': passwordController.text,
      };

      final res = await _repository.login(requestBody);
      userModel = UserModel.fromJson(res['user']);
      String userTokens = res['token'];
      CacheService.boxAuth.write(CacheKeys.user, userModel.toJson());
      CacheService.boxAuth.write(CacheKeys.token, userTokens);

      if (rememberMe.value == true) {
        //TODO: Implement remember me
      }
      _pageStateController(PageState.success);
      // if (userModel.phoneVerifiedAt != null) {
      Get.offAllNamed(Routes.dashboard);
      clearTextFields();
      //  } else {
      //  await Get.find<OtpVerificationViewController>().getOTP(userModel.phone);
      // Get.toNamed(Routes.confirmPhoneNumber);
      // clearTextFields();
      //  }
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
      return;
    }
    _pageStateController(PageState.success);
  }

  /// Text Editing Controllers
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void clearTextFields() {
    phoneController.clear();
    passwordController.clear();
  }
}
