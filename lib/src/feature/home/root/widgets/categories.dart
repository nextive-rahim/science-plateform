import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/courses/root/model/category_model.dart';
import 'package:science_platform/src/feature/home/root/controllers/home_view_controller.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/app_constants.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';

class Categories extends GetView<HomeViewController> {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.isLoading) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 30,
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.8,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemBuilder: (context, index) {
                return FittedBox(
                  fit: BoxFit.cover,
                  clipBehavior: Clip.antiAlias,
                  child: LoadingIndicator.card(),
                );
              },
            ),
          );
        }

        if (controller.pageState == PageState.error) {
          return const Offstage();
        }
        {
          List<CategoryModel?> courseCategories =
              controller.courseCategories ?? [];
          // _insertIfNotAlreadyPresent(courseCategories, eTestPaper);

          if (courseCategories.isEmpty) {
            return const Offstage();
          }

          return Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TextConstants.categories,
                  textAlign: TextAlign.left,
                  style: AppTextStyle.bold16.copyWith(
                    height: 25 / 16,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 15),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: courseCategories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemBuilder: (context, index) {
                    CategoryModel category = courseCategories[index]!;
                    return _OptionCard(
                      category: category,
                      index: index,
                    );
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

void _insertIfNotAlreadyPresent(
  List<CategoryModel?>? courseCategories,
  CategoryModel eTestPaper,
) {
  if (!courseCategories!.contains(eTestPaper)) {
    courseCategories.insert(0, eTestPaper);
  }
}

// final eTestPaper = CategoryModel(
//   id: 1000,
//   title: 'E Test Paper',
//   slug: 'https://www.etestpaper.net/?source=Lingual_Academy',
// );

class _OptionCard extends StatelessWidget {
  const _OptionCard({
    required this.category,
    required this.index,
  });

  final CategoryModel category;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.categoryDetails,
          arguments: category.slug,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              offset: const Offset(0, 4),
              spreadRadius: 4,
              color: AppColors.lightBlack10.withOpacity(0.5),
            ),
          ],
          color: AppColors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(11),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child:
                  //  isETestPaper
                  //     ? Image.asset(
                  //         Assets.eTestPaper,
                  //         height: 35,
                  //         fit: BoxFit.contain,
                  //         cacheHeight: 91,
                  //         cacheWidth: 175,
                  //       )
                  //     :
                  CachedNetworkImage(
                imageUrl: category.image?.link ?? noImageFoundURL,
                cacheKey: category.image?.link ?? noImageFoundURL,
                fit: BoxFit.cover,
                width: 40,
                height: 40,
                memCacheHeight: 105,
                memCacheWidth: 105,
              ),
            ),
            Text(
              category.title ?? '',
              maxLines: 3,
              style: AppTextStyle.bold14.copyWith(
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
