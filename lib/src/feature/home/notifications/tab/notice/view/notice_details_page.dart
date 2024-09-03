import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/home/notifications/tab/notice/controller/notice_details_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/utils/app_constants.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';
import 'package:science_platform/src/widgets/pill_title.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticeDetailsPage extends GetView<NoticeDetailsViewController> {
  const NoticeDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: controller.pageState == PageState.loading
            ? const Text("Notice Details")
            : Text(controller.notice.title ?? ''),
      ),
      body: Obx(
        () {
          if (controller.pageState == PageState.loading) {
            return LoadingIndicator.card().paddingSymmetric(
              horizontal: 20,
              vertical: 20,
            );
          }
          if (controller.pageState == PageState.error) {
            return Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.only(top: 20),
                width: 250,
                height: 120,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      size: 50,
                    ),
                    Text(
                      'No detail is found',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: controller.notice.image?.link ?? noImageFoundURL,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    errorWidget: (context, url, error) {
                      return const Icon(Icons.error);
                    },
                  ),
                ),
                if (controller.notice.createdAt != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          controller.notice.time!,
                          style: AppTextStyle.medium12.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          controller.notice.date!,
                          style: AppTextStyle.medium12.copyWith(
                            color: AppColors.primary,
                          ),
                        )
                      ],
                    ),
                  ),
                const SizedBox(height: 15),
                PillTitle(title: controller.notice.title!),
                const SizedBox(height: 15),
                HtmlWidget(
                  controller.notice.body!,
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
