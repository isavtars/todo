import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

import '../models/task_models.dart';
import '../utils/app_styles.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationHelper {
  initilizationsNotifications() async {
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
        AndroidNotificationDetails("Todo App", "Todo App",
            importance: Importance.max,
            priority: Priority.high,
            playSound: true);

//configure the NotificationDetails fro multiplatforms
    NotificationDetails platformspecfic = NotificationDetails(
      android: androidPlatformChannelSpecfic,
    );
    await flutterLocalNotificationsPlugin.show(0, title, body, platformspecfic,
        payload: title);

    //void
  }

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

  ///sedulernotifications
  scheduledNotification(int hours, int minutes, Task task) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      task.id!.toInt(),
      task.title,
      task.note,
      _comVertyeDate(hours, minutes),
      const NotificationDetails(
          android: AndroidNotificationDetails('Todo App', 'Todo App',
              channelDescription: "heloo from  channels")),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: "${task.title}|${task.note}|${task.startTime}|",
    );
  }

  Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  tz.TZDateTime _comVertyeDate(int hours, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hours, minutes);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }
}
