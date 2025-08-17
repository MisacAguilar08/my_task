import 'dart:convert';

import 'package:my_task/app/feature/task/data/datasources/task_local.dart';
import 'package:my_task/app/feature/task/domain/model/task.dart';
import 'package:my_task/app/feature/task/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {

  final TaskLocalDataSource _taskLocalDataSource;
  TaskRepositoryImpl(this._taskLocalDataSource);

  @override
  Future<void> deleteTask(String taskId) {
    final jsonTasks = _taskLocalDataSource.getStringList('tasks') ?? [];
    final task = Task.fromJson(jsonDecode(jsonTasks.firstWhere((task) => jsonDecode(task)['id'] == taskId)) as Map<String, dynamic>);
    jsonTasks.remove(jsonEncode(task.toJson()));
    return _taskLocalDataSource.setStringList('tasks', jsonTasks);
  }

  @override
  Future<List<Task>> getTasks() async{
    final jsonTasks = _taskLocalDataSource.getStringList('tasks') ?? [];
    return jsonTasks.map((e) => Task.fromJson(jsonDecode(e))).toList();
  }

  @override
  Future<void> saveTask(Task task) {
    final jsonTasks = _taskLocalDataSource.getStringList('tasks') ?? [];
    jsonTasks.add(jsonEncode(task.toJson()));
    return _taskLocalDataSource.setStringList('tasks', jsonTasks);
  }

  @override
  Future<void> updateTask(Task task) {
    final jsonTasks = _taskLocalDataSource.getStringList('tasks') ?? [];
    final taskIndex = jsonTasks.indexWhere((t) => jsonDecode(t)['id'] == task.id);
    if (taskIndex != -1) {
        jsonTasks[taskIndex] = jsonEncode(task.toJson());
        return _taskLocalDataSource.setStringList('tasks', jsonTasks);
    }
    throw Exception('Task not found');
  }
}

  // Future<bool> saveTask(List<Task> tasks) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final jsonTasks = tasks.map((e) => jsonEncode(e.toJson())).toList();
  //   return prefs.setStringList('tasks', jsonTasks);
  // }

  // Future<bool> editTask(Task task) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final jsonTasks = prefs.getStringList('tasks') ?? [];
  //   List<Task> jTask =
  //       jsonTasks.map((e) => Task.fromJson(jsonDecode(e))).toList();
  //   final index = jTask.indexWhere((item) => item.id == task.id);
  //   // jTask[index].title = task.title;
  //   // jTask[index].recordatorio = task.recordatorio;
  //   final encodeTasks = jTask.map((e) => jsonEncode(e.toJson())).toList();
  //   return prefs.setStringList('tasks', encodeTasks);
  // }