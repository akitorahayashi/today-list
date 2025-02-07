// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../todo/tl_todos_in_today_and_whenever.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TLToDosInTodayAndWheneverImpl _$$TLToDosInTodayAndWheneverImplFromJson(
        Map<String, dynamic> json) =>
    _$TLToDosInTodayAndWheneverImpl(
      toDosInToday: (json['toDosInToday'] as List<dynamic>?)
              ?.map((e) => TLToDo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      toDosInWhenever: (json['toDosInWhenever'] as List<dynamic>?)
              ?.map((e) => TLToDo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$TLToDosInTodayAndWheneverImplToJson(
        _$TLToDosInTodayAndWheneverImpl instance) =>
    <String, dynamic>{
      'toDosInToday': instance.toDosInToday,
      'toDosInWhenever': instance.toDosInWhenever,
    };
