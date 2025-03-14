import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> onDidReceiveNotification(
      NotificationResponse notificationResponse) async {}

  Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    const DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: darwinInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotification,
        onDidReceiveBackgroundNotificationResponse: onDidReceiveNotification);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> showInstantNotification(
      String body, int minutes, int idNotification,
      {String title = "Recordatorio"}) async {
    Timer.periodic(Duration(seconds: minutes), (Timer timer) async {
      const NotificationDetails plaformChannelSpecifics = NotificationDetails(
          android: AndroidNotificationDetails("channel_id", "channel_name",
              importance: Importance.high, priority: Priority.high),
          iOS: DarwinNotificationDetails());

      await flutterLocalNotificationsPlugin.show(
          idNotification, title, body, plaformChannelSpecifics,
          payload: 'payload');
    });
  }

  Future<void> scheduleNotification(int idNotification,
      String body, int scheduleDate,  {String title = "Recordatorio"}) async {
    tz.initializeTimeZones();
    const NotificationDetails plaformChannelSpecifics = NotificationDetails(
        android: AndroidNotificationDetails("channel_id", "channel_name",
            importance: Importance.high, priority: Priority.high),
        iOS: DarwinNotificationDetails());

    await flutterLocalNotificationsPlugin.zonedSchedule(
        idNotification,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(Duration(seconds: scheduleDate)),
        plaformChannelSpecifics,
        matchDateTimeComponents: DateTimeComponents.time,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  }

  Future<void> intervalNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'repeating channel id', 'repeating channel name',
            channelDescription: 'repeating description');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.periodicallyShow(
        1,
        'intervalNotification',
        'intervalNotification body',
        RepeatInterval.everyMinute,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  }

  Future<void> periodicallyNotification(int idNotification,
      String body, RepeatInterval scheduleDate,  {String title = "Recordatorio"}) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'repeating channel id', 'repeating channel name',
            channelDescription: 'repeating description');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.periodicallyShow(
        idNotification,
        title,
        body,
        scheduleDate,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  }

  // Future<void> scheduleNotification(int id, int intervalMinutes) async {
  //   tz.initializeTimeZones();
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //       id,
  //       'Título de la Notificación min',
  //       'Contenido de la Notificación min ',
  //       tz.TZDateTime.now(tz.local).add(Duration(minutes: intervalMinutes)),
  //       NotificationDetails(
  //         android: AndroidNotificationDetails(
  //           'repeating_channel_id',
  //           'Recurrentes',
  //           channelDescription: 'Notificaciones recurrentes cada X minutos',
  //         ),
  //       ),
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime,
  //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //       matchDateTimeComponents: DateTimeComponents.time);
  // }

  Future<void> cancelNotification(int id) async {
    print(id);
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
