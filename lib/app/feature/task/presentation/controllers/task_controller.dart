

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_task/app/feature/task/application/use_cases/task_use_case.dart';
import 'package:my_task/app/feature/task/domain/model/task.dart';


part 'task_controller.freezed.dart';

@freezed
abstract class TaskState with _$TaskState {
  const factory TaskState({
    List<Task>? tasks,
    @Default(false) bool loading,
    String? error,
  }) = _TaskState;
}

class TaskController extends StateNotifier<TaskState> {
  TaskController(this._taskUseCase) : super(const TaskState()){
    init();
  }

  final TaskUseCase _taskUseCase;

  Future<void> init() async {
    state = state.copyWith(loading: true);
    try {
      final tasks = await _taskUseCase.call();
      state = state.copyWith(tasks: tasks, loading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), loading: false);
    }
  }
}

