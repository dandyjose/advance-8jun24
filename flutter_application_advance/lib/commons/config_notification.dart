import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ConfigNotification {
  AwesomeNotifications awesomeNotifications = AwesomeNotifications();
  void initialNotification() async {
    var tokenFirebase = await FirebaseMessaging.instance.getToken();
    print('Token Firebase : $tokenFirebase');
    await awesomeNotifications.initialize(
        null,
        [
          NotificationChannel(
            channelKey: 'notif',
            channelName: 'Notif',
            channelDescription: 'Test Notification',
            defaultColor: Colors.blueAccent,
            importance: NotificationImportance.High,
          )
        ],
        debug: true);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(alert: true, sound: true);
    FirebaseMessaging.onMessage.listen((event) {
      showNotification(
          event.notification!.title ?? '', event.notification!.body ?? '');
    });
    FirebaseMessaging.onBackgroundMessage((message) => showNotification(
        message.notification!.title ?? '', message.notification!.body ?? ''));
  }

  Future<void> showNotification(String title, String body) async {
    await awesomeNotifications.createNotification(
        content: NotificationContent(
            id: -1,
            channelKey: 'notif',
            title: title,
            body: body,
            notificationLayout: NotificationLayout.BigPicture,
            bigPicture:
                'https://www.shutterstock.com/image-vector/88-3d-flash-sale-banner-260nw-2176913847.jpg'));
  }
}
