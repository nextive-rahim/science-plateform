import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/core/validators/input_form_validators.dart';
import 'package:science_platform/src/feature/authentication/login/controller/login_view_controller.dart';
import 'package:science_platform/src/feature/authentication/root/widgets/phone_number_field_prefix.dart';
import 'package:science_platform/src/feature/authentication/root/widgets/scrollable_wrapper.dart';
import 'package:science_platform/src/feature/authentication/root/widgets/subtitle_text.dart';
import 'package:science_platform/src/feature/authentication/root/widgets/title_text.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/app_logo.dart';
import 'package:science_platform/src/widgets/outlined_input_field.dart';
import 'package:science_platform/src/widgets/primary_button.dart';

class LoginPage extends GetView<LoginViewController> {
  LoginPage({super.key});

  /// Form key
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollableWrapper(
        child: Obx(() {
          return AbsorbPointer(
            absorbing: controller.pageState == PageState.loading,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AppLogo(),
                      const TitleText(text: TextConstants.login),
                      const SizedBox(height: 5),
                      const SubtitleText(text: TextConstants.loginCaption),
                      const SizedBox(height: 30),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            OutlinedInputField(
                              controller: controller.phoneController,
                              hintText: TextConstants.phone,
                              keyboardType: TextInputType.phone,
                              validator: InputFieldValidator.phoneNumber(),
                              prefix: const PhoneNumberFieldPrefix(),
                            ),
                            OutlinedInputField(
                              controller: controller.passwordController,
                              hintText: TextConstants.password,
                              isPasswordField: true,
                              validator: InputFieldValidator.password(),
                              textInputAction: TextInputAction.done,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buildForgotPassword(),
                        ],
                      ),
                      const SizedBox(height: 40),
                      _buildFooter(),
                      const SizedBox(height: 30),
                      Obx(
                        () {
                          return PrimaryButton(
                            onTap: () {
                              controller.login(formKey);
                            },
                            isLoading:
                                controller.pageState == PageState.loading,
                            widget: Text(
                              TextConstants.login,
                              style: AppTextStyle.bold16
                                  .copyWith(color: AppColors.white),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildForgotPassword() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.forgotPassword);
      },
      child: const Text(
        TextConstants.loginPasswordConfirmationButtonTitle,
        style: TextStyle(color: AppColors.primary),
      ),
    );
  }

  Obx _buildRememberMe() {
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.toggleRememberMe();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              controller.rememberMe.value == true
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              color: AppColors.primary,
              size: 18,
            ),
            const SizedBox(width: 5),
            Text(
              TextConstants.rememberMe,
              style: AppTextStyle.regular12.copyWith(
                color: AppColors.lightBlack60,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Text(
          TextConstants.loginConfirmationLeading,
          style: AppTextStyle.regular12.copyWith(fontSize: 14),
        ),
        const SizedBox(height: 3),
        GestureDetector(
          onTap: () {
            Get.offNamed(Routes.signup);
          },
          child: Text(
            TextConstants.loginConfirmationButtonTitle,
            style: AppTextStyle.medium12.copyWith(
              color: AppColors.primary,
              fontSize: 14,
            ),
          ),
        )
      ],
    );
  }
}
