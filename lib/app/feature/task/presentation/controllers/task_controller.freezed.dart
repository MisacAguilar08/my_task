// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskState {
  List<Task>? get tasks;
  bool get loading;
  String? get error;

  /// Create a copy of TaskState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TaskStateCopyWith<TaskState> get copyWith =>
      _$TaskStateCopyWithImpl<TaskState>(this as TaskState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TaskState &&
            const DeepCollectionEquality().equals(other.tasks, tasks) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(tasks), loading, error);

  @override
  String toString() {
    return 'TaskState(tasks: $tasks, loading: $loading, error: $error)';
  }
}

/// @nodoc
abstract mixin class $TaskStateCopyWith<$Res> {
  factory $TaskStateCopyWith(TaskState value, $Res Function(TaskState) _then) =
      _$TaskStateCopyWithImpl;
  @useResult
  $Res call({List<Task>? tasks, bool loading, String? error});
}

/// @nodoc
class _$TaskStateCopyWithImpl<$Res> implements $TaskStateCopyWith<$Res> {
  _$TaskStateCopyWithImpl(this._self, this._then);

  final TaskState _self;
  final $Res Function(TaskState) _then;

  /// Create a copy of TaskState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = freezed,
    Object? loading = null,
    Object? error = freezed,
  }) {
    return _then(_self.copyWith(
      tasks: freezed == tasks
          ? _self.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>?,
      loading: null == loading
          ? _self.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _TaskState implements TaskState {
  const _TaskState({final List<Task>? tasks, this.loading = false, this.error})
      : _tasks = tasks;

  final List<Task>? _tasks;
  @override
  List<Task>? get tasks {
    final value = _tasks;
    if (value == null) return null;
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final bool loading;
  @override
  final String? error;

  /// Create a copy of TaskState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TaskStateCopyWith<_TaskState> get copyWith =>
      __$TaskStateCopyWithImpl<_TaskState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TaskState &&
            const DeepCollectionEquality().equals(other._tasks, _tasks) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_tasks), loading, error);

  @override
  String toString() {
    return 'TaskState(tasks: $tasks, loading: $loading, error: $error)';
  }
}

/// @nodoc
abstract mixin class _$TaskStateCopyWith<$Res>
    implements $TaskStateCopyWith<$Res> {
  factory _$TaskStateCopyWith(
          _TaskState value, $Res Function(_TaskState) _then) =
      __$TaskStateCopyWithImpl;
  @override
  @useResult
  $Res call({List<Task>? tasks, bool loading, String? error});
}

/// @nodoc
class __$TaskStateCopyWithImpl<$Res> implements _$TaskStateCopyWith<$Res> {
  __$TaskStateCopyWithImpl(this._self, this._then);

  final _TaskState _self;
  final $Res Function(_TaskState) _then;

  /// Create a copy of TaskState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tasks = freezed,
    Object? loading = null,
    Object? error = freezed,
  }) {
    return _then(_TaskState(
      tasks: freezed == tasks
          ? _self._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>?,
      loading: null == loading
          ? _self.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
