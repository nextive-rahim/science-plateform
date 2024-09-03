import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/core/validators/input_form_validators.dart';
import 'package:science_platform/src/feature/authentication/root/widgets/scrollable_wrapper.dart';
import 'package:science_platform/src/feature/authentication/root/widgets/subtitle_text.dart';
import 'package:science_platform/src/feature/authentication/root/widgets/title_text.dart';
import 'package:science_platform/src/feature/authentication/set_new_password/controller/set_new_password_view_controller.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/app_logo.dart';
import 'package:science_platform/src/widgets/outlined_input_field.dart';
import 'package:science_platform/src/widgets/primary_button.dart';

class SetNewPasswordPage extends GetView<SetNewPasswordViewController> {
  SetNewPasswordPage({super.key});

  /// Form key
  final formKey = GlobalKey<FormState>();

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
                  const TitleText(text: TextConstants.setNewPassword),
                  const SizedBox(height: 5),
                  const SubtitleText(text: TextConstants.setNewPasswordCaption),
                  const SizedBox(height: 30),
                  Form(
                    key: formKey,
                    child: _Form(controller: controller),
                  ),
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
                controller.resetPassword(formKey);
              },
              isLoading: controller.pageState == PageState.loading,
              widget: Text(
                TextConstants.confirm,
                style: AppTextStyle.bold16.copyWith(color: AppColors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({
    required this.controller,
  });

  final SetNewPasswordViewController controller;

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.controller.token != null
            ? OutlinedInputField(
                controller: widget.controller.otpController,
                hintText: TextConstants.otp,
                isPasswordField: true,
                validator: InputFieldValidator.password(),
                textInputAction: TextInputAction.done,
                onChanged: (v) {
                  if (v.isEmpty || v.length >= 6) {
                    setState(() {});
                  }
                },
              )
            : const Offstage(),
        OutlinedInputField(
          controller: widget.controller.passwordController,
          hintText: TextConstants.password,
          isPasswordField: true,
          validator: InputFieldValidator.password(),
          textInputAction: TextInputAction.done,
          onChanged: (v) {
            if (v.isEmpty || v.length >= 6) {
              setState(() {});
            }
          },
        ),
        OutlinedInputField(
          controller: widget.controller.confirmPasswordController,
          hintText: TextConstants.confirmPassword,
          isPasswordField: true,
          validator: InputFieldValidator.confirmPassword(
            password: widget.controller.passwordController.text,
            optional: widget.controller.passwordController.text.isEmpty,
          ),
          onChanged: (v) {
            if (v.isEmpty || v.length >= 6) {
              setState(() {});
            }
          },
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}
