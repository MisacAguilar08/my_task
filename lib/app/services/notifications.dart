import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

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

  Future<void> showInstantNotification(String title, String body) async {
    const NotificationDetails plaformChannelSpecifics = NotificationDetails(
        android: AndroidNotificationDetails("channel_id", "channel_name",
            importance: Importance.high, priority: Priority.high),
        iOS: DarwinNotificationDetails());

    await flutterLocalNotificationsPlugin.show(
        0, title, body, plaformChannelSpecifics);
  }

  Future<void> scheduleNotification(
      String title, String body, int scheduleDate) async {
    const NotificationDetails plaformChannelSpecifics = NotificationDetails(
        android: AndroidNotificationDetails("channel_id", "channel_name",
            importance: Importance.high, priority: Priority.high),
        iOS: DarwinNotificationDetails());

    await flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(Duration(seconds: scheduleDate)),
        plaformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
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
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
