// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../todo/tl_workspace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TLWorkspaceImpl _$$TLWorkspaceImplFromJson(Map<String, dynamic> json) =>
    _$TLWorkspaceImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      toDos: TLToDosInTodayAndWhenever.fromJson(
        json['toDos'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$$TLWorkspaceImplToJson(_$TLWorkspaceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'toDos': instance.toDos,
    };
