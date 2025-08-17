// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Task {
  String get date;
  String get title;
  dynamic get done;
  String get id;
  int get notification;
  String get recordatorio;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TaskCopyWith<Task> get copyWith =>
      _$TaskCopyWithImpl<Task>(this as Task, _$identity);

  /// Serializes this Task to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Task &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other.done, done) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.notification, notification) ||
                other.notification == notification) &&
            (identical(other.recordatorio, recordatorio) ||
                other.recordatorio == recordatorio));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      date,
      title,
      const DeepCollectionEquality().hash(done),
      id,
      notification,
      recordatorio);

  @override
  String toString() {
    return 'Task(date: $date, title: $title, done: $done, id: $id, notification: $notification, recordatorio: $recordatorio)';
  }
}

/// @nodoc
abstract mixin class $TaskCopyWith<$Res> {
  factory $TaskCopyWith(Task value, $Res Function(Task) _then) =
      _$TaskCopyWithImpl;
  @useResult
  $Res call(
      {String date,
      String title,
      dynamic done,
      String id,
      int notification,
      String recordatorio});
}

/// @nodoc
class _$TaskCopyWithImpl<$Res> implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._self, this._then);

  final Task _self;
  final $Res Function(Task) _then;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? title = null,
    Object? done = freezed,
    Object? id = null,
    Object? notification = null,
    Object? recordatorio = null,
  }) {
    return _then(_self.copyWith(
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      done: freezed == done
          ? _self.done
          : done // ignore: cast_nullable_to_non_nullable
              as dynamic,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      notification: null == notification
          ? _self.notification
          : notification // ignore: cast_nullable_to_non_nullable
              as int,
      recordatorio: null == recordatorio
          ? _self.recordatorio
          : recordatorio // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Task implements Task {
  const _Task(this.date, this.title,
      [this.done = false,
      this.id = "",
      this.notification = 0,
      this.recordatorio = "none"]);
  factory _Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  @override
  final String date;
  @override
  final String title;
  @override
  @JsonKey()
  final dynamic done;
  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final int notification;
  @override
  @JsonKey()
  final String recordatorio;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TaskCopyWith<_Task> get copyWith =>
      __$TaskCopyWithImpl<_Task>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TaskToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Task &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other.done, done) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.notification, notification) ||
                other.notification == notification) &&
            (identical(other.recordatorio, recordatorio) ||
                other.recordatorio == recordatorio));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      date,
      title,
      const DeepCollectionEquality().hash(done),
      id,
      notification,
      recordatorio);

  @override
  String toString() {
    return 'Task(date: $date, title: $title, done: $done, id: $id, notification: $notification, recordatorio: $recordatorio)';
  }
}

/// @nodoc
abstract mixin class _$TaskCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$TaskCopyWith(_Task value, $Res Function(_Task) _then) =
      __$TaskCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String date,
      String title,
      dynamic done,
      String id,
      int notification,
      String recordatorio});
}

/// @nodoc
class __$TaskCopyWithImpl<$Res> implements _$TaskCopyWith<$Res> {
  __$TaskCopyWithImpl(this._self, this._then);

  final _Task _self;
  final $Res Function(_Task) _then;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? date = null,
    Object? title = null,
    Object? done = freezed,
    Object? id = null,
    Object? notification = null,
    Object? recordatorio = null,
  }) {
    return _then(_Task(
      null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == done
          ? _self.done
          : done // ignore: cast_nullable_to_non_nullable
              as dynamic,
      null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      null == notification
          ? _self.notification
          : notification // ignore: cast_nullable_to_non_nullable
              as int,
      null == recordatorio
          ? _self.recordatorio
          : recordatorio // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
