// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../theme_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ThemeAction {
  TLThemeType get newThemeType => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TLThemeType newThemeType) changeTheme,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLThemeType newThemeType)? changeTheme,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLThemeType newThemeType)? changeTheme,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangeThemeAction value) changeTheme,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangeThemeAction value)? changeTheme,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangeThemeAction value)? changeTheme,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of ThemeAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ThemeActionCopyWith<ThemeAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeActionCopyWith<$Res> {
  factory $ThemeActionCopyWith(
    ThemeAction value,
    $Res Function(ThemeAction) then,
  ) = _$ThemeActionCopyWithImpl<$Res, ThemeAction>;
  @useResult
  $Res call({TLThemeType newThemeType});
}

/// @nodoc
class _$ThemeActionCopyWithImpl<$Res, $Val extends ThemeAction>
    implements $ThemeActionCopyWith<$Res> {
  _$ThemeActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ThemeAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? newThemeType = null}) {
    return _then(
      _value.copyWith(
            newThemeType:
                null == newThemeType
                    ? _value.newThemeType
                    : newThemeType // ignore: cast_nullable_to_non_nullable
                        as TLThemeType,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChangeThemeActionImplCopyWith<$Res>
    implements $ThemeActionCopyWith<$Res> {
  factory _$$ChangeThemeActionImplCopyWith(
    _$ChangeThemeActionImpl value,
    $Res Function(_$ChangeThemeActionImpl) then,
  ) = __$$ChangeThemeActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TLThemeType newThemeType});
}

/// @nodoc
class __$$ChangeThemeActionImplCopyWithImpl<$Res>
    extends _$ThemeActionCopyWithImpl<$Res, _$ChangeThemeActionImpl>
    implements _$$ChangeThemeActionImplCopyWith<$Res> {
  __$$ChangeThemeActionImplCopyWithImpl(
    _$ChangeThemeActionImpl _value,
    $Res Function(_$ChangeThemeActionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ThemeAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? newThemeType = null}) {
    return _then(
      _$ChangeThemeActionImpl(
        newThemeType:
            null == newThemeType
                ? _value.newThemeType
                : newThemeType // ignore: cast_nullable_to_non_nullable
                    as TLThemeType,
      ),
    );
  }
}

/// @nodoc

class _$ChangeThemeActionImpl implements ChangeThemeAction {
  const _$ChangeThemeActionImpl({required this.newThemeType});

  @override
  final TLThemeType newThemeType;

  @override
  String toString() {
    return 'ThemeAction.changeTheme(newThemeType: $newThemeType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeThemeActionImpl &&
            (identical(other.newThemeType, newThemeType) ||
                other.newThemeType == newThemeType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newThemeType);

  /// Create a copy of ThemeAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeThemeActionImplCopyWith<_$ChangeThemeActionImpl> get copyWith =>
      __$$ChangeThemeActionImplCopyWithImpl<_$ChangeThemeActionImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TLThemeType newThemeType) changeTheme,
  }) {
    return changeTheme(newThemeType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLThemeType newThemeType)? changeTheme,
  }) {
    return changeTheme?.call(newThemeType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLThemeType newThemeType)? changeTheme,
    required TResult orElse(),
  }) {
    if (changeTheme != null) {
      return changeTheme(newThemeType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangeThemeAction value) changeTheme,
  }) {
    return changeTheme(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangeThemeAction value)? changeTheme,
  }) {
    return changeTheme?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangeThemeAction value)? changeTheme,
    required TResult orElse(),
  }) {
    if (changeTheme != null) {
      return changeTheme(this);
    }
    return orElse();
  }
}

abstract class ChangeThemeAction implements ThemeAction {
  const factory ChangeThemeAction({required final TLThemeType newThemeType}) =
      _$ChangeThemeActionImpl;

  @override
  TLThemeType get newThemeType;

  /// Create a copy of ThemeAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangeThemeActionImplCopyWith<_$ChangeThemeActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
