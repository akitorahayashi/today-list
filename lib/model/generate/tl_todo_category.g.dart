// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../todo/tl_todo_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TLToDoCategoryImpl _$$TLToDoCategoryImplFromJson(Map<String, dynamic> json) =>
    _$TLToDoCategoryImpl(
      id: json['id'] as String,
      parentBigCategoryID: json['parentBigCategoryID'] as String?,
      name: (json['name'] ?? json['title']) as String,
    );

Map<String, dynamic> _$$TLToDoCategoryImplToJson(
        _$TLToDoCategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parentBigCategoryID': instance.parentBigCategoryID,
      'name': instance.name,
    };
