import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';

import '../models/task_models.dart';
import '../utils/app_styles.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationHelper {
  initilizationsNotifications() async {
    loggers.i("initilizationsNotifications");
    configureLocalTimeZone();
    //init for android
    var androiInit =
        const AndroidInitializationSettings('@mipmap/ic_launcher'); //for logo

    //init for android
    // var iosInit = const IOSInitializationSettings();

    //configuer for multiplePlatform
    var initSetting = InitializationSettings(
      android: androiInit,
    );

    //initiliseting forflutterLocalNotifications
    flutterLocalNotificationsPlugin.initialize(initSetting,
        onDidReceiveNotificationResponse: (NotificationResponse response) {});
  }

  Future<void> displayNotfications(
      {required String title, required String body}) async {
    loggers.i("display notificatins");

    //androidPlatformChannelSpecfic
    AndroidNotificationDetails androidPlatformChannelSpecfic =
        const AndroidNotificationDetails("Todo App", "Todo App",
            importance: Importance.max,
            priority: Priority.high,
            playSound: true);

//configure the NotificationDetails fro multiplatforms
    NotificationDetails platformspecfic = NotificationDetails(
      android: androidPlatformChannelSpecfic,
    );
    await flutterLocalNotificationsPlugin.show(0, title, body, platformspecfic,
        payload: title);
  }

  ///sedulernotifications
  scheduledNotification(int hours, int minutes, Task task) async {
    loggers.i("thi is scheduledNotification ${task.id}");
    AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails("Todo App", "Todo App",
            priority: Priority.max, importance: Importance.max);

    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notiDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      task.id!,
      task.title,
      task.note,
      _convertDate(hours, minutes),
      notiDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: "notification-payload",
    );
  }

  Future<void> configureLocalTimeZone() async {
    loggers.i("initializeTimeZones");
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  tz.TZDateTime _convertDate(int hours, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hours, minutes);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  //seddulaer2
  void showNotification2() async {
    AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails(
            "notifications-youtube", "YouTube Notifications",
            priority: Priority.max, importance: Importance.max);

    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notiDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    DateTime scheduleDate = DateTime.now().add(const Duration(seconds: 5));

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        "Helooo",
        "Bibek chhetri ke xa kbr",
        tz.TZDateTime.from(scheduleDate, tz.local),
        notiDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true,
        payload: "notification-payload");
  }

  //
  void checkForNotification() async {
    NotificationAppLaunchDetails? details =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (details != null) {
      if (details.didNotificationLaunchApp) {
        NotificationResponse? response = details.notificationResponse;

        if (response != null) {
          String? payload = response.payload;
          loggers.i("Notification Payload: $payload");
        }
      }
    }
  }

  //
  //request permissions
  Future<void> requestAndroidPermissions() async {
    final status = await Permission.notification.request();
    if (status.isGranted) {
      // Permissions granted
    } else if (status.isDenied) {
      // Permissions denied
    } else if (status.isPermanentlyDenied) {
      // Permissions permanently denied, navigate to app settings
      openAppSettings();
    }
  }
}
