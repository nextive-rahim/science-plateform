import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/feature/courses/purchase/course_purchase/controller/course_purchase_controller.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class BkashWebViewPage extends StatefulWidget {
  const BkashWebViewPage({super.key});

  @override
  State<BkashWebViewPage> createState() => _BkashWebViewPageState();
}

class _BkashWebViewPageState extends State<BkashWebViewPage> {
  late final WebViewController _controller;

  String bkashWebviewUrl =
      Get.find<CoursePurchaseController>().bkashWebviewUrl!;
  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
          onProgress: (int progress) {
            const CircularProgressIndicator();
          },
          onWebResourceError: (WebResourceError error) {},
          onUrlChange: (UrlChange change) {},
          onPageFinished: (String url) {
            print("Bkash redirect URL :$url");
            // if (url == 'https://science-platform.nextlms.net/payment/success') {
            //   Get.offAllNamed(Routes.dashboard);
            //   Get.snackbar(
            //     'Success',
            //     'Payment completed successfully',
            //   );
            // } else if (url == 'https://science-platform.nextlms.net/payment/failed') {
            //   Get.offAllNamed(Routes.dashboard);
            //   Get.snackbar(
            //     'Failed',
            //     'Payment failed',
            //   );
            // } else if (url == 'https://science-platform.nextlms.net/payment/canceled') {
            //   Get.back();
            // }
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message.message),
            ),
          );
        },
      )
      ..loadRequest(
        Uri.parse(bkashWebviewUrl),
      );

    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: WebViewWidget(controller: _controller),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (await _controller.canGoBack()) {
      await _controller.goBack();
      return false;
    } else {
      return true;
    }
  }
}
