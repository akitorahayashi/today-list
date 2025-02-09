// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../settings_data/settings_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SettingsData _$SettingDataFromJson(Map<String, dynamic> json) {
  return _SettingData.fromJson(json);
}

/// @nodoc
mixin _$SettingData {
  String get currentAppIconName => throw _privateConstructorUsedError;

  /// Serializes this SettingData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SettingData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SettingDataCopyWith<SettingsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingDataCopyWith<$Res> {
  factory $SettingDataCopyWith(
          SettingsData value, $Res Function(SettingsData) then) =
      _$SettingDataCopyWithImpl<$Res, SettingsData>;
  @useResult
  $Res call({String currentAppIconName});
}

/// @nodoc
class _$SettingDataCopyWithImpl<$Res, $Val extends SettingsData>
    implements $SettingDataCopyWith<$Res> {
  _$SettingDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SettingData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentAppIconName = null,
  }) {
    return _then(_value.copyWith(
      currentAppIconName: null == currentAppIconName
          ? _value.currentAppIconName
          : currentAppIconName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SettingDataImplCopyWith<$Res>
    implements $SettingDataCopyWith<$Res> {
  factory _$$SettingDataImplCopyWith(
          _$SettingDataImpl value, $Res Function(_$SettingDataImpl) then) =
      __$$SettingDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String currentAppIconName});
}

/// @nodoc
class __$$SettingDataImplCopyWithImpl<$Res>
    extends _$SettingDataCopyWithImpl<$Res, _$SettingDataImpl>
    implements _$$SettingDataImplCopyWith<$Res> {
  __$$SettingDataImplCopyWithImpl(
      _$SettingDataImpl _value, $Res Function(_$SettingDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentAppIconName = null,
  }) {
    return _then(_$SettingDataImpl(
      currentAppIconName: null == currentAppIconName
          ? _value.currentAppIconName
          : currentAppIconName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SettingDataImpl implements _SettingData {
  const _$SettingDataImpl({this.currentAppIconName = "Sun Orange"});

  factory _$SettingDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingDataImplFromJson(json);

  @override
  @JsonKey()
  final String currentAppIconName;

  @override
  String toString() {
    return 'SettingData(currentAppIconName: $currentAppIconName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingDataImpl &&
            (identical(other.currentAppIconName, currentAppIconName) ||
                other.currentAppIconName == currentAppIconName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, currentAppIconName);

  /// Create a copy of SettingData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingDataImplCopyWith<_$SettingDataImpl> get copyWith =>
      __$$SettingDataImplCopyWithImpl<_$SettingDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingDataImplToJson(
      this,
    );
  }
}

abstract class _SettingData implements SettingsData {
  const factory _SettingData({final String currentAppIconName}) =
      _$SettingDataImpl;

  factory _SettingData.fromJson(Map<String, dynamic> json) =
      _$SettingDataImpl.fromJson;

  @override
  String get currentAppIconName;

  /// Create a copy of SettingData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingDataImplCopyWith<_$SettingDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
