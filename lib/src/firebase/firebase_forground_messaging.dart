import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/core/service/cache/cache_keys.dart';
import 'package:science_platform/src/core/service/cache/cache_service.dart';
import 'package:science_platform/src/local_push_notification/local_push_notificaion.dart';
import 'package:science_platform/src/local_push_notification/notification_navigation.dart';

class FirebaseForgroundPushNotification {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final LocalPushNotification localPushNotification = LocalPushNotification();

  Future<void> init() async {
    bool isPermissionGranted = await _initiatePermissionStatusCheck();
    if (isPermissionGranted) {
      await retrieveFCMToken();
      await LocalPushNotification().init();
      FirebaseMessaging.onMessage.listen(_forgroundFirebaseMessageReceived);
      FirebaseMessaging.onMessageOpenedApp
          .listen(NotificationNavigation.backgroundTabHandle);
    }
  }

  Future<bool> _initiatePermissionStatusCheck() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    Log.info('Permission status: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      Log.info('Permission status: Authorized');
      return true;
    }
    return false;
  }

  Future<String> retrieveFCMToken() async {
    String token;
    if (Platform.isIOS) {
      token = await messaging.getAPNSToken() ?? 'No FCM Token';
    } else {
      token = await messaging.getToken() ?? 'No FCM Token';
    }

    CacheService.box.write(CacheKeys.fcmToken, token);
    Log.info("APNS Token : $token");
    return token;
  }

  void _forgroundFirebaseMessageReceived(RemoteMessage message) {
    final RemoteNotification? notification = message.notification;
    final AndroidNotification? android = message.notification?.android;
    Map<String, dynamic> data = message.data;

    if (message.notification != null) {
      print('Forground Notification Data : $data');
      localPushNotification.showNotification(
        message: ReceivedNotification(
          id: notification.hashCode,
          title: notification?.title,
          body: notification?.body,
          image: android?.imageUrl,
          payload: jsonEncode(data),
        ),
      );
    }
  }
}
