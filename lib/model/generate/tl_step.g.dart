// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../todo/tl_step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TLStepImpl _$$TLStepImplFromJson(Map<String, dynamic> json) => _$TLStepImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      isChecked: json['isChecked'] as bool? ?? false,
    );

Map<String, dynamic> _$$TLStepImplToJson(_$TLStepImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'isChecked': instance.isChecked,
    };
