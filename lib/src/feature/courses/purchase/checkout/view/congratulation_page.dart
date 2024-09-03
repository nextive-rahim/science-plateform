import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/assets.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CongratulationPage extends StatelessWidget {
  const CongratulationPage({super.key});

  //final PaymentDataModel paymentDataModel = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            TextConstants.congratulation,
            style: AppTextStyle.semibold18,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: 335,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Image.asset(Assets.congratulations),
                ),
              ),
              const SizedBox(height: 56),
              const Text(
                TextConstants.congratulation,
                style: AppTextStyle.semibold18,
              ),
              const Text(
                TextConstants.congratulationCaption1,
                style: AppTextStyle.semibold12,
              )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: PrimaryButton(
            onTap: () {
              Get.offAllNamed(Routes.dashboard);
            },
            widget: Text(
              TextConstants.next,
              style: AppTextStyle.bold16.copyWith(color: AppColors.white),
            ),
          ),
        ),
      ),
    );
  }
}
