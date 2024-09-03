import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/service/cache/cache_keys.dart';
import 'package:science_platform/src/core/service/cache/cache_service.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/feature/profile/model/user_model.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/assets.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    final appUserInfo = CacheService.boxAuth.read(CacheKeys.user);
    if (appUserInfo != null) {
      user = UserModel.fromJson(appUserInfo);
    }
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    Future.delayed(const Duration(seconds: 2)).then(
      (value) {
        if (CacheService.boxAuth.read(CacheKeys.token) != null
            //   &&
            //  user?.phoneVerifiedAt != null
            ) {
          Get.offNamed(Routes.dashboard);
        } else {
          Get.offNamed(Routes.login);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.pageBackgroundColor,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.primaryDark,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 25,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                const Spacer(),
                Center(
                  child: Image.asset(
                    Assets.whiteIcon,
                    width: 180,
                  ),
                ),
                const Spacer(),
                Image.asset(
                  Assets.whiteLogo,
                  width: 280,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
