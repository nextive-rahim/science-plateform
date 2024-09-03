import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

commonDialog({
  required BuildContext context,
  bool? isDismissible = true,
  final String? title,
  final String? description,
  final String? yesButtonText,
  final String? noButtonText,
  final Widget? bodyContent,
  required Function() onYesPressed,
  Function()? onNoPressed,
  bool? showNoButton = true,
}) {
  showDialog(
    context: context,
    barrierDismissible: isDismissible ?? false,
    builder: (_) {
      return WillPopScope(
        onWillPop: () async => isDismissible ?? false,
        child: AlertDialog(
          elevation: 0,
          contentPadding: const EdgeInsets.only(
            top: 30,
            left: 20,
            right: 20,
            bottom: 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          content: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                bodyContent ??
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title ?? TextConstants.popupTitle,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.bold20.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          description ?? TextConstants.logoutCaption,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.medium14.copyWith(
                            height: 18 / 14,
                            color: AppColors.lightBlack40,
                          ),
                        ),
                      ],
                    ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (showNoButton == true)
                        ? Container(
                            height: 34,
                            width: 100,
                            margin: const EdgeInsets.only(right: 25),
                            child: PrimaryButton(
                              backgroundColor: AppColors.red,
                              onTap: onNoPressed ?? () => Get.back(),
                              widget: Text(
                                noButtonText ?? TextConstants.cancel,
                                style: AppTextStyle.bold12
                                    .copyWith(color: AppColors.white),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: 34,
                      width: 100,
                      child: PrimaryButton(
                        backgroundColor: AppColors.primary,
                        onTap: onYesPressed,
                        widget: Text(
                          yesButtonText ?? TextConstants.confirm,
                          style: AppTextStyle.bold12
                              .copyWith(color: AppColors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
