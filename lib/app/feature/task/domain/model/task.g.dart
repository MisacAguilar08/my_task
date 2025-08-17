// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Task _$TaskFromJson(Map<String, dynamic> json) => _Task(
      json['date'] as String,
      json['title'] as String,
      json['done'] ?? false,
      json['id'] as String? ?? "",
      (json['notification'] as num?)?.toInt() ?? 0,
      json['recordatorio'] as String? ?? "none",
    );

Map<String, dynamic> _$TaskToJson(_Task instance) => <String, dynamic>{
      'date': instance.date,
      'title': instance.title,
      'done': instance.done,
      'id': instance.id,
      'notification': instance.notification,
      'recordatorio': instance.recordatorio,
    };
