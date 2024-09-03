import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:science_platform/src/core/widgets/shimmer_listview_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/feature/courses/root/controller/course_details_view_controller.dart';
import 'package:science_platform/src/feature/home/root/controllers/home_view_controller.dart';
import 'package:science_platform/src/feature/home/root/models/advertisement_model.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/helper_methods.dart';

class HomeAdvertisements extends GetView<HomeViewController> {
  const HomeAdvertisements({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.pageState == PageState.loading) {
          return const ShimmerListViewBuilder(
            itemCount: 1,
            itemHeight: 210,
          );
        } else {
          return controller.pageState == PageState.error
              ? const Offstage()
              : _AdvertisementCarousal(
                  advertisement: controller.advertisements,
                );
        }
      },
    );
  }
}

class _AdvertisementCarousal extends StatefulWidget {
  const _AdvertisementCarousal({
    required this.advertisement,
  });
  final List<AdvertisementModel?> advertisement;

  @override
  State<_AdvertisementCarousal> createState() => _AdvertisementCarousalState();
}

class _AdvertisementCarousalState extends State<_AdvertisementCarousal> {
  final _pageController = PageController(
    viewportFraction: 1,
    initialPage: 1,
  );
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(1);

  @override
  void initState() {
    super.initState();
    // Start the auto sliding animation
    startAutoSlide();
  }

  @override
  void dispose() {
    // Dispose the page controller and cancel the timer
    _pageController.dispose();
    _currentPage.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Timer? _timer;

  void startAutoSlide() {
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        if (_currentPage.value == widget.advertisement.length - 1) {
          _currentPage.value = 0;
        } else {
          _currentPage.value++;
        }
        _pageController.animateToPage(
          _currentPage.value,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 230.0,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.advertisement.length,
              onPageChanged: (page) {
                _currentPage.value = page;
              },
              itemBuilder: (context, pagePosition) {
                return InkWell(
                  onTap: () {
                    _onTap(widget.advertisement[pagePosition]!);
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                    child: CachedNetworkImage(
                      imageUrl:
                          widget.advertisement[pagePosition]?.image?.link ?? '',
                      width: double.infinity,
                      fit: BoxFit.fill,
                      memCacheHeight: 450,
                      memCacheWidth: 900,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.advertisement.length,
              (index) => ValueListenableBuilder<int>(
                valueListenable: _currentPage,
                builder: (BuildContext context, int value, child) {
                  return Container(
                    margin: const EdgeInsets.all(1.0),
                    width: 10.0,
                    child: Icon(
                      Icons.circle_rounded,
                      size: 10,
                      color: _currentPage.value == index
                          ? AppColors.primary
                          : Colors.grey.shade400,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onTap(AdvertisementModel item) {
    if (item.link?.isNotEmpty ?? false) {
      if (item.type == 'course') {
        Get.find<CourseDetailsViewController>().fetchCourseDetails(item.link!);
        Get.toNamed(Routes.courseDetails);
      } else if (item.type == 'external-link') {
        urlLauncher(item.link!);
      }
    }
  }
}
