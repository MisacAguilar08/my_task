
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_task/app/feature/task/data/datasources/task_local.dart';
import 'package:my_task/app/feature/task/provider/task_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'app/app.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  tz.initializeTimeZones();

   ProviderScope(overrides: [
    localStorageProvider.overrideWithValue(TaskLocalDataSource(prefs)),
  ], child: MyApp());
}
