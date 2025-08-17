
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_task/app/feature/task/application/use_cases/task_use_case.dart';
import 'package:my_task/app/feature/task/data/datasources/task_local.dart';
import 'package:my_task/app/feature/task/data/repositories/task_repository_impl.dart';
import 'package:my_task/app/feature/task/presentation/controllers/task_controller.dart';

final localStorageProvider = Provider<TaskLocalDataSource>((ref) {
  throw UnimplementedError();
});

final taskRepositoryProvider = Provider<TaskRepositoryImpl>((ref) {
    return TaskRepositoryImpl(ref.read(localStorageProvider));
});

final taskUseCaseProvider = Provider<TaskUseCase>((ref) {
    return TaskUseCase(ref.read(taskRepositoryProvider));
});
final taskControllerProvider = StateNotifierProvider<TaskController, TaskState>((ref) {
    return TaskController(ref.read(taskUseCaseProvider));
});


