import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/local_push_notification/notification_navigation.dart';

class LocalPushNotification {
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    InitializationSettings initialzationSettings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'), 
      iOS: DarwinInitializationSettings(),
    );

    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidNotificationChannel());
    await _localNotificationsPlugin
        .initialize(
      initialzationSettings,
      onDidReceiveNotificationResponse:
          NotificationNavigation.forgroundTabHandle,
      onDidReceiveBackgroundNotificationResponse: _onSelectNotification,
    )
        .then(
      (_) {
        Log.info('Local Notification Service: Successfully setup');
      },
    ).catchError(
      (Object error) {
        Log.info('Error(Local Notification Service): $error');
      },
    );
  }

  static _onSelectNotification(NotificationResponse response) {
    Log.info('_onSelectNotification: ${response.payload}');
  }

  AndroidNotificationChannel _androidNotificationChannel() {
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max,
    );
    return channel;
  }

  Future<void> showNotification({required ReceivedNotification message}) async {
    final String? bigPicture = message.image != null
        ? await _base64EncodedImage(message.image ?? '')
        : null;
    await _localNotificationsPlugin.show(
      message.id,
      message.title,
      message.body,
      NotificationDetails(
        android: _androidNotificationDetails(
            bigPicture != null
                ? BigPictureStyleInformation(
                    ByteArrayAndroidBitmap.fromBase64String(bigPicture),
                    largeIcon:
                        ByteArrayAndroidBitmap.fromBase64String(bigPicture),
                    hideExpandedLargeIcon: true,
                  )
                : null,
            imageUrl: bigPicture),
      ),
      payload: message.payload,
    );
  }

  Future<String> _base64EncodedImage(String url) async {
    try {
      Response<List<int>> response = await Dio().get<List<int>>(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      final String base64ImageLink = base64Encode(response.data!);

      return base64ImageLink;
    } catch (e) {
      return e.toString();
    }
  }

  AndroidNotificationDetails _androidNotificationDetails(
      StyleInformation? styleInformation,
      {String? imageUrl}) {
    return AndroidNotificationDetails(
      _androidNotificationChannel().id,
      _androidNotificationChannel().name,
      channelDescription: 'This is high importent notificaion channel',
      importance: Importance.max,
      priority: Priority.high,
      channelShowBadge: true,
      icon: '@mipmap/ic_launcher',
      styleInformation: styleInformation,
      fullScreenIntent: true,
      setAsGroupSummary: true,
      onlyAlertOnce: false,
      ticker: 'ticker',
      ongoing: true,
      largeIcon: imageUrl != null
          ? ByteArrayAndroidBitmap.fromBase64String(imageUrl)
          : null,
    );
  }
}

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    this.body,
    this.image,
    this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? image;
  final String? payload;
}
