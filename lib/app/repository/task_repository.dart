import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/task.dart';

class TaskRepository {
  Future<bool> addTask(Task task) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTasks = prefs.getStringList('tasks') ?? [];
    jsonTasks.add(jsonEncode(task.toJson()));
    return prefs.setStringList('tasks', jsonTasks);
  }

  Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTasks = prefs.getStringList('tasks') ?? [];
    return jsonTasks.map((e) => Task.fromJson(jsonDecode(e))).toList();
  }

  Future<bool> saveTask(List<Task> tasks) async{
    final prefs = await SharedPreferences.getInstance();
    final jsonTasks = tasks.map((e) => jsonEncode(e.toJson())).toList();
    return prefs.setStringList('tasks', jsonTasks);
  }

  Future<bool> deleteTask(Task task) async{
    final prefs = await SharedPreferences.getInstance();
    final jsonTasks = prefs.getStringList('tasks') ?? [];
    jsonTasks.remove(jsonEncode(task.toJson()));
    return prefs.setStringList('tasks', jsonTasks);
  }
}
