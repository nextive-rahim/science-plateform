import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:science_platform/src/local_push_notification/notification_navigation.dart';

class BackgroundNotificationService {
  // Static function to handle background messages
  static Future<void> firebaseBackgroundMessageListern(
      RemoteMessage message) async {
    print("Handling a background message: ${message.data}");
  }

  /// Call in Home page
  static void setupBackgroundNotificationHandler(
      FirebaseMessaging firebaseMessaging) async {
    await backgroundNotificationHandler(firebaseMessaging: firebaseMessaging);
  }

  static Future<void> backgroundNotificationHandler({
    required FirebaseMessaging firebaseMessaging,
  }) async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage = await firebaseMessaging.getInitialMessage();
    print('Background Initaila message : $initialMessage');
    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      NotificationNavigation.backgroundTabHandle(initialMessage);
    }
  }
}
