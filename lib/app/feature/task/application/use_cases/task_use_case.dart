
import 'package:my_task/app/feature/task/domain/model/task.dart';
import 'package:my_task/app/feature/task/domain/repositories/task_repository.dart';

class TaskUseCase {
  final TaskRepository _taskRepository;

  TaskUseCase(this._taskRepository);


  Future<List<Task>> call() async {
    final response = await _taskRepository.getTasks();
    return response;
  }


}