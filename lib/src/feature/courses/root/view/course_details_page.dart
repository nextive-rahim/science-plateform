// ignore_for_file: unused_element

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/courses/content/model/content_model.dart';
import 'package:science_platform/src/feature/courses/purchase/course_purchase/controller/course_purchase_controller.dart';
import 'package:science_platform/src/feature/courses/root/controller/course_details_view_controller.dart';
import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/feature/courses/sections/controller/course_sections_view_controller.dart';
import 'package:science_platform/src/feature/courses/sections/model/section_model.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/app_constants.dart';
import 'package:science_platform/src/utils/assets.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/course_details_content_card.dart';
import 'package:science_platform/src/widgets/error_feedback.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';
import 'package:science_platform/src/widgets/outlined_input_field.dart';
import 'package:science_platform/src/widgets/primary_button.dart';
import 'package:science_platform/src/widgets/rounded_button.dart';

part '../widgets/contents.dart';
part '../widgets/course_payment_button.dart';
part '../widgets/section_container.dart';
part '../widgets/section_title.dart';

class CourseDetailsPage extends GetView<CourseDetailsViewController> {
  CourseDetailsPage({super.key}) {
    controller.fetchCourseDetails(Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.isLoading
                ? TextConstants.courseDetails
                : controller.courseDetails!.title ?? '',
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          RefreshIndicator(
            onRefresh: () async {
              Get.find<CourseDetailsViewController>()
                  .fetchCourseDetails(controller.courseDetails!.slug!);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 15,
                bottom: 220,
              ),
              child: Obx(
                () {
                  if (controller.pageState == PageState.loading) {
                    return LoadingIndicator.list();
                  }
                  if (controller.pageState == PageState.error) {
                    return Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: const GenericErrorFeedback(),
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        _buildHeader(),
                        _buildCourseTitle(),
                        // _buildCourseInstructors(),
                        _buildCourseDescription(),
                        _buildCourseContents(),
                        _buildCourseFeatures(),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
          _buildPaymentButton(),
        ],
      ),
    );
  }

  Widget _buildCourseFeatures() {
    return (controller.courseDetails?.courseDetails?.features?.isEmpty ?? true)
        ? const Offstage()
        : _SectionContainer(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
                  controller.courseDetails?.courseDetails?.features?.length ??
                      0,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 2);
              },
              itemBuilder: (BuildContext context, int index) {
                String feature =
                    controller.courseDetails?.courseDetails?.features?[index] ??
                        '';
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 6,
                  ),
                  minVerticalPadding: 0,
                  dense: true,
                  leading: const Icon(
                    Icons.checklist_outlined,
                    color: AppColors.amber,
                  ),
                  minLeadingWidth: 0,
                  title: Text(
                    feature,
                    style: AppTextStyle.semiBold16.copyWith(
                      height: 0,
                    ),
                  ),
                );
              },
            ),
          );
  }

  Widget _buildCourseTitle() {
    return _SectionContainer(
      child: Text(
        controller.courseDetails!.title ?? '',
        style: AppTextStyle.semibold18.copyWith(
          fontSize: 20,
          height: 30 / 20,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    CourseModel course = controller.courseDetails!;
    String photo = course.image?.link ?? noImageFoundURL;
    //TODO: implement video
    return _SectionContainer(
      horizontalPadding: 0,
      verticalPadding: 0,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.network(
          photo,
          fit: BoxFit.contain,
          width: double.infinity,
        ),
      ),
    );
  }

  // Widget _buildCourseInstructors() {
  //   CourseModel course = controller.courseDetails!;
  //   return Column(
  //     children: [
  //       const SizedBox(height: 15),
  //       course.authors!.isNotEmpty
  //           ? const PillTitle(title: TextConstants.instructor)
  //           : const Offstage(),
  //       const SizedBox(height: 15),
  //       ListView.builder(
  //         padding: EdgeInsets.zero,
  //         itemBuilder: (context, index) {
  //           Author authors = course.authors![index];
  //           String imageUrl =
  //               authors.photo != null ? authors.photo! : noImageFoundURL;
  //           String name = authors.name ?? "";
  //           String designation = authors.description ?? "";

  //           return Column(
  //             children: [
  //               Container(
  //                 decoration: BoxDecoration(
  //                   color: AppColors.white,
  //                   borderRadius: BorderRadius.circular(10),
  //                 ),
  //                 padding: const EdgeInsets.all(10),
  //                 child: Row(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Container(
  //                       decoration: BoxDecoration(
  //                         border:
  //                             Border.all(width: 3, color: AppColors.primary5),
  //                         borderRadius: BorderRadius.circular(50),
  //                       ),
  //                       child: SizedBox(
  //                         height: 58,
  //                         width: 58,
  //                         child: ClipRRect(
  //                           borderRadius: BorderRadius.circular(50),
  //                           child: Image.network(
  //                             imageUrl,
  //                             fit: BoxFit.fill,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(width: 17),
  //                     Expanded(
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             name,
  //                             style: const TextStyle(
  //                               fontFamily: 'Poppins',
  //                               fontWeight: FontWeight.bold,
  //                               fontSize: 16,
  //                             ),
  //                             overflow: TextOverflow.ellipsis,
  //                           ),
  //                           const SizedBox(height: 5),
  //                           HtmlWidget(
  //                             designation,
  //                             textStyle: const TextStyle(
  //                               fontFamily: 'Poppins',
  //                               fontWeight: FontWeight.w400,
  //                               fontSize: 12,
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               const SizedBox(height: 5),
  //             ],
  //           );
  //         },
  //         itemCount: course.authors?.length,
  //         primary: false,
  //         shrinkWrap: true,
  //       ),
  //     ],
  //   );
  // }

  Widget _buildCourseDescription() {
    CourseModel course = controller.courseDetails!;
    String description = course.courseDetails?.description ?? "";
    if (description == 'null' || description == "<p></p>") {
      return const SizedBox();
    }
    return _SectionContainer(
      child: _SectionContainer(
        verticalPadding: 5,
        horizontalPadding: 10,
        color: AppColors.lightBlack5,
        bottomMargin: 0,
        child: Column(
          children: [
            const _SectionTitle(title: TextConstants.aboutCourse),
            const SizedBox(height: 10),
            HtmlWidget(
              description,
              textStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpline() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          const _SectionTitle(title: TextConstants.helpline),
          const SizedBox(height: 10),
          _SectionContainer(
            horizontalPadding: 20,
            verticalPadding: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: '${TextConstants.toKnowMore} ',
                      style: AppTextStyle.medium12.copyWith(
                        color: AppColors.lightBlack80,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'এই ভিডিও',
                          recognizer: TapGestureRecognizer()..onTap = () {},
                          style: const TextStyle(
                            color: AppColors.lightGreen,
                          ),
                        ),
                        const TextSpan(text: ' দেখুন!'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseContents() {
    return (controller.courseDetails!.sections != null &&
            controller.courseDetails!.sections!.isNotEmpty)
        ? _SectionContainer(
            bottomMargin: 15,
            color: AppColors.lightBlack5,
            child: ExpansionTileTheme(
              data: const ExpansionTileThemeData(
                iconColor: Colors.white,
              ),
              child: ExpansionPanelList.radio(
                expandedHeaderPadding: const EdgeInsets.all(0),
                elevation: 0,
                dividerColor: AppColors.grey.withOpacity(0.20),
                children: controller.courseDetails!.sections!
                    .map((e) => _buildSingleSectionItem(e))
                    .toList(),
              ),
            ),
          )
        : const Offstage();
  }

  ExpansionPanelRadio _buildSingleSectionItem(SectionModel e) {
    return ExpansionPanelRadio(
      canTapOnHeader: true,
      backgroundColor: AppColors.transparent,
      value: e.id!,
      headerBuilder: (context, isExpanded) {
        if (isExpanded == true) {
          controller.getSectionContents(e.slug!);
        }
        return Container(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  e.title ?? 'N/A',
                  style: AppTextStyle.bold16.copyWith(
                    color: AppColors.lightBlack90,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
      body: _SectionContainer(
        bottomMargin: 0,
        verticalPadding: 6,
        horizontalPadding: 6,
        radius: 8,
        color: AppColors.white,
        child: Obx(
          () {
            if (controller.contentsLoading.value == true) {
              return LoadingIndicator.card();
            }
            if (controller.sectionHasData) {
              return ListView.separated(
                itemCount: controller.sectionContents.length,
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                primary: false,
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 6);
                },
                itemBuilder: (BuildContext context, int index) {
                  ContentModel contentModel = controller.sectionContents[index];
                  return _SectionContainer(
                    color: AppColors.white,
                    bottomMargin: 0,
                    verticalPadding: 0,
                    horizontalPadding: 8,
                    radius: 6,
                    child: CourseDetailsContentCard(
                      content: contentModel,
                      isDisabled: false,
                    ),
                  );
                },
              );
            } else {
              return Container(
                padding: const EdgeInsets.all(30),
                color: AppColors.white,
                width: double.infinity,
                child: Image.asset(
                  Assets.logo,
                  height: 60,
                  width: 60,
                  fit: BoxFit.fitHeight,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildPaymentButton() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          border: Border.fromBorderSide(
            BorderSide(
              color: AppColors.lightBlack10,
              width: 1,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(
          bottom: 20,
          top: 15,
        ),
        child: Obx(() {
          if (controller.pageState == PageState.success) {
            return controller.courseDetails?.isSubscribed == false
                ? _CoursePaymentButton(controller: controller)
                : PrimaryButton(
                    onTap: () {
                      Get.find<CourseSectionsViewController>()
                          .getCourseSectionsAndContents(
                              controller.courseDetails!.slug!);
                      Get.toNamed(
                        Routes.courseSections,
                        arguments: controller.courseDetails?.title,
                      );
                    },
                    widget: Text(
                      'Start Course',
                      style:
                          AppTextStyle.bold16.copyWith(color: AppColors.white),
                    ),
                  );
          }
          return const Offstage();
        }),
      ),
    );
  }
}
