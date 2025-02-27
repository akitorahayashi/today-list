// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../settings_data/tcw_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TCWSettingsImpl _$$TCWSettingsImplFromJson(Map<String, dynamic> json) =>
    _$TCWSettingsImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      workspace:
          TLWorkspace.fromJson(json['workspace'] as Map<String, dynamic>),
      bigCategory: json['bigCategory'] == null
          ? null
          : TLToDoCategory.fromJson(
              json['bigCategory'] as Map<String, dynamic>),
      smallCategory: json['smallCategory'] == null
          ? null
          : TLToDoCategory.fromJson(
              json['smallCategory'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TCWSettingsImplToJson(_$TCWSettingsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'workspace': instance.workspace,
      'bigCategory': instance.bigCategory,
      'smallCategory': instance.smallCategory,
    };
