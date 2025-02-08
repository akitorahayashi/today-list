// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../tl_app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TLAppStateImpl _$$TLAppStateImplFromJson(Map<String, dynamic> json) =>
    _$TLAppStateImpl(
      tlWorkspaces: (json['tlWorkspaces'] as List<dynamic>?)
              ?.map((e) => TLWorkspace.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      currentWorkspaceIndex:
          (json['currentWorkspaceIndex'] as num?)?.toInt() ?? 0,
      selectedThemeType: $enumDecodeNullable(
              _$TLThemeTypeEnumMap, json['selectedThemeType']) ??
          TLThemeType.sunOrange,
    );

Map<String, dynamic> _$$TLAppStateImplToJson(_$TLAppStateImpl instance) =>
    <String, dynamic>{
      'tlWorkspaces': instance.tlWorkspaces,
      'currentWorkspaceIndex': instance.currentWorkspaceIndex,
      'selectedThemeType': instance.selectedThemeType,
    };

const _$TLThemeTypeEnumMap = {
  TLThemeType.sunOrange: 'sunOrange',
};
