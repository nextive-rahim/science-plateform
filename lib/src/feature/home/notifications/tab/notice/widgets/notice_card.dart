import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/home/notifications/tab/notice/controller/notice_details_view_controller.dart';
import 'package:science_platform/src/feature/home/notifications/tab/notice/model/notice_list_model.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/extensions/generic_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoticeCard extends StatelessWidget {
  const NoticeCard({
    super.key,
    required this.notice,
  });

  final NoticeData notice;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.put(NoticeDetailsViewController()).fetchNoticeDetails(notice.slug!);
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => const NoticeDetailsPage()));

        Get.toNamed(
          Routes.noticeDetails,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10,
        ),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              notice.title ?? '',
              style: AppTextStyle.semibold14,
            ),
            const Text(''),
            DefaultTextStyle(
              style: AppTextStyle.regular12.copyWith(
                color: AppColors.primary,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (notice.createdAt.isNotNull) Text(notice.time ?? ''),
                  if (notice.createdAt.isNotNull) Text(notice.date ?? ''),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
