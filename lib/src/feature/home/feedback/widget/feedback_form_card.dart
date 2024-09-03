import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/feature/home/feedback/controller/feedback_view_controller.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/outlined_input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackFormCard extends GetView<FeedbackViewController> {
  FeedbackFormCard({super.key}) {
    controller.populateTextFields();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(TextConstants.fullName),
        OutlinedInputField(
          isEnabled: false,
          controller: controller.nameController,
          hintText: TextConstants.fullName,
        ),
        _buildLabel(TextConstants.phoneNumber),
        OutlinedInputField(
          isEnabled: false,
          controller: controller.phoneController,
          hintText: TextConstants.phone,
        ),
        _buildLabel(TextConstants.subject),
        OutlinedInputField(
          controller: controller.subjectController,
          hintText: TextConstants.subject,
          fillColor: AppColors.white,
        ),
        _buildLabel(TextConstants.message),
        OutlinedInputField(
          fillColor: AppColors.white,
          controller: controller.feedbackController,
          hintText: TextConstants.writeYourMessage,
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
          minLines: 7,
          maxLines: 25,
        ),
      ],
    );
  }

  Text _buildLabel(String labelText) {
    return Text(
      labelText,
      style: const TextStyle(
        color: AppColors.primary,
        fontFamily: 'NotoSerifBengali',
      ),
    );
  }
}
