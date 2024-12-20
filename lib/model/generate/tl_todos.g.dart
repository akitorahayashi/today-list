// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../todo/tl_todos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TLToDosImpl _$$TLToDosImplFromJson(Map<String, dynamic> json) =>
    _$TLToDosImpl(
      toDosInToday: (json['toDosInToday'] as List<dynamic>?)
              ?.map((e) => TLToDo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      toDosInWhenever: (json['toDosInWhenever'] as List<dynamic>?)
              ?.map((e) => TLToDo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$TLToDosImplToJson(_$TLToDosImpl instance) =>
    <String, dynamic>{
      'toDosInToday': instance.toDosInToday,
      'toDosInWhenever': instance.toDosInWhenever,
    };
