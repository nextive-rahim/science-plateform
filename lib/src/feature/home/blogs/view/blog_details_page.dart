import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/home/blogs/controller/blog_view_controller.dart';
import 'package:science_platform/src/feature/home/blogs/model/blog_model.dart';
import 'package:science_platform/src/utils/app_constants.dart';
import 'package:science_platform/src/utils/extensions/string_extension.dart';
import 'package:science_platform/src/widgets/error_feedback.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogDetailsPage extends GetView<BlogViewController> {
  BlogDetailsPage({super.key}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getBlogDetails(Get.arguments);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Obx(
            () => controller.blogDetailsState == PageState.loading
                ? LoadingIndicator.list()
                : Text(controller.blogDetailsData?.title ?? 'Details'),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.getBlogDetails(Get.arguments);
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 100,
            ),
            child: Obx(
              () {
                if (controller.blogDetailsState == PageState.loading) {
                  return LoadingIndicator.details();
                }
                if (controller.blogDetailsState == PageState.error) {
                  return const GenericErrorFeedback();
                }
                BlogModel details = controller.blogDetailsData!;
                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        height: 200,
                        child: Builder(
                          builder: (context) {
                            return CachedNetworkImage(
                              imageUrl: details.image?.link ?? noImageFoundURL,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorWidget: (context, url, error) {
                                return Container(
                                  color: AppColors.primaryLight,
                                  child: const Icon(Icons.error),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getFormattedTime(details.createdAt) ?? '',
                          style: AppTextStyle.medium12.copyWith(
                            height: 14 / 12,
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          getFormattedDate(details.createdAt) ?? '',
                          style: AppTextStyle.medium12.copyWith(
                            height: 14 / 12,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            details.title!,
                            maxLines: 2,
                            style: AppTextStyle.bold20.copyWith(
                              height: 30 / 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 35,
                              width: 35,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  details.authorImage ?? noImageFoundURL,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Writer',
                                    style: AppTextStyle.semibold12.copyWith(
                                      height: 18 / 12,
                                      color: AppColors.lightBlack60,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          details.authorName ?? '',
                                          maxLines: 1,
                                          style:
                                              AppTextStyle.semibold14.copyWith(
                                            height: 18 / 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    HtmlWidget(
                      details.body!,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 25),
                    // CommentSection(
                    //   mainCommentableId: details.id!,
                    //   mainCommentableType: CommentableType.post,
                    // ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
