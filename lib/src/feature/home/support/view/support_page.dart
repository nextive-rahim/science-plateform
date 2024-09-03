import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/feature/authentication/root/widgets/scrollable_wrapper.dart';
import 'package:science_platform/src/feature/home/support/controller/support_view_controller.dart';
import 'package:science_platform/src/feature/home/support/widgets/support_info_item.dart';
import 'package:science_platform/src/utils/app_constants.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/custom_app_bar.dart';
import 'package:science_platform/src/widgets/rounded_button.dart';

class SupportPage extends GetView<SupportViewController> {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: TextConstants.support),
      body: ScrollableWrapper(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              const SupportInfoItem(
                isHotline: true,
                title: TextConstants.hotline,
                icon: Icons.phone_in_talk_outlined,
                info: companyPhone1,
              ),
              SupportInfoItem(
                title: TextConstants.email,
                icon: Icons.email_outlined,
                info: companyEmail,
                btnText: TextConstants.sendMail,
                onBtnTap: () {
                  controller.emailSupport();
                },
              ),
              SupportInfoItem(
                title: TextConstants.address,
                icon: Icons.location_on_outlined,
                details: companyLocation,
                onBtnTap: () {},
              ),
              SupportInfoItem(
                title: TextConstants.onSocialMedia,
                icon: CupertinoIcons.globe,
                footerItems: controller.socialMediaItems
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: RoundedButton(
                          onPressed: e['url'],
                          horizontalPadding: 0,
                          verticalPadding: 0,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            e['icon'],
                            scale: 1,
                            fit: BoxFit.contain,
                            color: AppColors.primary,
                            width: 27,
                            height: 27,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
