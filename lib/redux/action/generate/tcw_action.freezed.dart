// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../tcw_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TCWSettingsAction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TCWSettings newSettings) addTCWSetting,
    required TResult Function(String id) removeTCWSetting,
    required TResult Function(List<TCWSettings> updatedList)
        updateTCWSettingsList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TCWSettings newSettings)? addTCWSetting,
    TResult? Function(String id)? removeTCWSetting,
    TResult? Function(List<TCWSettings> updatedList)? updateTCWSettingsList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TCWSettings newSettings)? addTCWSetting,
    TResult Function(String id)? removeTCWSetting,
    TResult Function(List<TCWSettings> updatedList)? updateTCWSettingsList,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddTCWSetting value) addTCWSetting,
    required TResult Function(_RemoveTCWSetting value) removeTCWSetting,
    required TResult Function(_UpdateTCWSettingsList value)
        updateTCWSettingsList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddTCWSetting value)? addTCWSetting,
    TResult? Function(_RemoveTCWSetting value)? removeTCWSetting,
    TResult? Function(_UpdateTCWSettingsList value)? updateTCWSettingsList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddTCWSetting value)? addTCWSetting,
    TResult Function(_RemoveTCWSetting value)? removeTCWSetting,
    TResult Function(_UpdateTCWSettingsList value)? updateTCWSettingsList,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TCWSettingsActionCopyWith<$Res> {
  factory $TCWSettingsActionCopyWith(
          TCWSettingsAction value, $Res Function(TCWSettingsAction) then) =
      _$TCWSettingsActionCopyWithImpl<$Res, TCWSettingsAction>;
}

/// @nodoc
class _$TCWSettingsActionCopyWithImpl<$Res, $Val extends TCWSettingsAction>
    implements $TCWSettingsActionCopyWith<$Res> {
  _$TCWSettingsActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TCWSettingsAction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AddTCWSettingImplCopyWith<$Res> {
  factory _$$AddTCWSettingImplCopyWith(
          _$AddTCWSettingImpl value, $Res Function(_$AddTCWSettingImpl) then) =
      __$$AddTCWSettingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TCWSettings newSettings});

  $TCWSettingsCopyWith<$Res> get newSettings;
}

/// @nodoc
class __$$AddTCWSettingImplCopyWithImpl<$Res>
    extends _$TCWSettingsActionCopyWithImpl<$Res, _$AddTCWSettingImpl>
    implements _$$AddTCWSettingImplCopyWith<$Res> {
  __$$AddTCWSettingImplCopyWithImpl(
      _$AddTCWSettingImpl _value, $Res Function(_$AddTCWSettingImpl) _then)
      : super(_value, _then);

  /// Create a copy of TCWSettingsAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newSettings = null,
  }) {
    return _then(_$AddTCWSettingImpl(
      newSettings: null == newSettings
          ? _value.newSettings
          : newSettings // ignore: cast_nullable_to_non_nullable
              as TCWSettings,
    ));
  }

  /// Create a copy of TCWSettingsAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TCWSettingsCopyWith<$Res> get newSettings {
    return $TCWSettingsCopyWith<$Res>(_value.newSettings, (value) {
      return _then(_value.copyWith(newSettings: value));
    });
  }
}

/// @nodoc

class _$AddTCWSettingImpl implements _AddTCWSetting {
  const _$AddTCWSettingImpl({required this.newSettings});

  @override
  final TCWSettings newSettings;

  @override
  String toString() {
    return 'TCWSettingsAction.addTCWSetting(newSettings: $newSettings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddTCWSettingImpl &&
            (identical(other.newSettings, newSettings) ||
                other.newSettings == newSettings));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newSettings);

  /// Create a copy of TCWSettingsAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddTCWSettingImplCopyWith<_$AddTCWSettingImpl> get copyWith =>
      __$$AddTCWSettingImplCopyWithImpl<_$AddTCWSettingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TCWSettings newSettings) addTCWSetting,
    required TResult Function(String id) removeTCWSetting,
    required TResult Function(List<TCWSettings> updatedList)
        updateTCWSettingsList,
  }) {
    return addTCWSetting(newSettings);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TCWSettings newSettings)? addTCWSetting,
    TResult? Function(String id)? removeTCWSetting,
    TResult? Function(List<TCWSettings> updatedList)? updateTCWSettingsList,
  }) {
    return addTCWSetting?.call(newSettings);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TCWSettings newSettings)? addTCWSetting,
    TResult Function(String id)? removeTCWSetting,
    TResult Function(List<TCWSettings> updatedList)? updateTCWSettingsList,
    required TResult orElse(),
  }) {
    if (addTCWSetting != null) {
      return addTCWSetting(newSettings);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddTCWSetting value) addTCWSetting,
    required TResult Function(_RemoveTCWSetting value) removeTCWSetting,
    required TResult Function(_UpdateTCWSettingsList value)
        updateTCWSettingsList,
  }) {
    return addTCWSetting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddTCWSetting value)? addTCWSetting,
    TResult? Function(_RemoveTCWSetting value)? removeTCWSetting,
    TResult? Function(_UpdateTCWSettingsList value)? updateTCWSettingsList,
  }) {
    return addTCWSetting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddTCWSetting value)? addTCWSetting,
    TResult Function(_RemoveTCWSetting value)? removeTCWSetting,
    TResult Function(_UpdateTCWSettingsList value)? updateTCWSettingsList,
    required TResult orElse(),
  }) {
    if (addTCWSetting != null) {
      return addTCWSetting(this);
    }
    return orElse();
  }
}

