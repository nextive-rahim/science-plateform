import 'package:flutter/material.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/widgets/primary_button.dart';

deleteDailog({
  required BuildContext context,
  required String message,
  required Function onTap,
  String? title,
  String? yesText,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? 'Do you want delete this account?',
              style: const TextStyle(
                color: Color(0xFF363636),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 15),
            const Divider(),
            Text(
              message,
              style: const TextStyle(
                color: Color(0xFF8A8A8A),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 25),
            PrimaryButton(
              onTap: onTap,
              widget: const Text(
                'Yes, Delete',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  // height: 1.56,
                ),
              ),
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              onTap: () {
                Navigator.of(context).pop();
              },
              widget: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  // height: 1.56,
                ),
              ),
              backgroundColor: AppColors.transparent,
            ),
          ],
        ),
      );
    },
  );
}
