import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/service/cache/cache_keys.dart';
import 'package:science_platform/src/core/service/cache/cache_service.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/courses/content/controller/contents_view_controller.dart';
import 'package:science_platform/src/feature/courses/content/model/content_model.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/assets.dart';
import 'package:science_platform/src/utils/enums.dart';
import 'package:science_platform/src/utils/extensions/generic_extension.dart';
import 'package:science_platform/src/utils/helper_methods.dart';
import 'package:science_platform/src/widgets/common_dialog.dart';

// ignore: must_be_immutable
class CourseDetailsContentCard extends StatelessWidget {
  CourseDetailsContentCard({
    super.key,
    required this.content,
    this.isDisabled = false,
    this.isEnrolled = false,
  });

  final ContentModel content;
  final bool isDisabled;
  final bool isEnrolled;
  String leadingIcon = '';
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    _setup(context, contentType: content.type);
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: ListTile(
        title: Row(
          children: [
            Expanded(
              child: Text(
                content.title ?? '',
                style: AppTextStyle.medium14.copyWith(
                  height: 18 / 14,
                  color: AppColors.lightBlack80,
                ),
              ),
            ),
          ],
        ),
        minLeadingWidth: 20,
        leading: Image.asset(
          leadingIcon,
          height: 20,
          color: AppColors.primary,
        ),
        trailing: content.paid == true
            ? Image.asset(
                Assets.locked,
                height: 20,
                width: 20,
              )
            : Image.asset(
                Assets.unlocked,
                height: 20,
                width: 20,
                color: AppColors.primary,
              ),
        visualDensity: VisualDensity.compact,
        minVerticalPadding: 0,
        dense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 5,
        ),
        tileColor: AppColors.white,
      ),
    );
  }

  /// Updates leading icon and onTap method based on content type
  void _setup(BuildContext context, {dynamic contentType}) {
    String token = CacheService.boxAuth.read(CacheKeys.token);
    final contentsViewController = Get.find<ContentsViewController>();

    if (content.paid == true) {
      if (!isEnrolled) {
        onTap = () {
          Get.snackbar(
            'Content is locked!',
            'Purchase the course to see the content!',
            snackPosition: SnackPosition.BOTTOM,
          );
        };
      }
      //return;
    }
    if (contentType == CourseContentType.pdf.name) {
      leadingIcon = Assets.pdf;
      if (!onTap.isNotNull) {
        onTap = () {
          Get.find<ContentsViewController>().getContent(content.slug!);
          Get.toNamed(Routes.pdfDetails);
        };
      }
    }
    if (contentType == CourseContentType.video.name) {
      bool clearance = content.clearance?.allow ?? true;
      int? videoExamId;
      String? videoExamName;
      leadingIcon = Assets.video;
      if (!onTap.isNotNull) {
        onTap = () async {
          if (clearance) {
            await contentsViewController.getContent(content.slug!);
            ContentModel? contentDetails = contentsViewController.contentModel;
            if (contentDetails?.video?.link != null ||
                contentDetails?.video?.embedded != null) {
              Get.toNamed(
                Routes.courseVideo,
                arguments: contentDetails?.video,
              );
            } else {
              Get.snackbar(
                'Warning',
                'Video link not found.',
                snackPosition: SnackPosition.TOP,
              );
              return;
            }
          } else {
            videoExamId = content.clearance!.item?.examId;
            videoExamName = content.clearance!.item?.title ?? '';

            commonDialog(
              context: context,
              title: 'Video is locked!',
              description: 'To Watch This Video You must attend the exam!',
              noButtonText: 'Cancel',
              yesButtonText: 'Go to Exam',
              onYesPressed: () {
                Get.back();
                Get.find<ContentsViewController>().contentIdOfVideoExam =
                    content.id;
                Get.toNamed(
                  Routes.examInfo,
                  arguments: [
                    videoExamId?.toInt(),
                    videoExamName,
                  ],
                );
              },
            );
          }
        };
      }
    }
    if (contentType == CourseContentType.note.name) {
      leadingIcon = Assets.pdf;

      if (!onTap.isNotNull) {
        onTap = () {
          contentsViewController.getContent(content.slug!);

          Get.toNamed(
            Routes.noteDetails,
            arguments: contentsViewController.contentModel?.note,
          );
        };
      }
    }
    if (contentType == CourseContentType.live.name) {
      leadingIcon = Assets.video;
      if (!onTap.isNotNull) {
        onTap = () async {
          await contentsViewController.getContent(content.slug!);

          if (contentsViewController.contentModel?.live?.link != null) {
            urlLauncher(contentsViewController.contentModel?.live?.link ?? '');
          } else {
            Get.snackbar(
              'Warning',
              'Live video link not found.',
              snackPosition: SnackPosition.TOP,
            );
            return;
          }
        };
      }
    }
    if (contentType == CourseContentType.link.name) {
      leadingIcon = Assets.link;
      if (!onTap.isNotNull) {
        onTap = () async {
          if (content.contentIsNotAvailable) {
            Get.snackbar(
              'Coming Soon!',
              'Will be available At: ${content.contentStatus}',
              snackPosition: SnackPosition.TOP,
            );
            return;
          }
          await contentsViewController.getContent(content.slug!);
          await urlLauncher(
              contentsViewController.contentModel?.link?.link ?? '');
        };
      }
    }
    if (contentType == CourseContentType.assignment.name) {
      leadingIcon = Assets.assignment;
      if (!onTap.isNotNull) {
        onTap = () {
          Get.snackbar(
            'Coming Soon!',
            'Assignment is not available in the app. Please check the website.',
            snackPosition: SnackPosition.BOTTOM,
          );
        };
      }
    }
    if (contentType == CourseContentType.testmoj.name) {
      leadingIcon = Assets.exam;
      onTap = () {
        Get.snackbar(
          'Coming Soon!',
          'Not available in app. Check website for testmoj.',
          snackPosition: SnackPosition.BOTTOM,
        );
      };
    }
    if (contentType == CourseContentType.exam.name) {
      leadingIcon = Assets.exam;
      if (!onTap.isNotNull) {
        onTap = () async {
          await contentsViewController.getContent(content.slug!);

          Get.toNamed(
            Routes.examWebviewPage,
            arguments: [
              'https://exam-science-platform.vercel.app/exam/${contentsViewController.contentModel?.exam?.id}/$token',
              content.title,
            ],
          );
        };
      }
    }
    if (contentType == 'written-exam') {
      leadingIcon = Assets.exam;
      onTap = () {
        Get.snackbar(
          'Coming Soon!',
          'Not available in app. Check website for written exam.',
          snackPosition: SnackPosition.BOTTOM,
        );
      };
    }
  }
}
