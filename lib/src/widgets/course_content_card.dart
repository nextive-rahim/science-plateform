import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/service/cache/cache_keys.dart';
import 'package:science_platform/src/core/service/cache/cache_service.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/courses/content/controller/contents_view_controller.dart';
import 'package:science_platform/src/feature/courses/content/model/content_model.dart';
import 'package:science_platform/src/feature/courses/content/model/contents/live_model.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/assets.dart';
import 'package:science_platform/src/utils/enums.dart';
import 'package:science_platform/src/utils/extensions/generic_extension.dart';
import 'package:science_platform/src/utils/helper_methods.dart';
import 'package:science_platform/src/widgets/common_dialog.dart';

// ignore: must_be_immutable
class CourseContentCard extends StatelessWidget {
  CourseContentCard({
    super.key,
    required this.content,
    this.isDisabled = false,
    this.isEnrolled = false,
    this.bottomPadding,
    this.liveModel,
  });

  final ContentModel content;
  final bool isDisabled;
  final bool isEnrolled;
  final double? bottomPadding;
  LiveModel? liveModel;
  String leadingIcon = '';
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    _setup(context, contentType: content.type);
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Opacity(
        opacity: content.contentIsNotAvailable ? 0.5 : 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            margin: EdgeInsets.only(bottom: bottomPadding ?? 12),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.lightBlack20.withOpacity(0.7),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text(
                content.title ?? '',
                style: AppTextStyle.semibold14.copyWith(
                  height: 18 / 14,
                  color: AppColors.lightBlack90,
                ),
              ),
              subtitle: content.type == CourseContentType.live.name
                  ? ((liveModel == null || liveModel!.liveContentStatus.isEmpty)
                      ? null
                      : Text(liveModel!.liveContentStatus))
                  : (content.contentStatus.isEmpty
                      ? null
                      : Text(content.contentStatus)),
              trailing: Obx(() {
                final controller = Get.find<ContentsViewController>();
                if (controller.singleContentIsLoading &&
                    (controller.contentSlugToFetch == content.slug)) {
                  return const CupertinoActivityIndicator(
                    radius: 8,
                    color: AppColors.primary,
                  );
                }
                return const Offstage();
              }),
              leading: Container(
                decoration: BoxDecoration(
                  color: AppColors.tabBackgroundColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                height: 36,
                width: 36,
                child: Center(
                  child: Image.asset(
                    leadingIcon,
                    height: 18,
                    width: 18,
                    color: AppColors.primary,
                  ),
                ),
              ),
              visualDensity: VisualDensity.compact,
              minVerticalPadding: 0,
              dense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              tileColor: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }

  /// Updates leading icon and onTap method based on content type
  void _setup(BuildContext context, {dynamic contentType}) {
    final contentsViewController = Get.find<ContentsViewController>();
    String token = CacheService.boxAuth.read(CacheKeys.token);

    if (content.paid == true && !isEnrolled) {
      onTap = () {
        Get.snackbar(
          'Content is locked!',
          'Purchase the course to see the content!',
          snackPosition: SnackPosition.BOTTOM,
        );
      };
      return;
    }
    if (contentType == CourseContentType.pdf.name) {
      leadingIcon = Assets.pdf;
      if (!onTap.isNotNull) {
        onTap = () {
          if (content.contentIsNotAvailable) {
            Get.snackbar(
              'Not Available!',
              'Will be available At: ${content.contentStatus}',
              snackPosition: SnackPosition.TOP,
            );
            return;
          }
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
          if (content.contentIsNotAvailable) {
            Get.snackbar(
              'Coming Soon!',
              'Will be available At: ${content.contentStatus}',
              snackPosition: SnackPosition.TOP,
            );
            return;
          }

          if (clearance) {
            await contentsViewController.getContent(content.slug!);
            ContentModel contentModel = contentsViewController.contentModel!;
            if (contentModel.video != null) {
              if (contentModel.video?.source == VideoSourceType.youtube.name ||
                  contentModel.video?.source == VideoSourceType.vimeo.name ||
                  contentModel.video?.source == VideoSourceType.embedded.name) {
                if (contentModel.video!.link != null ||
                    contentModel.video?.embedded != null) {
                  Get.toNamed(
                    Routes.courseVideo,
                    arguments: contentModel.video,
                  );
                } else {
                  Get.snackbar(
                    'Warning',
                    'Video link not found.',
                    snackPosition: SnackPosition.TOP,
                  );
                  return;
                }
              }
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
                Get.toNamed(Routes.examInfo, arguments: [
                  videoExamId?.toInt(),
                  videoExamName,
                ]);
              },
            );
          }
        };
      }
    }
    if (contentType == CourseContentType.note.name) {
      leadingIcon = Assets.note;
      if (!onTap.isNotNull) {
        onTap = () {
          if (content.contentIsNotAvailable) {
            Get.snackbar(
              'Coming Soon!',
              'Will be available At: ${content.contentStatus}',
              snackPosition: SnackPosition.TOP,
            );
            return;
          }
          contentsViewController.getContent(content.slug!);
          Get.toNamed(Routes.noteDetails);
        };
      }
    }

    if (contentType == CourseContentType.live.name) {
      leadingIcon = Assets.video;
      if (!onTap.isNotNull) {
        onTap = () async {
          if (liveModel != null && liveModel!.liveContentIsNotAvailable) {
            Get.snackbar(
              'Coming Soon!',
              'Class will be starting at: ${liveModel?.liveContentStatus}',
              snackPosition: SnackPosition.TOP,
            );
            return;
          }
          await contentsViewController.getContent(content.slug!);
          urlLauncher(contentsViewController.contentModel?.live?.link ?? '');
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
          // Get.toNamed(Routes.assignment, arguments: [content.id]);
          Get.snackbar(
            'Coming Soon!',
            'Not available in app. Check website for Assignment.',
            snackPosition: SnackPosition.BOTTOM,
          );
        };
      }
    }
    if (contentType == CourseContentType.testmoj.name) {
      leadingIcon = Assets.exam;
      if (!onTap.isNotNull) {
        onTap = () {
          Get.snackbar(
            'Coming Soon!',
            'Not available in app. Check website for testmoj.',
            snackPosition: SnackPosition.BOTTOM,
          );
        };
      }
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
          'Not available in app. Check website for written-exam.',
          snackPosition: SnackPosition.BOTTOM,
        );
      };
    }
  }
}
