import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/dashboard/controller/dashboard_view_controller.dart';
import 'package:science_platform/src/feature/home/root/widgets/logout_dialog.dart';
import 'package:science_platform/src/feature/profile/controller/profile_view_controller.dart';
import 'package:science_platform/src/feature/profile/widgets/profile_card.dart';
import 'package:science_platform/src/feature/profile/widgets/profile_item_button.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/assets.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';

class ProfileDashboardPage extends GetView<ProfileViewController> {
  const ProfileDashboardPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // String token = CacheService.boxAuth.read(CacheKeys.token);
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4FA),
      appBar: AppBar(
        title: const Text('Student Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Obx(
            () {
              if (controller.pageState == PageState.loading) {
                return LoadingIndicator.list();
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ProfileCard(
                        onTap: () {},
                        user: controller.userModel,
                      ),
                      // ProfileItemButton(
                      //   icon: Assets.check,
                      //   title: 'Question Bank',
                      //   subtitle: 'Student Practice Exam.',
                      //   onTap: () {
                      //     Get.toNamed(
                      //       Routes.examWebviewPage,
                      //       arguments: [
                      //         'https://exam-masterclass-app.vercel.app/question-bank/$token',
                      //         'Question Bank',
                      //       ],
                      //     );
                      //   },
                      // ),
                      // ProfileItemButton(
                      //   icon: Assets.check,
                      //   title: 'Job Circular',
                      //   subtitle: 'Regular govt. and private job updates.',
                      //   onTap: () async {
                      //     Get.put(CircularViewController()).getCircularList();
                      //     Get.toNamed(Routes.circulars);
                      //   },
                      // ),
                      // ProfileItemButton(
                      //   icon: Assets.check,
                      //   title: 'Suggest a friend',
                      //   subtitle: 'Suggest your friend to keep up to date.',
                      //   onTap: () => Get.snackbar(
                      //     'Info',
                      //     'Coming Soon!',
                      //   ),
                      // ),
                      ProfileItemButton(
                        icon: Assets.check,
                        title: 'Help Center',
                        subtitle: 'Support & Feedback',
                        onTap: () {
                          Get.toNamed(Routes.support);
                        },
                      ),
                      ProfileItemButton(
                        icon: Assets.locked,
                        title: 'Log out',
                        subtitle: 'End of access',
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return LogoutDialog(
                                onYesPressed: () {
                                  Get.find<DashboardViewController>().logout();
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
