// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../settings_data/todos_in_category_widget_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ToDosInCategoryWidgetSettingsImpl
    _$$ToDosInCategoryWidgetSettingsImplFromJson(Map<String, dynamic> json) =>
        _$ToDosInCategoryWidgetSettingsImpl(
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

Map<String, dynamic> _$$ToDosInCategoryWidgetSettingsImplToJson(
        _$ToDosInCategoryWidgetSettingsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'workspace': instance.workspace,
      'bigCategory': instance.bigCategory,
      'smallCategory': instance.smallCategory,
    };
