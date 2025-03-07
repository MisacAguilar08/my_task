import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_task/app/pages/task_list/offline_sync_provider.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/services/ConnectivityService.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Configuración de Firebase
  );

  final offlineSyncProvider = OfflineSyncProvider();
  final connectivityService = ConnectivityService();

  connectivityService.onConnectivityChanged.listen((result) {
    if (result != ConnectivityResult.none) {
      connectivityService.synchronizeData(offlineSyncProvider);
    }
  });


  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => OfflineSyncProvider()),
  ],
  child: MyApp(),));
}
