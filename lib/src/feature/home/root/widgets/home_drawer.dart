import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/feature/classroom/root/controller/classroom_view_controller.dart';
import 'package:science_platform/src/feature/dashboard/controller/dashboard_view_controller.dart';
import 'package:science_platform/src/feature/home/root/widgets/delete_dailog.dart';
import 'package:science_platform/src/feature/home/root/widgets/logout_dialog.dart';
import 'package:science_platform/src/feature/profile/controller/profile_view_controller.dart';
import 'package:science_platform/src/feature/profile/model/user_model.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/app_constants.dart';
import 'package:science_platform/src/utils/assets.dart';
import 'package:science_platform/src/utils/extensions/generic_extension.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:url_launcher/url_launcher.dart';

//TODO: DRY and REFACTOR LATER
class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  final profileController = Get.find<ProfileViewController>();
  final ValueNotifier<PackageInfo> _packageInfo = ValueNotifier<PackageInfo>(
    PackageInfo(
      appName: 'Unknown',
      packageName: 'Unknown',
      version: 'Unknown',
      buildNumber: 'Unknown',
    ),
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();

    _packageInfo.value = info;
  }

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    // bool? isAffiliated = Get.find<AffiliationViewController>()
    //     .affiliationStatusModel
    //     ?.isAffiliate;

    return Drawer(
      shape: const RoundedRectangleBorder(),
      child: ListView(
        children: [
          SizedBox(
            height: 670,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  _buildUserSection(),
                  const SizedBox(height: 50),
                  _DrawerOptions(
                    onTap: () => Get.toNamed(Routes.updateProfilePage),
                    asset: Assets.myProfile,
                    title: TextConstants.myProfile,
                  ),
                  _buildDivider(),
                  _DrawerOptions(
                    onTap: () {
                      Get.find<ClassroomViewController>().fetchMyCourses();
                      Get.toNamed(Routes.myCourse);
                    },
                    asset: Assets.myCourse,
                    title: TextConstants.myCourse,
                  ),
                  _buildDivider(),
                  // _DrawerOptions(
                  //   onTap: () {
                  //     (isAffiliated == true)
                  //         ? Get.toNamed(Routes.affiliation)
                  //         : Get.toNamed(Routes.applyAffiliation);
                  //   },
                  //   asset: Assets.affiliation,
                  //   title: (isAffiliated == true)
                  //       ? TextConstants.affiliationPartner
                  //       : TextConstants.applyForAffiliation,
                  // ),
                  // _buildDivider(),

                  _buildDivider(),
                  _DrawerOptions(
                    onTap: () => Get.toNamed(Routes.feedback),
                    asset: Assets.feedback,
                    title: TextConstants.feedback,
                  ),
                  _buildDivider(),
                  _DrawerOptions(
                    onTap: () => Get.toNamed(Routes.support),
                    asset: Assets.support,
                    title: TextConstants.support,
                  ),

                  if (Platform.isIOS)
                    ListTile(
                      title: GestureDetector(
                        onTap: () {
                          deleteDailog(
                              context: context,
                              message:
                                  'Are you sure you want to delete your account? This action is irreversible and will permanently remove all your data.',
                              onTap: () {
                                Get.find<DashboardViewController>().logout();
                              });
                        },
                        child: SizedBox(
                          height: 30,
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete,
                                size: 26,
                                color: AppColors.red.withOpacity(0.7),
                              ),
                              const SizedBox(width: 22),
                              Text(
                                TextConstants.deleteAccount,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'NotoSerifBengali',
                                  color: AppColors.red.withOpacity(0.7),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  else
                    const SizedBox(height: 50),
                  _buildLogoutTile(),
                  const SizedBox(height: 67),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildFooter(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ValueListenableBuilder<PackageInfo>(
                valueListenable: _packageInfo,
                builder: (BuildContext context, PackageInfo value, child) {
                  return Text("${value.version} (${value.buildNumber})");
                },
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.only(left: 16.0),
      child: Divider(
        height: 0,
        thickness: 0.5,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildUserSection() {
    UserModel userModel = profileController.userModel;
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          margin: const EdgeInsets.only(top: 40),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: (profileController.pageState == PageState.loading)
                ? CachedNetworkImage(
                    imageUrl: noProfileFoundURL,
                    cacheKey: noProfileFoundURL,
                    fit: BoxFit.cover,
                  )
                : CachedNetworkImage(
                    imageUrl: profileController.userModel.image?.link ??
                        noProfileFoundURL,
                    cacheKey: profileController.userModel.image?.link ??
                        noProfileFoundURL,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          userModel.name.isNotNull ? userModel.name : "No name found",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
            fontFamily: 'NotoSerifBengali',
          ),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  ListTile _buildLogoutTile() {
    return ListTile(
      title: GestureDetector(
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
        child: const SizedBox(
          height: 30,
          child: Row(
            children: [
              Icon(
                Icons.logout,
                size: 26,
                color: AppColors.primary,
              ),
              SizedBox(width: 22),
              Text(
                TextConstants.logout,
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'NotoSerifBengali',
                  color: AppColors.primary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return GestureDetector(
      onTap: () => _launchURL(nextiveWebsite),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            TextConstants.developedBy,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
          Text(
            TextConstants.nextiveSolution,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'NotoSerifBengali',
              color: AppColors.deepBlue,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class _DrawerOptions extends StatelessWidget {
  const _DrawerOptions({
    required this.onTap,
    required this.asset,
    required this.title,
  });

  final String asset;
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: SizedBox(
        height: 50,
        child: Row(
          children: [
            Image.asset(
              asset,
              color: AppColors.lightBlack90,
              height: 20,
              width: 20,
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 17,
                  fontFamily: 'NotoSerifBengali',
                  color: AppColors.lightBlack90,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
