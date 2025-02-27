// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../settings_data/tl_user_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TLUserData _$TLUserDataFromJson(Map<String, dynamic> json) {
  return _TLUserData.fromJson(json);
}

/// @nodoc
mixin _$TLUserData {
// 現在のアプリアイコンの名前
  String get currentAppIconName =>
      throw _privateConstructorUsedError; // 選択されたチェックボックスのアイコン
  SelectedCheckBoxIconData get selectedCheckBoxIconData =>
      throw _privateConstructorUsedError; // 獲得したチェックボックスのアイコン
  Map<String, List<String>> get earnedCheckBoxIcons =>
      throw _privateConstructorUsedError;

  /// Serializes this TLUserData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TLUserData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TLUserDataCopyWith<TLUserData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TLUserDataCopyWith<$Res> {
  factory $TLUserDataCopyWith(
          TLUserData value, $Res Function(TLUserData) then) =
      _$TLUserDataCopyWithImpl<$Res, TLUserData>;
  @useResult
  $Res call(
      {String currentAppIconName,
      SelectedCheckBoxIconData selectedCheckBoxIconData,
      Map<String, List<String>> earnedCheckBoxIcons});

  $SelectedCheckBoxIconDataCopyWith<$Res> get selectedCheckBoxIconData;
}

/// @nodoc
class _$TLUserDataCopyWithImpl<$Res, $Val extends TLUserData>
    implements $TLUserDataCopyWith<$Res> {
  _$TLUserDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TLUserData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentAppIconName = null,
    Object? selectedCheckBoxIconData = null,
    Object? earnedCheckBoxIcons = null,
  }) {
    return _then(_value.copyWith(
      currentAppIconName: null == currentAppIconName
          ? _value.currentAppIconName
          : currentAppIconName // ignore: cast_nullable_to_non_nullable
              as String,
      selectedCheckBoxIconData: null == selectedCheckBoxIconData
          ? _value.selectedCheckBoxIconData
          : selectedCheckBoxIconData // ignore: cast_nullable_to_non_nullable
              as SelectedCheckBoxIconData,
      earnedCheckBoxIcons: null == earnedCheckBoxIcons
          ? _value.earnedCheckBoxIcons
          : earnedCheckBoxIcons // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
    ) as $Val);
  }

  /// Create a copy of TLUserData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SelectedCheckBoxIconDataCopyWith<$Res> get selectedCheckBoxIconData {
    return $SelectedCheckBoxIconDataCopyWith<$Res>(
        _value.selectedCheckBoxIconData, (value) {
      return _then(_value.copyWith(selectedCheckBoxIconData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TLUserDataImplCopyWith<$Res>
    implements $TLUserDataCopyWith<$Res> {
  factory _$$TLUserDataImplCopyWith(
          _$TLUserDataImpl value, $Res Function(_$TLUserDataImpl) then) =
      __$$TLUserDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String currentAppIconName,
      SelectedCheckBoxIconData selectedCheckBoxIconData,
      Map<String, List<String>> earnedCheckBoxIcons});

  @override
  $SelectedCheckBoxIconDataCopyWith<$Res> get selectedCheckBoxIconData;
}

/// @nodoc
class __$$TLUserDataImplCopyWithImpl<$Res>
    extends _$TLUserDataCopyWithImpl<$Res, _$TLUserDataImpl>
    implements _$$TLUserDataImplCopyWith<$Res> {
  __$$TLUserDataImplCopyWithImpl(
      _$TLUserDataImpl _value, $Res Function(_$TLUserDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLUserData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentAppIconName = null,
    Object? selectedCheckBoxIconData = null,
    Object? earnedCheckBoxIcons = null,
  }) {
    return _then(_$TLUserDataImpl(
      currentAppIconName: null == currentAppIconName
          ? _value.currentAppIconName
          : currentAppIconName // ignore: cast_nullable_to_non_nullable
              as String,
      selectedCheckBoxIconData: null == selectedCheckBoxIconData
          ? _value.selectedCheckBoxIconData
          : selectedCheckBoxIconData // ignore: cast_nullable_to_non_nullable
              as SelectedCheckBoxIconData,
      earnedCheckBoxIcons: null == earnedCheckBoxIcons
          ? _value._earnedCheckBoxIcons
          : earnedCheckBoxIcons // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TLUserDataImpl implements _TLUserData {
  const _$TLUserDataImpl(
      {this.currentAppIconName = "Sun Orange",
      this.selectedCheckBoxIconData = const SelectedCheckBoxIconData(
          iconCategory: "Default", iconName: "Box"),
      final Map<String, List<String>> earnedCheckBoxIcons = const {}})
      : _earnedCheckBoxIcons = earnedCheckBoxIcons;

  factory _$TLUserDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TLUserDataImplFromJson(json);

// 現在のアプリアイコンの名前
  @override
  @JsonKey()
  final String currentAppIconName;
// 選択されたチェックボックスのアイコン
  @override
  @JsonKey()
  final SelectedCheckBoxIconData selectedCheckBoxIconData;
// 獲得したチェックボックスのアイコン
  final Map<String, List<String>> _earnedCheckBoxIcons;
// 獲得したチェックボックスのアイコン
  @override
  @JsonKey()
  Map<String, List<String>> get earnedCheckBoxIcons {
    if (_earnedCheckBoxIcons is EqualUnmodifiableMapView)
      return _earnedCheckBoxIcons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_earnedCheckBoxIcons);
  }

  @override
  String toString() {
    return 'TLUserData(currentAppIconName: $currentAppIconName, selectedCheckBoxIconData: $selectedCheckBoxIconData, earnedCheckBoxIcons: $earnedCheckBoxIcons)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TLUserDataImpl &&
            (identical(other.currentAppIconName, currentAppIconName) ||
                other.currentAppIconName == currentAppIconName) &&
            (identical(
                    other.selectedCheckBoxIconData, selectedCheckBoxIconData) ||
                other.selectedCheckBoxIconData == selectedCheckBoxIconData) &&
            const DeepCollectionEquality()
                .equals(other._earnedCheckBoxIcons, _earnedCheckBoxIcons));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentAppIconName,
      selectedCheckBoxIconData,
      const DeepCollectionEquality().hash(_earnedCheckBoxIcons));

  /// Create a copy of TLUserData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TLUserDataImplCopyWith<_$TLUserDataImpl> get copyWith =>
      __$$TLUserDataImplCopyWithImpl<_$TLUserDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TLUserDataImplToJson(
      this,
    );
  }
}

abstract class _TLUserData implements TLUserData {
  const factory _TLUserData(
      {final String currentAppIconName,
      final SelectedCheckBoxIconData selectedCheckBoxIconData,
      final Map<String, List<String>> earnedCheckBoxIcons}) = _$TLUserDataImpl;

  factory _TLUserData.fromJson(Map<String, dynamic> json) =
      _$TLUserDataImpl.fromJson;

// 現在のアプリアイコンの名前
  @override
  String get currentAppIconName; // 選択されたチェックボックスのアイコン
  @override
  SelectedCheckBoxIconData get selectedCheckBoxIconData; // 獲得したチェックボックスのアイコン
  @override
  Map<String, List<String>> get earnedCheckBoxIcons;

  /// Create a copy of TLUserData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TLUserDataImplCopyWith<_$TLUserDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
