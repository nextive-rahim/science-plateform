import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoutDialog extends StatelessWidget {
  final Function() onYesPressed;

  const LogoutDialog({
    super.key,
    required this.onYesPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
            Text(
              TextConstants.popupTitle,
              style: AppTextStyle.bold20.copyWith(
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              TextConstants.logoutCaption,
              textAlign: TextAlign.center,
              style: AppTextStyle.medium12.copyWith(
                height: 18 / 12,
                color: AppColors.lightBlack40,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 34,
                  width: 100,
                  child: PrimaryButton(
                    backgroundColor: AppColors.red,
                    onTap: () {
                      Get.back();
                    },
                    widget: Text(
                      TextConstants.cancel,
                      style:
                          AppTextStyle.bold12.copyWith(color: AppColors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 40),
                SizedBox(
                  height: 34,
                  width: 100,
                  child: PrimaryButton(
                    backgroundColor: AppColors.lightGreen,
                    onTap: onYesPressed,
                    widget: Text(
                      TextConstants.logout,
                      style:
                          AppTextStyle.bold12.copyWith(color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
