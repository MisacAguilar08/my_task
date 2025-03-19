import 'package:flutter/material.dart';
import 'package:my_task/app/repository/task_repository.dart';

import '../../model/task.dart';
import '../../services/note_service.dart';

class TaskProvider extends ChangeNotifier{
  List<Task> _taskList = [];
  final TaskRepository _taskRepository = TaskRepository();

  Future<void> fetchTasks() async {
    // try{
      _taskList = await _taskRepository.getTasks();
      notifyListeners();
      // NotesService notesService = new NotesService();
      // _taskList = await notesService.getNotes();
      // if(_taskList.isEmpty){
      //   _taskList = await _taskRepository.getTasks();
      // }

    // }catch(e){
    //   _taskList = await _taskRepository.getTasks();
    // }
  }

  List<Task> get taskList => _taskList;


  void onTaskDoneChange(Task task) {
    task.done = !task.done;
    _taskRepository.saveTask(_taskList);
    notifyListeners();
  }

  void addTask(Task task) {
    _taskRepository.addTask(task);
    fetchTasks();
  }

  void deleteTask(Task task){
    _taskRepository.deleteTask(task);
    fetchTasks();
  }

  void editTask(Task task){
    _taskRepository.editTask(task);
    fetchTasks();
  }
}