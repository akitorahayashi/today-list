// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../settings_data/tcw_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TCWSettings _$TCWSettingsFromJson(Map<String, dynamic> json) {
  return _TCWSettings.fromJson(json);
}

/// @nodoc
mixin _$TCWSettings {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  TLWorkspace get workspace => throw _privateConstructorUsedError;
  TLToDoCategory? get bigCategory => throw _privateConstructorUsedError;
  TLToDoCategory? get smallCategory => throw _privateConstructorUsedError;

  /// Serializes this TCWSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TCWSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TCWSettingsCopyWith<TCWSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TCWSettingsCopyWith<$Res> {
  factory $TCWSettingsCopyWith(
          TCWSettings value, $Res Function(TCWSettings) then) =
      _$TCWSettingsCopyWithImpl<$Res, TCWSettings>;
  @useResult
  $Res call(
      {String id,
      String title,
      TLWorkspace workspace,
      TLToDoCategory? bigCategory,
      TLToDoCategory? smallCategory});

  $TLWorkspaceCopyWith<$Res> get workspace;
  $TLToDoCategoryCopyWith<$Res>? get bigCategory;
  $TLToDoCategoryCopyWith<$Res>? get smallCategory;
}

/// @nodoc
class _$TCWSettingsCopyWithImpl<$Res, $Val extends TCWSettings>
    implements $TCWSettingsCopyWith<$Res> {
  _$TCWSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TCWSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? workspace = null,
    Object? bigCategory = freezed,
    Object? smallCategory = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      workspace: null == workspace
          ? _value.workspace
          : workspace // ignore: cast_nullable_to_non_nullable
              as TLWorkspace,
      bigCategory: freezed == bigCategory
          ? _value.bigCategory
          : bigCategory // ignore: cast_nullable_to_non_nullable
              as TLToDoCategory?,
      smallCategory: freezed == smallCategory
          ? _value.smallCategory
          : smallCategory // ignore: cast_nullable_to_non_nullable
              as TLToDoCategory?,
    ) as $Val);
  }

  /// Create a copy of TCWSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLWorkspaceCopyWith<$Res> get workspace {
    return $TLWorkspaceCopyWith<$Res>(_value.workspace, (value) {
      return _then(_value.copyWith(workspace: value) as $Val);
    });
  }

  /// Create a copy of TCWSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLToDoCategoryCopyWith<$Res>? get bigCategory {
    if (_value.bigCategory == null) {
      return null;
    }

    return $TLToDoCategoryCopyWith<$Res>(_value.bigCategory!, (value) {
      return _then(_value.copyWith(bigCategory: value) as $Val);
    });
  }

  /// Create a copy of TCWSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLToDoCategoryCopyWith<$Res>? get smallCategory {
    if (_value.smallCategory == null) {
      return null;
    }

    return $TLToDoCategoryCopyWith<$Res>(_value.smallCategory!, (value) {
      return _then(_value.copyWith(smallCategory: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TCWSettingsImplCopyWith<$Res>
    implements $TCWSettingsCopyWith<$Res> {
  factory _$$TCWSettingsImplCopyWith(
          _$TCWSettingsImpl value, $Res Function(_$TCWSettingsImpl) then) =
      __$$TCWSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      TLWorkspace workspace,
      TLToDoCategory? bigCategory,
      TLToDoCategory? smallCategory});

  @override
  $TLWorkspaceCopyWith<$Res> get workspace;
  @override
  $TLToDoCategoryCopyWith<$Res>? get bigCategory;
  @override
  $TLToDoCategoryCopyWith<$Res>? get smallCategory;
}

/// @nodoc
class __$$TCWSettingsImplCopyWithImpl<$Res>
    extends _$TCWSettingsCopyWithImpl<$Res, _$TCWSettingsImpl>
    implements _$$TCWSettingsImplCopyWith<$Res> {
  __$$TCWSettingsImplCopyWithImpl(
      _$TCWSettingsImpl _value, $Res Function(_$TCWSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of TCWSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? workspace = null,
    Object? bigCategory = freezed,
    Object? smallCategory = freezed,
  }) {
    return _then(_$TCWSettingsImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      workspace: null == workspace
          ? _value.workspace
          : workspace // ignore: cast_nullable_to_non_nullable
              as TLWorkspace,
      bigCategory: freezed == bigCategory
          ? _value.bigCategory
          : bigCategory // ignore: cast_nullable_to_non_nullable
              as TLToDoCategory?,
      smallCategory: freezed == smallCategory
          ? _value.smallCategory
          : smallCategory // ignore: cast_nullable_to_non_nullable
              as TLToDoCategory?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TCWSettingsImpl implements _TCWSettings {
  const _$TCWSettingsImpl(
      {required this.id,
      required this.title,
      required this.workspace,
      required this.bigCategory,
      required this.smallCategory});

  factory _$TCWSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TCWSettingsImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final TLWorkspace workspace;
  @override
  final TLToDoCategory? bigCategory;
  @override
  final TLToDoCategory? smallCategory;

  @override
  String toString() {
    return 'TCWSettings(id: $id, title: $title, workspace: $workspace, bigCategory: $bigCategory, smallCategory: $smallCategory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TCWSettingsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.workspace, workspace) ||
                other.workspace == workspace) &&
            (identical(other.bigCategory, bigCategory) ||
                other.bigCategory == bigCategory) &&
            (identical(other.smallCategory, smallCategory) ||
                other.smallCategory == smallCategory));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, workspace, bigCategory, smallCategory);

  /// Create a copy of TCWSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TCWSettingsImplCopyWith<_$TCWSettingsImpl> get copyWith =>
      __$$TCWSettingsImplCopyWithImpl<_$TCWSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TCWSettingsImplToJson(
      this,
    );
  }
}

abstract class _TCWSettings implements TCWSettings {
  const factory _TCWSettings(
      {required final String id,
      required final String title,
      required final TLWorkspace workspace,
      required final TLToDoCategory? bigCategory,
      required final TLToDoCategory? smallCategory}) = _$TCWSettingsImpl;

  factory _TCWSettings.fromJson(Map<String, dynamic> json) =
      _$TCWSettingsImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  TLWorkspace get workspace;
  @override
  TLToDoCategory? get bigCategory;
  @override
  TLToDoCategory? get smallCategory;

  /// Create a copy of TCWSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TCWSettingsImplCopyWith<_$TCWSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
