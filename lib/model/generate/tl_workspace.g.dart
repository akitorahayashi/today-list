// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../todo/tl_workspace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TLWorkspaceImpl _$$TLWorkspaceImplFromJson(Map<String, dynamic> json) =>
    _$TLWorkspaceImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      workspaceIDToToDos:
          (json['workspaceIDToToDos'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k, TLToDosInTodayAndWhenever.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$TLWorkspaceImplToJson(_$TLWorkspaceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'workspaceIDToToDos': instance.workspaceIDToToDos,
    };
