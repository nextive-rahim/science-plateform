import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/core/validators/input_form_validators.dart';
import 'package:science_platform/src/feature/authentication/otp/controller/otp_view_controller.dart';
import 'package:science_platform/src/feature/authentication/root/widgets/confirmation_text.dart';
import 'package:science_platform/src/feature/authentication/root/widgets/k_text_button.dart';
import 'package:science_platform/src/feature/authentication/root/widgets/scrollable_wrapper.dart';
import 'package:science_platform/src/feature/authentication/root/widgets/subtitle_text.dart';
import 'package:science_platform/src/feature/authentication/root/widgets/title_text.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/app_logo.dart';
import 'package:science_platform/src/widgets/outlined_input_field.dart';
import 'package:science_platform/src/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OtpPage extends GetView<OtpViewController> {
  const OtpPage({super.key});

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
                    key: controller.formKey,
                    child: OutlinedInputField(
                      controller: controller.otpController,
                      hintText: TextConstants.otp,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: InputFieldValidator.otp(),
                    ),
                  ),
                  const SizedBox(height: 200),
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          left: 37,
          right: 5,
        ),
        child: Obx(
          () {
            return PrimaryButton(
              onTap: () {
                controller.checkOtpAndContinue();
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

  _buildOTPWidget() {
    return Obx(
      () {
        return controller.showTimer.value
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
                  Text(
                    ' 00:${controller.remainingTime.value}',
                    style: AppTextStyle.semibold14.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 5),
                ],
              )
            : KTextButton(
                label: TextConstants.resendOTP,
                onTap: () {
                  controller.resendOTP();
                },
              );
      },
    );
  }
}
