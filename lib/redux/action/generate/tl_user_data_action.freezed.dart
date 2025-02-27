// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../tl_user_data_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TLUserDataAction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String newThemeName) updateCurrentAppIconName,
    required TResult Function(SelectedCheckBoxIconData newCheckBox)
        updateSelectedCheckBoxIcon,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String newThemeName)? updateCurrentAppIconName,
    TResult? Function(SelectedCheckBoxIconData newCheckBox)?
        updateSelectedCheckBoxIcon,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String newThemeName)? updateCurrentAppIconName,
    TResult Function(SelectedCheckBoxIconData newCheckBox)?
        updateSelectedCheckBoxIcon,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdateCurrentAppIconType value)
        updateCurrentAppIconName,
    required TResult Function(_UpdateSelectedCheckBoxIcon value)
        updateSelectedCheckBoxIcon,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UpdateCurrentAppIconType value)?
        updateCurrentAppIconName,
    TResult? Function(_UpdateSelectedCheckBoxIcon value)?
        updateSelectedCheckBoxIcon,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdateCurrentAppIconType value)? updateCurrentAppIconName,
    TResult Function(_UpdateSelectedCheckBoxIcon value)?
        updateSelectedCheckBoxIcon,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TLUserDataActionCopyWith<$Res> {
  factory $TLUserDataActionCopyWith(
          TLUserDataAction value, $Res Function(TLUserDataAction) then) =
      _$TLUserDataActionCopyWithImpl<$Res, TLUserDataAction>;
}

/// @nodoc
class _$TLUserDataActionCopyWithImpl<$Res, $Val extends TLUserDataAction>
    implements $TLUserDataActionCopyWith<$Res> {
  _$TLUserDataActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TLUserDataAction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$UpdateCurrentAppIconTypeImplCopyWith<$Res> {
  factory _$$UpdateCurrentAppIconTypeImplCopyWith(
          _$UpdateCurrentAppIconTypeImpl value,
          $Res Function(_$UpdateCurrentAppIconTypeImpl) then) =
      __$$UpdateCurrentAppIconTypeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String newThemeName});
}

/// @nodoc
class __$$UpdateCurrentAppIconTypeImplCopyWithImpl<$Res>
    extends _$TLUserDataActionCopyWithImpl<$Res, _$UpdateCurrentAppIconTypeImpl>
    implements _$$UpdateCurrentAppIconTypeImplCopyWith<$Res> {
  __$$UpdateCurrentAppIconTypeImplCopyWithImpl(
      _$UpdateCurrentAppIconTypeImpl _value,
      $Res Function(_$UpdateCurrentAppIconTypeImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLUserDataAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newThemeName = null,
  }) {
    return _then(_$UpdateCurrentAppIconTypeImpl(
      newThemeName: null == newThemeName
          ? _value.newThemeName
          : newThemeName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UpdateCurrentAppIconTypeImpl implements _UpdateCurrentAppIconType {
  const _$UpdateCurrentAppIconTypeImpl({required this.newThemeName});

  @override
  final String newThemeName;

  @override
  String toString() {
    return 'TLUserDataAction.updateCurrentAppIconName(newThemeName: $newThemeName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateCurrentAppIconTypeImpl &&
            (identical(other.newThemeName, newThemeName) ||
                other.newThemeName == newThemeName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newThemeName);

  /// Create a copy of TLUserDataAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateCurrentAppIconTypeImplCopyWith<_$UpdateCurrentAppIconTypeImpl>
      get copyWith => __$$UpdateCurrentAppIconTypeImplCopyWithImpl<
          _$UpdateCurrentAppIconTypeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String newThemeName) updateCurrentAppIconName,
    required TResult Function(SelectedCheckBoxIconData newCheckBox)
        updateSelectedCheckBoxIcon,
  }) {
    return updateCurrentAppIconName(newThemeName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String newThemeName)? updateCurrentAppIconName,
    TResult? Function(SelectedCheckBoxIconData newCheckBox)?
        updateSelectedCheckBoxIcon,
  }) {
    return updateCurrentAppIconName?.call(newThemeName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String newThemeName)? updateCurrentAppIconName,
    TResult Function(SelectedCheckBoxIconData newCheckBox)?
        updateSelectedCheckBoxIcon,
    required TResult orElse(),
  }) {
    if (updateCurrentAppIconName != null) {
      return updateCurrentAppIconName(newThemeName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdateCurrentAppIconType value)
        updateCurrentAppIconName,
    required TResult Function(_UpdateSelectedCheckBoxIcon value)
        updateSelectedCheckBoxIcon,
  }) {
    return updateCurrentAppIconName(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UpdateCurrentAppIconType value)?
        updateCurrentAppIconName,
    TResult? Function(_UpdateSelectedCheckBoxIcon value)?
        updateSelectedCheckBoxIcon,
  }) {
    return updateCurrentAppIconName?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdateCurrentAppIconType value)? updateCurrentAppIconName,
    TResult Function(_UpdateSelectedCheckBoxIcon value)?
        updateSelectedCheckBoxIcon,
    required TResult orElse(),
  }) {
    if (updateCurrentAppIconName != null) {
      return updateCurrentAppIconName(this);
    }
    return orElse();
  }
}

