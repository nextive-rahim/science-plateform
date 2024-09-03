import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/home/job_circular/controller/circular_view_controller.dart';
import 'package:science_platform/src/feature/home/job_circular/model/circular_list_model.dart';
import 'package:science_platform/src/utils/extensions/string_extension.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/error_feedback.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class CircularDetailsPage extends StatefulWidget {
  const CircularDetailsPage({super.key});

  @override
  State<CircularDetailsPage> createState() => _CircularDetailsPageState();
}

class _CircularDetailsPageState extends State<CircularDetailsPage> {
  final controller = Get.find<CircularViewController>();

  void openDialog(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              child: PhotoView(
                tightMode: true,
                imageProvider:
                    NetworkImage(controller.circularDetails!.image?.link ?? ''),
                heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),
              ),
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextConstants.jobCircular),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 100,
        ),
        child: Obx(
          () {
            if (controller.pageState == PageState.loading) {
              return LoadingIndicator.details();
            }
            if (controller.pageState == PageState.error) {
              return const GenericErrorFeedback();
            } else {
              JobCircularModel? jobCircular = controller.circularDetails;
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      openDialog(context);
                    },
                    child: ClipRRect(
                      child: SizedBox(
                        child: CachedNetworkImage(
                          imageUrl: jobCircular!.image?.link ?? '',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorWidget: (context, url, error) {
                            return Container(
                              color: AppColors.primaryLight,
                              child: const Icon(Icons.error),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Published on: ',
                        style: AppTextStyle.medium14.copyWith(
                          fontSize: 13,
                          height: 0,
                          color: AppColors.lightBlack90,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          getFormattedDateTime(jobCircular.publishDate) ?? '-',
                          style: AppTextStyle.semibold14.copyWith(
                            fontSize: 13,
                            height: 0,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (jobCircular.expireDate != null &&
                                DateTime.now().isAfter(jobCircular.expireDate!))
                            ? 'Expired on: '
                            : 'Expire on: ',
                        style: AppTextStyle.medium14.copyWith(
                          fontSize: 13,
                          height: 0,
                          color: AppColors.lightBlack90,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          getFormattedDateTime(jobCircular.expireDate) ?? '-',
                          style: AppTextStyle.semibold14.copyWith(
                            fontSize: 13,
                            height: 0,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      (jobCircular.expireDate != null &&
                              DateTime.now().isAfter(jobCircular.expireDate!))
                          ? Text(
                              ' (Expired)',
                              style: AppTextStyle.medium14.copyWith(
                                fontSize: 13,
                                height: 0,
                                color: AppColors.red,
                              ),
                            )
                          : const Offstage(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          jobCircular.title ?? '',
                          maxLines: 2,
                          style: AppTextStyle.bold20.copyWith(
                            height: 30 / 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  jobCircular.description == null
                      ? const Offstage()
                      : Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: AppColors.primary10,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: HtmlWidget(
                            jobCircular.description ?? '',
                            textStyle: const TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: Colors.black,
                            ),
                          ),
                        ),
                  const SizedBox(height: 25),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
