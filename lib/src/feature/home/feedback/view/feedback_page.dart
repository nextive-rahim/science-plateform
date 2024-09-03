import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/authentication/root/widgets/scrollable_wrapper.dart';
import 'package:science_platform/src/feature/home/feedback/controller/feedback_view_controller.dart';
import 'package:science_platform/src/feature/home/feedback/widget/feedback_form_card.dart';
import 'package:science_platform/src/utils/assets.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/custom_app_bar.dart';
import 'package:science_platform/src/widgets/primary_button.dart';
import 'package:science_platform/src/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackPage extends GetView<FeedbackViewController> {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: TextConstants.feedback,
      ),
      body: ScrollableWrapper(
        dismissKeyboard: false,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: 100,
          ),
          child: Column(
            children: [
              Form(
                key: controller.formKey,
                child: FeedbackFormCard(),
              ),
            ],
          ),
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
                await controller.feedbackMessage().then((value) {
                  return showFeedbackDialog(context);
                });
              },
              isLoading: controller.isLoading,
              widget: Text(
                TextConstants.send,
                style: AppTextStyle.bold16.copyWith(color: AppColors.white),
              ),
            );
          },
        ),
      ),
    );
  }

  showFeedbackDialog(BuildContext context) {
    if (controller.pageState == PageState.success) {
      return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 0,
            contentPadding: const EdgeInsets.only(
              bottom: 20,
              top: 0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(39),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  Assets.feedbackSent,
                ),
                const SizedBox(height: 10),
                const Text(
                  TextConstants.feedbackSent,
                  style: AppTextStyle.medium16,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  width: 200,
                  child: RoundedButton(
                    title: 'Okay!',
                    onPressed: () {
                      controller.pageStateController(PageState.initial);
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }
}