abstract class _UpdateCurrentAppIconType implements TLUserDataAction {
  const factory _UpdateCurrentAppIconType(
      {required final String newThemeName}) = _$UpdateCurrentAppIconTypeImpl;

  String get newThemeName;

  /// Create a copy of TLUserDataAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateCurrentAppIconTypeImplCopyWith<_$UpdateCurrentAppIconTypeImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateSelectedCheckBoxIconImplCopyWith<$Res> {
  factory _$$UpdateSelectedCheckBoxIconImplCopyWith(
          _$UpdateSelectedCheckBoxIconImpl value,
          $Res Function(_$UpdateSelectedCheckBoxIconImpl) then) =
      __$$UpdateSelectedCheckBoxIconImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SelectedCheckBoxIconData newCheckBox});

  $SelectedCheckBoxIconDataCopyWith<$Res> get newCheckBox;
}

/// @nodoc
class __$$UpdateSelectedCheckBoxIconImplCopyWithImpl<$Res>
    extends _$TLUserDataActionCopyWithImpl<$Res,
        _$UpdateSelectedCheckBoxIconImpl>
    implements _$$UpdateSelectedCheckBoxIconImplCopyWith<$Res> {
  __$$UpdateSelectedCheckBoxIconImplCopyWithImpl(
      _$UpdateSelectedCheckBoxIconImpl _value,
      $Res Function(_$UpdateSelectedCheckBoxIconImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLUserDataAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newCheckBox = null,
  }) {
    return _then(_$UpdateSelectedCheckBoxIconImpl(
      newCheckBox: null == newCheckBox
          ? _value.newCheckBox
          : newCheckBox // ignore: cast_nullable_to_non_nullable
              as SelectedCheckBoxIconData,
    ));
  }

  /// Create a copy of TLUserDataAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SelectedCheckBoxIconDataCopyWith<$Res> get newCheckBox {
    return $SelectedCheckBoxIconDataCopyWith<$Res>(_value.newCheckBox, (value) {
      return _then(_value.copyWith(newCheckBox: value));
    });
  }
}

/// @nodoc

class _$UpdateSelectedCheckBoxIconImpl implements _UpdateSelectedCheckBoxIcon {
  const _$UpdateSelectedCheckBoxIconImpl({required this.newCheckBox});

  @override
  final SelectedCheckBoxIconData newCheckBox;

  @override
  String toString() {
    return 'TLUserDataAction.updateSelectedCheckBoxIcon(newCheckBox: $newCheckBox)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateSelectedCheckBoxIconImpl &&
            (identical(other.newCheckBox, newCheckBox) ||
                other.newCheckBox == newCheckBox));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newCheckBox);

  /// Create a copy of TLUserDataAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateSelectedCheckBoxIconImplCopyWith<_$UpdateSelectedCheckBoxIconImpl>
      get copyWith => __$$UpdateSelectedCheckBoxIconImplCopyWithImpl<
          _$UpdateSelectedCheckBoxIconImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String newThemeName) updateCurrentAppIconName,
    required TResult Function(SelectedCheckBoxIconData newCheckBox)
        updateSelectedCheckBoxIcon,
  }) {
    return updateSelectedCheckBoxIcon(newCheckBox);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String newThemeName)? updateCurrentAppIconName,
    TResult? Function(SelectedCheckBoxIconData newCheckBox)?
        updateSelectedCheckBoxIcon,
  }) {
    return updateSelectedCheckBoxIcon?.call(newCheckBox);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String newThemeName)? updateCurrentAppIconName,
    TResult Function(SelectedCheckBoxIconData newCheckBox)?
        updateSelectedCheckBoxIcon,
    required TResult orElse(),
  }) {
    if (updateSelectedCheckBoxIcon != null) {
      return updateSelectedCheckBoxIcon(newCheckBox);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdateCurrentAppIconType value)
        updateCurrentAppIconName,
    required TResult Function(_UpdateSelectedCheckBoxIcon value)
        updateSelectedCheckBoxIcon,
  }) {
    return updateSelectedCheckBoxIcon(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UpdateCurrentAppIconType value)?
        updateCurrentAppIconName,
    TResult? Function(_UpdateSelectedCheckBoxIcon value)?
        updateSelectedCheckBoxIcon,
  }) {
    return updateSelectedCheckBoxIcon?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdateCurrentAppIconType value)? updateCurrentAppIconName,
    TResult Function(_UpdateSelectedCheckBoxIcon value)?
        updateSelectedCheckBoxIcon,
    required TResult orElse(),
  }) {
    if (updateSelectedCheckBoxIcon != null) {
      return updateSelectedCheckBoxIcon(this);
    }
    return orElse();
  }
}

abstract class _UpdateSelectedCheckBoxIcon implements TLUserDataAction {
  const factory _UpdateSelectedCheckBoxIcon(
          {required final SelectedCheckBoxIconData newCheckBox}) =
      _$UpdateSelectedCheckBoxIconImpl;

  SelectedCheckBoxIconData get newCheckBox;

  /// Create a copy of TLUserDataAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateSelectedCheckBoxIconImplCopyWith<_$UpdateSelectedCheckBoxIconImpl>
      get copyWith => throw _privateConstructorUsedError;
}
