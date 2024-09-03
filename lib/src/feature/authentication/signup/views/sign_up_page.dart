import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/core/validators/input_form_validators.dart';
import 'package:science_platform/src/feature/authentication/root/widgets/phone_number_field_prefix.dart';
import 'package:science_platform/src/feature/authentication/root/widgets/scrollable_wrapper.dart';
import 'package:science_platform/src/feature/authentication/root/widgets/subtitle_text.dart';
import 'package:science_platform/src/feature/authentication/root/widgets/title_text.dart';
import 'package:science_platform/src/feature/authentication/signup/controller/sign_up_view_controller.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/app_logo.dart';
import 'package:science_platform/src/widgets/outlined_input_field.dart';
import 'package:science_platform/src/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends GetView<SignUpViewController> {
  SignUpPage({super.key});

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
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppLogo(),
                  const TitleText(text: TextConstants.register),
                  const SizedBox(height: 5),
                  const SubtitleText(text: TextConstants.registerCaption),
                  const SizedBox(height: 30),
                  Form(
                    key: formKey,
                    child: _Form(controller: controller),
                  ),
                  const SizedBox(height: 20),
                  _buildFooter(),
                  const SizedBox(height: 100)
                ],
              ),
            ),
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
              onTap: () async {
                await controller.signUp(formKey);
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

  final SignUpViewController controller;

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedInputField(
          controller: widget.controller.nameController,
          hintText: TextConstants.fullName,
          validator: InputFieldValidator.name(),
        ),
        OutlinedInputField(
          controller: widget.controller.instituteNameController,
          hintText: TextConstants.currentInstitution,
          keyboardType: TextInputType.name,
          validator: InputFieldValidator.name(),
        ),
        OutlinedInputField(
          controller: widget.controller.sessionController,
          hintText: TextConstants.session,
          keyboardType: TextInputType.name,
          validator: InputFieldValidator.name(),
        ),
        OutlinedInputField(
          controller: widget.controller.phoneController,
          hintText: "01xxxxxxxxx",
          prefix: const PhoneNumberFieldPrefix(),
          validator: InputFieldValidator.phoneNumber(),
        ),
        OutlinedInputField(
          controller: widget.controller.emailController,
          hintText: TextConstants.email,
          // validator: InputFieldValidator.name(),
        ),
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

Widget _buildFooter() {
  return Column(
    children: [
      Text(
        TextConstants.registrationConfirmationLeading,
        style: AppTextStyle.medium12.copyWith(
          color: AppColors.lightBlack60,
        ),
      ),
      const SizedBox(height: 5),
      GestureDetector(
        onTap: () {
          Get.offNamed(Routes.login);
        },
        child: Text(
          TextConstants.registrationConfirmationButtonTitle,
          style: AppTextStyle.medium12.copyWith(
            color: AppColors.primary,
            decoration: TextDecoration.underline,
          ),
        ),
      )
    ],
  );
}
