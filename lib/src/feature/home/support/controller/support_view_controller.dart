import 'package:get/get.dart';
import 'package:science_platform/src/utils/app_constants.dart';
import 'package:science_platform/src/utils/assets.dart';
import 'package:science_platform/src/utils/helper_methods.dart';

class SupportViewController extends GetxController {
// Hotline Support
  Future<void> hotlineSupport() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: '01311-086752',
    );
    await urlLauncher(
      launchUri.toString(),
    );
  }

  Future<void> hotlineSupport2() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: '01321 22 42 22',
    );
    await urlLauncher(
      launchUri.toString(),
    );
  }

// Email Support
  Future<void> emailSupport() async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: companyEmail,
    );
    await urlLauncher(
      launchUri.toString(),
    );
  }

  // TODO: Add social media urls
  List socialMediaItems = [
    {
      'icon': Assets.fb,
      'url': () {
        urlLauncher(companyFacebook);
      },
    },
    // {
    //   'icon': Assets.linkedin,
    //   'url': () {
    //     urlLauncher(companyLinkedinSupport);
    //   },
    // },
    // {
    //   'icon': Assets.messenger,
    //   'url': () {
    //     urlLauncher(companyMessengerSupport);
    //   },
    // },
    // {
    //   'icon': Assets.whatsapp,
    //   'url': () {
    //     urlLauncher(companyWhatsappSupport);
    //   },
    // },
    {
      'icon': Assets.youtube,
      'url': () {
        urlLauncher(companyYoutubeSupport);
      },
    },
  ];
}
