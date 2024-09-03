import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class ExamWebviewPage extends StatefulWidget {
  const ExamWebviewPage({super.key});

  @override
  State<ExamWebviewPage> createState() => _ExamWebviewPageState();
}

class _ExamWebviewPageState extends State<ExamWebviewPage> {
  late final WebViewController _controller;
  String webviewLink = Get.arguments[0];
  String title = Get.arguments[1];

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
            onUrlChange: (UrlChange change) {},
            onPageFinished: (String url) {}),
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
        Uri.parse(webviewLink),
      );

    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    print(webviewLink);
    return PopScope(
      onPopInvoked: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   title: Text(title),
        // ),
        body: SafeArea(
          child: WebViewWidget(controller: _controller),
        ),
      ),
    );
  }

  _onWillPop(bool canGoBack) async {
    if (await _controller.canGoBack()) {
      await _controller.goBack();
      return false;
    } else {
      return true;
    }
  }
}