abstract class _AddTCWSetting implements TCWSettingsAction {
  const factory _AddTCWSetting({required final TCWSettings newSettings}) =
      _$AddTCWSettingImpl;

  TCWSettings get newSettings;

  /// Create a copy of TCWSettingsAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddTCWSettingImplCopyWith<_$AddTCWSettingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveTCWSettingImplCopyWith<$Res> {
  factory _$$RemoveTCWSettingImplCopyWith(_$RemoveTCWSettingImpl value,
          $Res Function(_$RemoveTCWSettingImpl) then) =
      __$$RemoveTCWSettingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$RemoveTCWSettingImplCopyWithImpl<$Res>
    extends _$TCWSettingsActionCopyWithImpl<$Res, _$RemoveTCWSettingImpl>
    implements _$$RemoveTCWSettingImplCopyWith<$Res> {
  __$$RemoveTCWSettingImplCopyWithImpl(_$RemoveTCWSettingImpl _value,
      $Res Function(_$RemoveTCWSettingImpl) _then)
      : super(_value, _then);

  /// Create a copy of TCWSettingsAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$RemoveTCWSettingImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RemoveTCWSettingImpl implements _RemoveTCWSetting {
  const _$RemoveTCWSettingImpl({required this.id});

  @override
  final String id;

  @override
  String toString() {
    return 'TCWSettingsAction.removeTCWSetting(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveTCWSettingImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of TCWSettingsAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveTCWSettingImplCopyWith<_$RemoveTCWSettingImpl> get copyWith =>
      __$$RemoveTCWSettingImplCopyWithImpl<_$RemoveTCWSettingImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TCWSettings newSettings) addTCWSetting,
    required TResult Function(String id) removeTCWSetting,
    required TResult Function(List<TCWSettings> updatedList)
        updateTCWSettingsList,
  }) {
    return removeTCWSetting(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TCWSettings newSettings)? addTCWSetting,
    TResult? Function(String id)? removeTCWSetting,
    TResult? Function(List<TCWSettings> updatedList)? updateTCWSettingsList,
  }) {
    return removeTCWSetting?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TCWSettings newSettings)? addTCWSetting,
    TResult Function(String id)? removeTCWSetting,
    TResult Function(List<TCWSettings> updatedList)? updateTCWSettingsList,
    required TResult orElse(),
  }) {
    if (removeTCWSetting != null) {
      return removeTCWSetting(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddTCWSetting value) addTCWSetting,
    required TResult Function(_RemoveTCWSetting value) removeTCWSetting,
    required TResult Function(_UpdateTCWSettingsList value)
        updateTCWSettingsList,
  }) {
    return removeTCWSetting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddTCWSetting value)? addTCWSetting,
    TResult? Function(_RemoveTCWSetting value)? removeTCWSetting,
    TResult? Function(_UpdateTCWSettingsList value)? updateTCWSettingsList,
  }) {
    return removeTCWSetting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddTCWSetting value)? addTCWSetting,
    TResult Function(_RemoveTCWSetting value)? removeTCWSetting,
    TResult Function(_UpdateTCWSettingsList value)? updateTCWSettingsList,
    required TResult orElse(),
  }) {
    if (removeTCWSetting != null) {
      return removeTCWSetting(this);
    }
    return orElse();
  }
}

abstract class _RemoveTCWSetting implements TCWSettingsAction {
  const factory _RemoveTCWSetting({required final String id}) =
      _$RemoveTCWSettingImpl;

