import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/home/notifications/tab/notice/controller/notice_view_controller.dart';
import 'package:science_platform/src/feature/home/notifications/tab/notice/model/notice_list_model.dart';
import 'package:science_platform/src/feature/home/notifications/tab/notice/widgets/notice_card.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/error_feedback.dart';
import 'package:science_platform/src/widgets/has_no_data_feedback.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoticePage extends GetView<NoticeViewController> {
  const NoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextConstants.notice),
      ),
      body: RefreshIndicator(
        onRefresh: controller.fetchNotices,
        child: Obx(
          () {
            if (controller.pageState == PageState.loading) {
              return LoadingIndicator.list();
            }
            if (controller.pageState == PageState.error) {
              return const GenericErrorFeedback();
            } else {
              return controller.notices.isNotEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.only(top: 20),
                      itemCount: controller.notices.length,
                      itemBuilder: (context, index) {
                        NoticeData notice = controller.notices[index];
                        return NoticeCard(
                          notice: notice,
                        );
                      },
                    )
                  : const HasNoDataFeedback();
            }
          },
        ),
      ),
    );
  }
}
