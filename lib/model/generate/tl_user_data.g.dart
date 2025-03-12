// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../settings_data/tl_user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TLUserDataImpl _$$TLUserDataImplFromJson(Map<String, dynamic> json) =>
    _$TLUserDataImpl(
      currentAppIconName: json['currentAppIconName'] as String? ?? "Notebook",
      selectedCheckBoxIconData:
          json['selectedCheckBoxIconData'] == null
              ? const SelectedCheckBoxIconData(
                iconCategory: "Default",
                iconName: "Box",
              )
              : SelectedCheckBoxIconData.fromJson(
                json['selectedCheckBoxIconData'] as Map<String, dynamic>,
              ),
      earnedCheckBoxIcons:
          (json['earnedCheckBoxIcons'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
              k,
              (e as List<dynamic>).map((e) => e as String).toList(),
            ),
          ) ??
          const {
            "Default": ["Box", "Circle"],
          },
      customAccentColorValue: (json['customAccentColorValue'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TLUserDataImplToJson(_$TLUserDataImpl instance) =>
    <String, dynamic>{
      'currentAppIconName': instance.currentAppIconName,
      'selectedCheckBoxIconData': instance.selectedCheckBoxIconData,
      'earnedCheckBoxIcons': instance.earnedCheckBoxIcons,
      'customAccentColorValue': instance.customAccentColorValue,
    };
