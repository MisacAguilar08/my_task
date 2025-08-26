
import 'package:flutter/material.dart';
import 'package:my_task/app/pages/task_list/offline_sync_provider.dart';
import 'package:my_task/app/pages/task_list/task_provider.dart';
import 'package:my_task/app/services/notifications.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';


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
