import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:science_platform/firebase_options.dart';
import 'package:science_platform/src/core/service/cache/cache_service.dart';
import 'package:science_platform/src/firebase/firebase_background_messing.dart';
import 'package:science_platform/src/firebase/firebase_forground_messaging.dart';
import 'package:science_platform/src/routes/app_pages.dart';

import 'src/core/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheService().initialize();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    _lockOrientation();
    _initaislFirebaseService();
    super.initState();
  }

  Future<void> _initaislFirebaseService() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FirebaseMessaging.onBackgroundMessage(
        BackgroundNotificationService.firebaseBackgroundMessageListern);
    FirebaseForgroundPushNotification().init();
  }

  void _lockOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // debugInvertOversizedImages = true;
    return GetMaterialApp(
      navigatorObservers: [RouteObserver<ModalRoute<void>>()],
      title: 'Science Platform',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      getPages: AppPages.pages,
    );
  }
}
