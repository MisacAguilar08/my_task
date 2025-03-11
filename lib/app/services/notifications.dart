
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();


Future<void> scheduleNotification(int intervalMinutes) async {
  tz.initializeTimeZones();
  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Título de la Notificación min',
      'Contenido de la Notificación min ',
      tz.TZDateTime.now(tz.local).add(Duration(minutes: intervalMinutes)),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'repeating_channel_id',
          'Recurrentes',
          channelDescription: 'Notificaciones recurrentes cada X minutos',
        ),
      ),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time);
}


Future<void> cancelNotification(int id) async{
  await flutterLocalNotificationsPlugin.cancelAll();
}