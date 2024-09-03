import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/core/validators/input_form_validators.dart';
import 'package:science_platform/src/feature/authentication/forgot_password/controller/forgot_password_view_controller.dart';
import 'package:science_platform/src/feature/authentication/root/widgets/phone_number_field_prefix.dart';
import 'package:science_platform/src/feature/authentication/root/widgets/scrollable_wrapper.dart';
import 'package:science_platform/src/feature/authentication/root/widgets/subtitle_text.dart';
import 'package:science_platform/src/feature/authentication/root/widgets/title_text.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/app_logo.dart';
import 'package:science_platform/src/widgets/outlined_input_field.dart';
import 'package:science_platform/src/widgets/primary_button.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordViewController> {
  const ForgotPasswordPage({super.key});

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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const AppLogo(),
                      const TitleText(text: TextConstants.forgotPassword),
                      const SizedBox(height: 5),
                      const SubtitleText(
                        text: TextConstants.forgotPasswordCaption,
                      ),
                      const SizedBox(height: 30),
                      Form(
                        key: controller.formKey,
                        child: OutlinedInputField(
                          controller: controller.phoneController,
                          hintText: "01xxxxxxxxx",
                          keyboardType: TextInputType.phone,
                          validator: InputFieldValidator.phoneNumber(),
                          prefix: const PhoneNumberFieldPrefix(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          );
        }),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          left: 37,
          right: 5,
        ),
        child: Obx(
          () {
            return PrimaryButton(
              onTap: () async {
                if (!controller.formKey.currentState!.validate()) {
                  return;
                }
                await controller.getOTP();
                Get.toNamed(Routes.otp);
              },
              isLoading: controller.pageState == PageState.loading,
              widget: Text(
                TextConstants.continueText,
                style: AppTextStyle.bold16.copyWith(color: AppColors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}
