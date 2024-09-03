import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      // backgroundColor: AppColors.grey,
      toolbarHeight: 60,
      leadingWidth: 65,
      leading: InkWell(
        onTap: () => Get.back(),
        child: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
      title: Text(
        title,
        style: AppTextStyle.medium18.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.lightBlack90,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
