import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/classroom/root/view/classroom_page.dart';
import 'package:science_platform/src/feature/courses/root/view/courses_tab_page.dart';
import 'package:science_platform/src/feature/dashboard/controller/dashboard_view_controller.dart';
import 'package:science_platform/src/feature/home/root/view/home_page.dart';
import 'package:science_platform/src/feature/settings/controller/settings_controller.dart';
import 'package:science_platform/src/utils/assets.dart';
import 'package:science_platform/src/utils/helper_methods.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/common_dialog.dart';

class DashboardPage extends GetView<DashboardViewController> {
  DashboardPage({super.key});

  final List<Widget> _children = <Widget>[
    const HomePage(),
    const CourseTabPage(),
    ClassroomPage(),
  ];

  static const double _borderRadius = 20;
  final settingsController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: IndexedStack(
            index: controller.currentIndex,
            children: _children,
          ),
          bottomNavigationBar: Obx(() {
            return Visibility(
              visible: controller.navBarVisibility,
              child: Container(
                height: Platform.isAndroid ? 80 : null,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(_borderRadius),
                    topLeft: Radius.circular(_borderRadius),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.navBarShadow,
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(_borderRadius),
                    topRight: Radius.circular(_borderRadius),
                  ),
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: _buildIcon(Assets.home, 0),
                        label: TextConstants.dashboardTab1,
                      ),
                      BottomNavigationBarItem(
                        icon: _buildIcon(Assets.courses, 1),
                        label: TextConstants.dashboardTab2,
                      ),
                      BottomNavigationBarItem(
                        icon: _buildIcon(Assets.classroom, 2),
                        label: TextConstants.dashboardTab5,
                      ),
                    ],
                    currentIndex: controller.currentIndex,
                    selectedItemColor: AppColors.selectedNavItem,
                    selectedFontSize: 12,
                    unselectedFontSize: 12,
                    onTap: (val) {
                      controller.updateIndex(val);

                      // if (controller.currentIndex == 4 &&
                      //     settingsController.hasNewUpdate == true &&
                      //     settingsController.showUpdateDialog == true) {
                      //   _newUpdateDialog(
                      //     context,
                      //     isForceUpdate: settingsController.isForceUpdate!,
                      //     appLink: playStoreLink,
                      //   );
                      // }
                    },
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (controller.currentIndex == 0) {
      return true;
    } else {
      controller.updateIndex(0);
      return false;
    }
  }

  Image _buildIcon(String asset, int index) {
    return Image.asset(
      asset,
      color: controller.currentIndex == index
          ? AppColors.selectedNavItem
          : AppColors.lightBlack80,
      height: 25,
      width: 25,
    );
  }
}

void _newUpdateDialog(
  BuildContext context, {
  required bool isForceUpdate,
  required String? appLink,
}) {
  return WidgetsBinding.instance.addPostFrameCallback((_) {
    commonDialog(
      context: context,
      isDismissible: false,
      bodyContent: Container(
        width: double.infinity,
        constraints: const BoxConstraints(
          maxWidth: 400,
        ),
        child: Column(
          children: [
            Text(
              'New Update Available!',
              style: AppTextStyle.bold16.copyWith(
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              Assets.newUpdate,
              fit: BoxFit.contain,
              height: 220,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Please update to the latest version',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.regular14.copyWith(
                      color: AppColors.lightBlack80,
                    ),
                  ),
                ),
              ],
            ),
            isForceUpdate
                ? Text(
                    'to continue using the app!',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.regular14.copyWith(
                      color: AppColors.lightBlack80,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
      noButtonText: isForceUpdate ? 'পরে করুন' : null,
      onYesPressed: () {
        urlLauncher(appLink ?? '');
      },
      onNoPressed: () {
        if (isForceUpdate) {
          SystemNavigator.pop();
        } else {
          Get.find<SettingsController>().showUpdateDialog = false;
          Get.back();
        }
      },
    );
  });
}
