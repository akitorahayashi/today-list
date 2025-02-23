// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../todo/tl_todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TLToDoImpl _$$TLToDoImplFromJson(Map<String, dynamic> json) => _$TLToDoImpl(
      id: json['id'] as String,
      workspaceID: json['workspaceID'] as String,
      categoryID: json['categoryID'] as String,
      isInToday: json['isInToday'] as bool,
      isChecked: json['isChecked'] as bool? ?? false,
      content: json['content'] as String,
      steps: (json['steps'] as List<dynamic>?)
              ?.map((e) => TLStep.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$TLToDoImplToJson(_$TLToDoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'workspaceID': instance.workspaceID,
      'categoryID': instance.categoryID,
      'isInToday': instance.isInToday,
      'isChecked': instance.isChecked,
      'content': instance.content,
      'steps': instance.steps,
    };
