import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/feature/authentication/signup/controller/otp_verification_view_controller.dart.dart';
import 'package:science_platform/src/feature/profile/controller/profile_view_controller.dart';
import 'package:science_platform/src/feature/profile/model/user_model.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/app_constants.dart';
import 'package:science_platform/src/widgets/gradient_text.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';
import 'package:science_platform/src/widgets/rounded_button.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ProfileInfoScreen extends GetView<ProfileViewController> {
  const ProfileInfoScreen({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4FA),
      appBar: AppBar(
        title: const Text('Student Info'),
      ),
      body: Obx(
        () {
          if (controller.pageState == PageState.loading) {
            return LoadingIndicator.list();
          }
          return _UserDetails(
            user: controller.userModel,
          );
        },
      ),
    );
  }
}

class _UserDetails extends StatelessWidget {
  const _UserDetails({
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        SectionContainer(
          horizontalPadding: 15,
          verticalPadding: 15,
          radius: 15,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //TODO: Add profile image when the API is ready
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 105,
                    width: 105,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4FA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.lightBlack10,
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: user.image?.link == null
                            ? CachedNetworkImage(
                                imageUrl: noProfileFoundURL,
                                cacheKey: noProfileFoundURL,
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                imageUrl: user.image!.link!,
                                cacheKey: user.image!.link!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    height: 22 / 18,
                  ),
                ),
                const SizedBox(height: 5),
                FittedBox(
                  child: GestureDetector(
                    onTap: () {
                      _copyUserIdToClipboard(context);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'ID: ',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: user.id.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              height: 20 / 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF4866D7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  user.institution ?? '-',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    height: 21 / 14,
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 31,
                  child: Row(
                    children: [
                      Expanded(
                        child: RoundedButton(
                          backgroundColor: Colors.transparent,
                          borderColor: AppColors.primary,
                          radius: 6,
                          onPressed: () {
                            Get.toNamed(Routes.updateProfilePage);
                          },
                          child: const GradientTitle(
                            title: 'Edit Info',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: RoundedButton(
                          backgroundColor: Colors.transparent,
                          borderColor: AppColors.primary,
                          radius: 6,
                          onPressed: () async {
                            await Get.put(
                              OtpVerificationViewController()
                                  .getOTP(user.phone),
                            );
                            Get.offNamed(Routes.setNewPassword);
                          },
                          child: const GradientTitle(
                            title: 'Change Password',
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SectionContainer(
          title: 'Basic Information',
          titleColor: Colors.black,
          horizontalPadding: 15,
          verticalPadding: 15,
          radius: 15,
          child: Column(
            children: [
              _InfoItem(
                title: 'Name',
                value: user.name,
              ),
              const SizedBox(height: 15),
              const _InfoItem(
                title: 'Profession',
                value: 'Student',
                showDivider: false,
              ),
            ],
          ),
        ),
        SectionContainer(
          title: 'Educational Information',
          titleColor: Colors.black,
          horizontalPadding: 15,
          verticalPadding: 15,
          radius: 15,
          child: Column(
            children: [
              _InfoItem(
                title: 'Institute',
                value: user.institution ?? 'N/A',
              ),
              const SizedBox(height: 15),
              _InfoItem(
                title: 'Session',
                value: user.educationalSession ?? 'N/A',
                showDivider: false,
              ),
            ],
          ),
        ),
        SectionContainer(
          title: 'Contact Information',
          titleColor: Colors.black,
          horizontalPadding: 15,
          verticalPadding: 15,
          radius: 15,
          child: Column(
            children: [
              _InfoItem(
                title: 'Email Address',
                value: user.email,
              ),
              const SizedBox(height: 15),
              _InfoItem(
                title: 'Phone Number',
                value: user.phone,
                showDivider: false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _copyUserIdToClipboard(BuildContext context) async {
    await Clipboard.setData(
      ClipboardData(text: user.id.toString()),
    ).then(
      (value) => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User ID copied to clipboard!'),
          duration: Duration(seconds: 1),
        ),
      ),
    );
  }
}

class SectionContainer extends StatelessWidget {
  const SectionContainer({
    super.key,
    this.title,
    this.child,
    this.horizontalPadding,
    this.verticalPadding,
    this.radius,
    this.titleColor,
  });
  final String? title;
  final Widget? child;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? radius;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius ?? 10),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? 10,
        vertical: verticalPadding ?? 10,
      ),
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                title!,
                style: TextStyle(
                  fontSize: 16,
                  height: 24 / 16,
                  color: titleColor ?? const Color(0xFF4866D7),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          child ?? const Offstage(),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.title,
    this.value,
    this.showDivider = true,
  });
  final String title;
  final String? value;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GradientText(
                title,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
                gradientType: GradientType.radial,
                radius: 2.5,
                colors: const [
                  Color(0xFF426058),
                  Color(0xFF00A579),
                ],
              ),
            ),
            Expanded(
              child: Text(
                value ?? '-',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  height: 15 / 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        showDivider
            ? const Divider(
                color: Color(0xFF00A579),
                thickness: 0.3,
              )
            : const Offstage(),
      ],
    );
  }
}
