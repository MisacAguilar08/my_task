import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
abstract class Task with _$Task {
  const factory Task(String date, String title,
      [@Default(false) done,
      @Default("") String id,
      @Default(0) int notification,
      @Default("none") String recordatorio]) = _Task;
  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
