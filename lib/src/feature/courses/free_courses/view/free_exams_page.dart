import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/courses/free_courses/controller/free_courses_view_controller.dart';
import 'package:science_platform/src/feature/home/model_test/models/model_test_model.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/app_constants.dart';
import 'package:science_platform/src/utils/extensions/generic_extension.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/error_feedback.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';
import 'package:science_platform/src/widgets/pill_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FreeExamsPage extends GetView<FreeCoursesViewController> {
  const FreeExamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          TextConstants.freeExam,
          style: AppTextStyle.semibold18,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getFreeExams();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              Obx(
                () {
                  if (controller.pageState == PageState.loading) {
                    return LoadingIndicator.list();
                  }
                  if (controller.pageState == PageState.error) {
                    return const GenericErrorFeedback();
                  }
                  return _FreeExamCategoriesBuilder(
                    freeExamCategories: controller.freeExamCategories,
                  );
                },
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}

class _FreeExamCategoriesBuilder extends StatelessWidget {
  const _FreeExamCategoriesBuilder({
    required this.freeExamCategories,
  });

  final List<ModelTestModel>? freeExamCategories;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: freeExamCategories!.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final categories = freeExamCategories![index];

          return categories.isNotNull
              ? Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: PillTitle(title: categories.title ?? ''),
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     //   Get.toNamed(Routes.bookStore,
                        //     //       arguments: [categories.products]);
                        //   },
                        //   child: Row(
                        //     children: const [
                        //       Text(TextConstants.seeMore),
                        //       SizedBox(width: 10),
                        //       // Image.asset(Assets.forwardArrowCircular)
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    _FreeExamListBuilder(card: categories.contents!),
                    const SizedBox(height: 31),
                  ],
                )
              : const Offstage();
        });
  }
}

class _FreeExamListBuilder extends StatelessWidget {
  const _FreeExamListBuilder({
    required this.card,
  });

  // final controller = Get.find<FreeCoursesViewController>();
  final List<ModelTestContentModel> card;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: card.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return FreeExamCard(
          examContent: card[index],
          onTap: () {
            // Get.find<ExamInfoViewController>().getExamInformation(
            //   card[index].id!,
            // );
            Get.toNamed(
              Routes.examInfo,
              arguments: [
                card[index].exam!.id,
                card[index].title,
              ],
            );
          },
        );
      },
    );
  }
}

class FreeExamCard extends StatelessWidget {
  const FreeExamCard({
    super.key,
    required this.examContent,
    required this.onTap,
  });

  final ModelTestContentModel? examContent;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap!();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                child: Image.network(
                  examContent?.photo ?? noImageFoundURL,
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              examContent?.title ?? '',
              textAlign: TextAlign.center,
              maxLines: 2,
              textScaleFactor: 1,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                height: 16 / 14,
                fontFamily: 'NotoSerifBengali',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 3),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Visibility(
            //       visible: books.hasDiscount,
            //       child: Text(
            //         books.bookInitialPrice,
            //         style: const TextStyle(
            //           fontSize: 12,
            //           fontWeight: FontWeight.w400,
            //           height: 15 / 12,
            //           fontFamily: 'NotoSerifBengali',
            //           decoration: TextDecoration.lineThrough,
            //         ),
            //       ),
            //     ),
            //     const SizedBox(width: 10),
            //     Text(
            //       '৳ ${books.bookPrice}',
            //       style: AppTextStyle.bold14.copyWith(
            //         height: 18 / 14,
            //         color: AppColors.primary,
            //       ),
            //     )
            //   ],
            // ),
            const SizedBox(height: 3),
          ],
        ),
      ),
    );
  }
}

// class FreeExamsPage extends GetView<FreeCoursesViewController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         leadingWidth: 65,
//         leading: InkWell(
//           onTap: () => Get.back(),
//           child: const Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//         ),
//         title: Text(
//           TextConstants.freeExam,
//           textScaleFactor: 1,
//           style: AppTextStyle.semiBold16.copyWith(
//             color: AppColors.black,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//         itemCount: controller.freeExamCategories.length,
//         shrinkWrap: true,
//         itemBuilder: ((context, index) {
//           return Column(
//             children: [
//               Text(controller.freeExamCategories[index].title ?? ''),
//               // Card(child: Text(controller.modelTests[index].title ?? '')),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }

// // class FreeExamsPage extends StatefulWidget {
// //   const FreeExamsPage({
// //     Key? key,
// //     this.initialIndex = 0,
// //   }) : super(key: key);

// //   final int initialIndex;

// //   @override
// //   State<FreeExamsPage> createState() => _FreeExamsPageState();
// // }

// // class _FreeExamsPageState extends State<FreeExamsPage> {
// //   int _currentIndex = 0;

// //   @override
// //   Widget build(BuildContext context) {
// //     return DefaultTabController(
// //       length: 2,
// //       initialIndex: widget.initialIndex,
// //       child: Scaffold(
// //         appBar: AppBar(
// //           elevation: 0,
// //           backgroundColor: AppColors.white,
// //           leadingWidth: 65,
// //           leading: InkWell(
// //             onTap: () => Get.back(),
// //             child: const Icon(
// //               Icons.arrow_back,
// //               color: Colors.black,
// //             ),
// //           ),
// //           title: Text(
// //             TextConstants.freeExam,
// //             textScaleFactor: 1,
// //             style: AppTextStyle.semiBold16.copyWith(
// //               color: AppColors.black,
// //             ),
// //           ),
// //           centerTitle: true,
// //           bottom: PreferredSize(
// //             preferredSize: const Size(double.infinity, 65),
// //             child: Container(
// //               margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
// //               decoration: BoxDecoration(
// //                   color: AppColors.lighterBlue,
// //                   borderRadius: BorderRadius.circular(15)),
// //               child: TabBar(
// //                 onTap: (index) {
// //                   setState(() {
// //                     _currentIndex = index;
// //                   });
// //                 },
// //                 indicator: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(15), // Creates border
// //                   color: AppColors.white,
// //                   border: Border.all(
// //                     width: 5,
// //                     color: AppColors.lighterBlue,
// //                   ),
// //                 ),
// //                 tabs: [
// //                   Tab(
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         Text(
// //                           TextConstants.runningExams,
// //                           textScaleFactor: 1,
// //                           style: AppTextStyle.regular16.copyWith(
// //                             color: AppColors.darkerGrey,
// //                           ),
// //                         ),
// //                         Container(
// //                           height: 5,
// //                           width: 50,
// //                           decoration: BoxDecoration(
// //                             color: AppColors.primary,
// //                             borderRadius: BorderRadius.circular(5),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   Tab(
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         Text(
// //                           TextConstants.previousExams,
// //                           textScaleFactor: 1,
// //                           style: AppTextStyle.regular16.copyWith(
// //                             color: AppColors.darkerGrey,
// //                           ),
// //                         ),
// //                         Container(
// //                           height: 5,
// //                           width: 50,
// //                           decoration: BoxDecoration(
// //                             color: AppColors.primary,
// //                             borderRadius: BorderRadius.circular(5),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //         body: const TabBarView(
// //           children: [
// //             RunningFreeExams(),
// //             PreviousFreeExams(),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
