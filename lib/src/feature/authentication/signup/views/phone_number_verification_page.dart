import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/core/validators/input_form_validators.dart';
import 'package:science_platform/src/feature/authentication/root/widgets/confirmation_text.dart';
import 'package:science_platform/src/feature/authentication/root/widgets/k_text_button.dart';
import 'package:science_platform/src/feature/authentication/root/widgets/scrollable_wrapper.dart';
import 'package:science_platform/src/feature/authentication/root/widgets/subtitle_text.dart';
import 'package:science_platform/src/feature/authentication/root/widgets/title_text.dart';
import 'package:science_platform/src/feature/authentication/signup/controller/otp_verification_view_controller.dart.dart';
import 'package:science_platform/src/feature/authentication/signup/controller/phone_number_verification_view_controller.dart';
import 'package:science_platform/src/feature/profile/controller/profile_view_controller.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/app_logo.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';
import 'package:science_platform/src/widgets/outlined_input_field.dart';
import 'package:science_platform/src/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PhoneNumberVerificationPage
    extends GetView<PhoneNumberVerificationViewController> {
  PhoneNumberVerificationPage({super.key});
  final formKey = GlobalKey<FormState>();
  final profileController = Get.find<ProfileViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollableWrapper(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AppLogo(),
                  const TitleText(text: TextConstants.verifyPhone),
                  const SizedBox(height: 5),
                  const SubtitleText(text: TextConstants.verifyPhoneCaption),
                  const SizedBox(height: 30),
                  Form(
                    key: formKey,
                    child: OutlinedInputField(
                      controller: controller.otpController,
                      hintText: TextConstants.otp,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: InputFieldValidator.otp(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const ConfirmationText(text: TextConstants.didntReceiveCode),
                  _buildOTPWidget(),
                  const SizedBox(height: 19),
                ],
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: PrimaryButton(
              onTap: () async {
                await controller.phoneNumberVerification(formKey);
              },
              isLoading: controller.pageState == PageState.loading,
              widget: Text(
                TextConstants.continueText,
                style: AppTextStyle.bold16.copyWith(color: AppColors.white),
              ),
            ),
          );
        },
      ),
    );
  }

  _buildOTPWidget() {
    final otpController = Get.find<OtpVerificationViewController>();
    return Obx(
      () {
        if (controller.pageState == PageState.loading) {
          LoadingIndicator.list();
        }

        return otpController.showTimer.value
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    TextConstants.remainingResendOTPTime,
                    style: AppTextStyle.semibold14.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.lightBlack60,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '00:${otpController.remainingTime.value}',
                    style: AppTextStyle.semibold14.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              )
            : KTextButton(
                label: TextConstants.resendOTP,
                onTap: () {
                  otpController.resendOTP(profileController.userModel.phone);
                },
              );
      },
    );
  }
}
