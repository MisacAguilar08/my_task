import 'package:flutter/cupertino.dart';
import 'package:my_task/app/model/OfflineSyncTask.dart';
import 'package:my_task/app/repository/offline_sync_repository.dart';

import '../../model/task.dart';

class OfflineSyncProvider extends ChangeNotifier {
  List<OfflineSyncTask> _pendingOperationsList = [];
  OfflineSyncRepository offlineSyncRepository = new OfflineSyncRepository();

  Future<void> fetchPendingTask() async {
    _pendingOperationsList = await offlineSyncRepository.getTasks();
    print("return:");
    print(_pendingOperationsList);
    print("enr return");
    notifyListeners();
  }

  List<OfflineSyncTask> get pendingOperations => _pendingOperationsList;

  void addPendingOperation(String type, Task task) {
    offlineSyncRepository
        .addPendingTask(OfflineSyncTask(id: task.id ,type: type, task: task));
    fetchPendingTask();
  }



  void clearOperations() {
    _pendingOperationsList.clear();
    notifyListeners();
  }
}
