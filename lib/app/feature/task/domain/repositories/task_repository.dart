
import 'package:my_task/app/feature/task/domain/model/task.dart';

abstract class TaskRepository {
  Future<void> saveTask(Task task);
  Future<List<Task>> getTasks();
  Future<void> deleteTask(String taskId);
  Future<void> updateTask(Task task);
}
