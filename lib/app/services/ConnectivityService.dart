import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:my_task/app/model/OfflineSyncTask.dart';
import 'package:my_task/app/repository/task_repository.dart';
import 'package:my_task/app/services/note_service.dart';

import '../model/task.dart';
import '../pages/task_list/offline_sync_provider.dart';
import '../repository/offline_sync_repository.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  NotesService notesService = NotesService();
  OfflineSyncRepository offlineSyncRepository = new OfflineSyncRepository();
  TaskRepository taskRepository = new TaskRepository();
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;

  void synchronizeData(OfflineSyncProvider offlineSyncProvider) async {
    await offlineSyncProvider.fetchPendingTask();
    await offlineSyncProvider.pendingOperations;

    offlineSyncProvider.pendingOperations.sort((a, b) => a.type.compareTo(b.type));
    for (OfflineSyncTask operation in offlineSyncProvider.pendingOperations) {
      try {
        Task task = operation.task;
        print("Offline id:${task.id}");
        if (operation.type.contains("create") ||
            operation.type.contains("update")) {
          bool isSave = await notesService.addNote(
              task.id, task.title, task.done, task.date);
          if (isSave) {
            print("save");
            offlineSyncRepository.deleteTask(operation.id);
          }
        } else if (operation.type.contains("delete")) {
          try {
            await notesService.deleteNote(operation.id);
            offlineSyncRepository.deleteTask(operation.id);
          } catch (e) {
            print(e);
          }
        }
        taskRepository.getTasks();
      } catch (e) {
        print("Error al sincronizar operación: $e");
      }
    }
  }
}
