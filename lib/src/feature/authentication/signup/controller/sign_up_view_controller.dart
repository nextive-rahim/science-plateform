import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/service/cache/cache_keys.dart';
import 'package:science_platform/src/core/service/cache/cache_service.dart';
import 'package:science_platform/src/feature/authentication/root/repository/auth_repository.dart';
import 'package:science_platform/src/feature/profile/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/routes/app_pages.dart';

class SignUpViewController extends GetxController {
  final AuthenticationRepository _repository = AuthenticationRepository();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);

  get pageState => _pageStateController.value;
  late UserModel userModel;

  Future<void> signUp(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    _pageStateController(PageState.loading);

    Map<String, dynamic> requestBody = {
      'name': nameController.text,
      'institution': instituteNameController.text,
      'educational_session': sessionController.text,
      'phone': phoneController.text.replaceAll('-', ''),
      'email': emailController.text,
      'password': passwordController.text,
      'password_confirmation': confirmPasswordController.text,
    };

    try {
      final res = await _repository.signUp(requestBody);
      userModel = UserModel.fromJson(res['user']);
      String userTokens = res['token'];
      CacheService.boxAuth.write(CacheKeys.user, userModel.toJson());
      CacheService.boxAuth.write(CacheKeys.token, userTokens);
      _pageStateController(PageState.success);
      //if (userModel.phoneVerifiedAt != null) {
      Get.offAllNamed(Routes.dashboard);
      Get.snackbar(
        'Success',
        'Register Successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
      // } else {
      //   await Get.find<OtpVerificationViewController>().getOTP(userModel.phone);
      //   Get.toNamed(Routes.confirmPhoneNumber);
      // }
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
      return;
    }
    _pageStateController(PageState.success);
  }

  /// Text Editing Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController sessionController = TextEditingController();
  TextEditingController instituteNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void clearTextFields() {
    nameController.clear();
    instituteNameController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
}
