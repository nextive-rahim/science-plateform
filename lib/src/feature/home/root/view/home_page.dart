import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/feature/dashboard/controller/dashboard_view_controller.dart';
import 'package:science_platform/src/feature/home/root/controllers/home_view_controller.dart';
import 'package:science_platform/src/feature/home/root/widgets/categories.dart';
import 'package:science_platform/src/feature/home/root/widgets/featured_courses.dart';
import 'package:science_platform/src/feature/home/root/widgets/home_advertisements.dart';
import 'package:science_platform/src/feature/home/root/widgets/home_drawer.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/assets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.find<HomeViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: _buildAppBar(),
      drawer: const HomeDrawer(),
      onDrawerChanged: (value) {
        if (!value) {
          Get.find<DashboardViewController>().updateNavBarVisibility(true);
        }
      },
      body: RefreshIndicator(
        onRefresh: controller.getHomeContents,
        child: const SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(bottom: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeAdvertisements(),
              Categories(),
              HomeFeaturedCourse(),
              // HomeModelTest()
            ],
          ),
        ),
      ),
    );
  }

  AppBar? _buildAppBar() {
    return AppBar(
      leadingWidth: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      shadowColor: AppColors.lightBlack10.withOpacity(0.4),
      toolbarHeight: 65,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Get.find<DashboardViewController>().updateNavBarVisibility(false);
              scaffoldKey.currentState!.openDrawer();
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.primary5.withOpacity(0.4),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.lightBlack10,
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.menu_rounded,
                color: AppColors.primary,
                size: 22,
              ),
            ),
          ),
          Container(
            height: 40,
            margin: const EdgeInsets.only(
              left: 5,
              right: 5,
            ),
            child: Image.asset(
              Assets.logo,
              fit: BoxFit.contain,
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(Routes.notice),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.primary5.withOpacity(0.4),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.lightBlack10,
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                Assets.notification,
                fit: BoxFit.cover,
                color: const Color.fromRGBO(0, 120, 69, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
