import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class BkashWebViewPage extends StatefulWidget {
  const BkashWebViewPage({super.key});

  @override
  State<BkashWebViewPage> createState() => _BkashWebViewPageState();
}

class _BkashWebViewPageState extends State<BkashWebViewPage> {
  late final WebViewController _controller;
  bool isShowSnackMessage = false;
  String? bkashWebviewUrl;
  @override
  void initState() {
    super.initState();
    bkashWebviewUrl = Get.arguments;
    initWebview();
  }

  void initWebview() {
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
          onPageFinished: (String url) async {
            print("Bkash redirect URL :$url");
            if (isShowSnackMessage) {
              return;
            }

            /// Success Sate
            if (url == TextConstants.successMessage) {
              Get.offAllNamed(Routes.splash);
              Get.snackbar(
                  TextConstants.message, TextConstants.enrollSuccessful);
              isShowSnackMessage = true;
              return;
            }

            /// Failure Sate
            if (url == TextConstants.failurMessage) {
              Future.delayed(const Duration(seconds: 2));
              Get.back();
              Get.snackbar(TextConstants.message, TextConstants.enrollFailed);
              isShowSnackMessage = true;
              return;
            }

            /// Cancel Sate
            if (url == TextConstants.cencelMessage) {
              Future.delayed(const Duration(seconds: 2));
              Get.back();
              Get.snackbar(TextConstants.message, TextConstants.enrollFailed);
              isShowSnackMessage = true;
              return;
            }
          },
        ),
      )
      ..loadRequest(
        Uri.parse(bkashWebviewUrl ?? ''),
      );

    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: WebViewWidget(controller: _controller),
      ),
    );
  }

  // Future<bool> _onWillPop() async {
  //   if (await _controller.canGoBack()) {
  //     await _controller.goBack();
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }
}