  String get id;

  /// Create a copy of TCWSettingsAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveTCWSettingImplCopyWith<_$RemoveTCWSettingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateTCWSettingsListImplCopyWith<$Res> {
  factory _$$UpdateTCWSettingsListImplCopyWith(
          _$UpdateTCWSettingsListImpl value,
          $Res Function(_$UpdateTCWSettingsListImpl) then) =
      __$$UpdateTCWSettingsListImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<TCWSettings> updatedList});
}

/// @nodoc
class __$$UpdateTCWSettingsListImplCopyWithImpl<$Res>
    extends _$TCWSettingsActionCopyWithImpl<$Res, _$UpdateTCWSettingsListImpl>
    implements _$$UpdateTCWSettingsListImplCopyWith<$Res> {
  __$$UpdateTCWSettingsListImplCopyWithImpl(_$UpdateTCWSettingsListImpl _value,
      $Res Function(_$UpdateTCWSettingsListImpl) _then)
      : super(_value, _then);

  /// Create a copy of TCWSettingsAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updatedList = null,
  }) {
    return _then(_$UpdateTCWSettingsListImpl(
      updatedList: null == updatedList
          ? _value._updatedList
          : updatedList // ignore: cast_nullable_to_non_nullable
              as List<TCWSettings>,
    ));
  }
}

/// @nodoc

class _$UpdateTCWSettingsListImpl implements _UpdateTCWSettingsList {
  const _$UpdateTCWSettingsListImpl(
      {required final List<TCWSettings> updatedList})
      : _updatedList = updatedList;

  final List<TCWSettings> _updatedList;
  @override
  List<TCWSettings> get updatedList {
    if (_updatedList is EqualUnmodifiableListView) return _updatedList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_updatedList);
  }

  @override
  String toString() {
    return 'TCWSettingsAction.updateTCWSettingsList(updatedList: $updatedList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateTCWSettingsListImpl &&
            const DeepCollectionEquality()
                .equals(other._updatedList, _updatedList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_updatedList));

  /// Create a copy of TCWSettingsAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateTCWSettingsListImplCopyWith<_$UpdateTCWSettingsListImpl>
      get copyWith => __$$UpdateTCWSettingsListImplCopyWithImpl<
          _$UpdateTCWSettingsListImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TCWSettings newSettings) addTCWSetting,
    required TResult Function(String id) removeTCWSetting,
    required TResult Function(List<TCWSettings> updatedList)
        updateTCWSettingsList,
  }) {
    return updateTCWSettingsList(updatedList);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TCWSettings newSettings)? addTCWSetting,
    TResult? Function(String id)? removeTCWSetting,
    TResult? Function(List<TCWSettings> updatedList)? updateTCWSettingsList,
  }) {
    return updateTCWSettingsList?.call(updatedList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TCWSettings newSettings)? addTCWSetting,
    TResult Function(String id)? removeTCWSetting,
    TResult Function(List<TCWSettings> updatedList)? updateTCWSettingsList,
    required TResult orElse(),
  }) {
    if (updateTCWSettingsList != null) {
      return updateTCWSettingsList(updatedList);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddTCWSetting value) addTCWSetting,
    required TResult Function(_RemoveTCWSetting value) removeTCWSetting,
    required TResult Function(_UpdateTCWSettingsList value)
        updateTCWSettingsList,
  }) {
    return updateTCWSettingsList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddTCWSetting value)? addTCWSetting,
    TResult? Function(_RemoveTCWSetting value)? removeTCWSetting,
    TResult? Function(_UpdateTCWSettingsList value)? updateTCWSettingsList,
  }) {
    return updateTCWSettingsList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddTCWSetting value)? addTCWSetting,
    TResult Function(_RemoveTCWSetting value)? removeTCWSetting,
    TResult Function(_UpdateTCWSettingsList value)? updateTCWSettingsList,
    required TResult orElse(),
  }) {
    if (updateTCWSettingsList != null) {
      return updateTCWSettingsList(this);
    }
    return orElse();
  }
}

abstract class _UpdateTCWSettingsList implements TCWSettingsAction {
  const factory _UpdateTCWSettingsList(
          {required final List<TCWSettings> updatedList}) =
      _$UpdateTCWSettingsListImpl;

  List<TCWSettings> get updatedList;

  /// Create a copy of TCWSettingsAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateTCWSettingsListImplCopyWith<_$UpdateTCWSettingsListImpl>
      get copyWith => throw _privateConstructorUsedError;
}
