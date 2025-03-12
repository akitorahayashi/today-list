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
      currentWorkspaceID: json['currentWorkspaceID'] as String? ?? null,
      selectedThemeType: $enumDecodeNullable(
              _$TLThemeTypeEnumMap, json['selectedThemeType']) ??
          TLThemeType.notebook,
      tlUserData: json['tlUserData'] == null
          ? const TLUserData(
              currentAppIconName: "Notebook",
              selectedCheckBoxIconData: SelectedCheckBoxIconData(
                  iconCategory: "Default", iconName: "Box"),
              earnedCheckBoxIcons: {
                  "Default": ["Box", "Circle"]
                })
          : TLUserData.fromJson(json['tlUserData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TLAppStateImplToJson(_$TLAppStateImpl instance) =>
    <String, dynamic>{
      'tlWorkspaces': instance.tlWorkspaces,
      'currentWorkspaceID': instance.currentWorkspaceID,
      'selectedThemeType': instance.selectedThemeType,
      'tlUserData': instance.tlUserData,
    };

const _$TLThemeTypeEnumMap = {
  TLThemeType.sunOrange: 'sunOrange',
  TLThemeType.limeGreen: 'limeGreen',
  TLThemeType.marineBlue: 'marineBlue',
  TLThemeType.cherryBlossom: 'cherryBlossom',
  TLThemeType.pastryBloom: 'pastryBloom',
  TLThemeType.notebook: 'notebook',
};
