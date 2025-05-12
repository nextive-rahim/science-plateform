import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/helper_methods.dart';

class NotificationNavigation {
  static Future<void> forgroundTabHandle(NotificationResponse response) async {
    Log.info('Forground Message OnTapped: ${response.payload}');
    Map<String, dynamic> data = jsonDecode(response.payload!);

    if (data['type'] == 'course') {
      Get.toNamed(
        Routes.courseDetails,
        arguments: data['action_url'],
      );
    } else if (data['type'] == 'notice') {
      Get.toNamed(
        Routes.notice,
        arguments: data['action_url'],
      );
    } else if (data['type'] == 'link') {
      urlLauncher(data['action_url']);
    }
  }

  static Future<void> backgroundTabHandle(RemoteMessage initialMessage) async {
    Log.info('BackGround Message OnTapped');
    if (initialMessage.data ['type'] == 'course') {
      Get.toNamed(
        Routes.courseDetails,
        arguments: initialMessage.data['action_url'],
      );
    } else if (initialMessage.data['type'] == 'notice') {
      Get.toNamed(
        Routes.notice,
        arguments: initialMessage.data['action_url'],
      );
    } else if (initialMessage.data['type'] == 'link') {
      urlLauncher(initialMessage.data['action_url']);
    }
  }
}
