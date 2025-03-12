import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_task/app/pages/task_list/offline_sync_provider.dart';
import 'package:my_task/app/pages/task_list/task_provider.dart';
import 'package:my_task/app/services/notifications.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'app/app.dart';
import 'app/services/ConnectivityService.dart';
import 'firebase_options.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {

  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform, // Configuración de Firebase
  // );
  //
  // FirebaseFirestore.instance.settings = const Settings(
  //   persistenceEnabled: false,
  //   host: 'firestore.googleapis.com', // Asegúrate de que use el host predeterminado
  //   sslEnabled: true,
  //   cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED, // Opcional si tienes cache habilitado
  // );
  // //
  //
  // final offlineSyncProvider = OfflineSyncProvider();
  // final connectivityService = ConnectivityService();
  //
  // connectivityService.onConnectivityChanged.listen((result) {
  //   if (result != ConnectivityResult.none) {
  //     FirebaseFirestore.instance.enableNetwork().then((_) {
  //       print("Firestore online.");
  //     });
  //     connectivityService.synchronizeData(offlineSyncProvider);
  //   }else{
  //     FirebaseFirestore.instance.disableNetwork().then((_) {
  //       print("Firestore offline.");
  //     });
  //   }
  // });
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService ns = NotificationService();
  await ns.init();

  runApp(MultiProvider(providers: [
    // ChangeNotifierProvider(create: (_) => OfflineSyncProvider()),
    ChangeNotifierProvider(create: (_) => TaskProvider()..fetchTasks()),
  ],
  child: MyApp(),));
}
