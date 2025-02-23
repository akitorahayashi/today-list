// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../tl_todo_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TLToDoAction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TLToDo newToDo) addToDo,
    required TResult Function(TLToDo newToDo) updateToDo,
    required TResult Function(TLToDo corrToDo) removeToDo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLToDo newToDo)? addToDo,
    TResult? Function(TLToDo newToDo)? updateToDo,
    TResult? Function(TLToDo corrToDo)? removeToDo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLToDo newToDo)? addToDo,
    TResult Function(TLToDo newToDo)? updateToDo,
    TResult Function(TLToDo corrToDo)? removeToDo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddToDo value) addToDo,
    required TResult Function(_UpdateToDo value) updateToDo,
    required TResult Function(_RemoveToDo value) removeToDo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddToDo value)? addToDo,
    TResult? Function(_UpdateToDo value)? updateToDo,
    TResult? Function(_RemoveToDo value)? removeToDo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddToDo value)? addToDo,
    TResult Function(_UpdateToDo value)? updateToDo,
    TResult Function(_RemoveToDo value)? removeToDo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TLToDoActionCopyWith<$Res> {
  factory $TLToDoActionCopyWith(
          TLToDoAction value, $Res Function(TLToDoAction) then) =
      _$TLToDoActionCopyWithImpl<$Res, TLToDoAction>;
}

/// @nodoc
class _$TLToDoActionCopyWithImpl<$Res, $Val extends TLToDoAction>
    implements $TLToDoActionCopyWith<$Res> {
  _$TLToDoActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AddToDoImplCopyWith<$Res> {
  factory _$$AddToDoImplCopyWith(
          _$AddToDoImpl value, $Res Function(_$AddToDoImpl) then) =
      __$$AddToDoImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TLToDo newToDo});

  $TLToDoCopyWith<$Res> get newToDo;
}

/// @nodoc
class __$$AddToDoImplCopyWithImpl<$Res>
    extends _$TLToDoActionCopyWithImpl<$Res, _$AddToDoImpl>
    implements _$$AddToDoImplCopyWith<$Res> {
  __$$AddToDoImplCopyWithImpl(
      _$AddToDoImpl _value, $Res Function(_$AddToDoImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newToDo = null,
  }) {
    return _then(_$AddToDoImpl(
      newToDo: null == newToDo
          ? _value.newToDo
          : newToDo // ignore: cast_nullable_to_non_nullable
              as TLToDo,
    ));
  }

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLToDoCopyWith<$Res> get newToDo {
    return $TLToDoCopyWith<$Res>(_value.newToDo, (value) {
      return _then(_value.copyWith(newToDo: value));
    });
  }
}

/// @nodoc

class _$AddToDoImpl implements _AddToDo {
  const _$AddToDoImpl({required this.newToDo});

  @override
  final TLToDo newToDo;

  @override
  String toString() {
    return 'TLToDoAction.addToDo(newToDo: $newToDo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddToDoImpl &&
            (identical(other.newToDo, newToDo) || other.newToDo == newToDo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newToDo);

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddToDoImplCopyWith<_$AddToDoImpl> get copyWith =>
      __$$AddToDoImplCopyWithImpl<_$AddToDoImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TLToDo newToDo) addToDo,
    required TResult Function(TLToDo newToDo) updateToDo,
    required TResult Function(TLToDo corrToDo) removeToDo,
  }) {
    return addToDo(newToDo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLToDo newToDo)? addToDo,
    TResult? Function(TLToDo newToDo)? updateToDo,
    TResult? Function(TLToDo corrToDo)? removeToDo,
  }) {
    return addToDo?.call(newToDo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLToDo newToDo)? addToDo,
    TResult Function(TLToDo newToDo)? updateToDo,
    TResult Function(TLToDo corrToDo)? removeToDo,
    required TResult orElse(),
  }) {
    if (addToDo != null) {
      return addToDo(newToDo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddToDo value) addToDo,
    required TResult Function(_UpdateToDo value) updateToDo,
    required TResult Function(_RemoveToDo value) removeToDo,
  }) {
    return addToDo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddToDo value)? addToDo,
    TResult? Function(_UpdateToDo value)? updateToDo,
    TResult? Function(_RemoveToDo value)? removeToDo,
  }) {
    return addToDo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddToDo value)? addToDo,
    TResult Function(_UpdateToDo value)? updateToDo,
    TResult Function(_RemoveToDo value)? removeToDo,
    required TResult orElse(),
  }) {
    if (addToDo != null) {
      return addToDo(this);
    }
    return orElse();
  }
}

abstract class _AddToDo implements TLToDoAction {
  const factory _AddToDo({required final TLToDo newToDo}) = _$AddToDoImpl;

  TLToDo get newToDo;

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddToDoImplCopyWith<_$AddToDoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateToDoImplCopyWith<$Res> {
  factory _$$UpdateToDoImplCopyWith(
          _$UpdateToDoImpl value, $Res Function(_$UpdateToDoImpl) then) =
      __$$UpdateToDoImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TLToDo newToDo});

  $TLToDoCopyWith<$Res> get newToDo;
}

/// @nodoc
class __$$UpdateToDoImplCopyWithImpl<$Res>
    extends _$TLToDoActionCopyWithImpl<$Res, _$UpdateToDoImpl>
    implements _$$UpdateToDoImplCopyWith<$Res> {
  __$$UpdateToDoImplCopyWithImpl(
      _$UpdateToDoImpl _value, $Res Function(_$UpdateToDoImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newToDo = null,
  }) {
    return _then(_$UpdateToDoImpl(
      newToDo: null == newToDo
          ? _value.newToDo
          : newToDo // ignore: cast_nullable_to_non_nullable
              as TLToDo,
    ));
  }

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLToDoCopyWith<$Res> get newToDo {
    return $TLToDoCopyWith<$Res>(_value.newToDo, (value) {
      return _then(_value.copyWith(newToDo: value));
    });
  }
}

/// @nodoc

class _$UpdateToDoImpl implements _UpdateToDo {
  const _$UpdateToDoImpl({required this.newToDo});

  @override
  final TLToDo newToDo;

  @override
  String toString() {
    return 'TLToDoAction.updateToDo(newToDo: $newToDo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateToDoImpl &&
            (identical(other.newToDo, newToDo) || other.newToDo == newToDo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newToDo);

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateToDoImplCopyWith<_$UpdateToDoImpl> get copyWith =>
      __$$UpdateToDoImplCopyWithImpl<_$UpdateToDoImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TLToDo newToDo) addToDo,
    required TResult Function(TLToDo newToDo) updateToDo,
    required TResult Function(TLToDo corrToDo) removeToDo,
  }) {
    return updateToDo(newToDo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLToDo newToDo)? addToDo,
    TResult? Function(TLToDo newToDo)? updateToDo,
    TResult? Function(TLToDo corrToDo)? removeToDo,
  }) {
    return updateToDo?.call(newToDo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLToDo newToDo)? addToDo,
    TResult Function(TLToDo newToDo)? updateToDo,
    TResult Function(TLToDo corrToDo)? removeToDo,
    required TResult orElse(),
  }) {
    if (updateToDo != null) {
      return updateToDo(newToDo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddToDo value) addToDo,
    required TResult Function(_UpdateToDo value) updateToDo,
    required TResult Function(_RemoveToDo value) removeToDo,
  }) {
    return updateToDo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddToDo value)? addToDo,
    TResult? Function(_UpdateToDo value)? updateToDo,
    TResult? Function(_RemoveToDo value)? removeToDo,
  }) {
    return updateToDo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddToDo value)? addToDo,
    TResult Function(_UpdateToDo value)? updateToDo,
    TResult Function(_RemoveToDo value)? removeToDo,
    required TResult orElse(),
  }) {
    if (updateToDo != null) {
      return updateToDo(this);
    }
    return orElse();
  }
}

abstract class _UpdateToDo implements TLToDoAction {
  const factory _UpdateToDo({required final TLToDo newToDo}) = _$UpdateToDoImpl;

  TLToDo get newToDo;

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateToDoImplCopyWith<_$UpdateToDoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveToDoImplCopyWith<$Res> {
  factory _$$RemoveToDoImplCopyWith(
          _$RemoveToDoImpl value, $Res Function(_$RemoveToDoImpl) then) =
      __$$RemoveToDoImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TLToDo corrToDo});

  $TLToDoCopyWith<$Res> get corrToDo;
}

/// @nodoc
class __$$RemoveToDoImplCopyWithImpl<$Res>
    extends _$TLToDoActionCopyWithImpl<$Res, _$RemoveToDoImpl>
    implements _$$RemoveToDoImplCopyWith<$Res> {
  __$$RemoveToDoImplCopyWithImpl(
      _$RemoveToDoImpl _value, $Res Function(_$RemoveToDoImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? corrToDo = null,
  }) {
    return _then(_$RemoveToDoImpl(
      corrToDo: null == corrToDo
          ? _value.corrToDo
          : corrToDo // ignore: cast_nullable_to_non_nullable
              as TLToDo,
    ));
  }

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLToDoCopyWith<$Res> get corrToDo {
    return $TLToDoCopyWith<$Res>(_value.corrToDo, (value) {
      return _then(_value.copyWith(corrToDo: value));
    });
  }
}

/// @nodoc

class _$RemoveToDoImpl implements _RemoveToDo {
  const _$RemoveToDoImpl({required this.corrToDo});

  @override
  final TLToDo corrToDo;

  @override
  String toString() {
    return 'TLToDoAction.removeToDo(corrToDo: $corrToDo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveToDoImpl &&
            (identical(other.corrToDo, corrToDo) ||
                other.corrToDo == corrToDo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, corrToDo);

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveToDoImplCopyWith<_$RemoveToDoImpl> get copyWith =>
      __$$RemoveToDoImplCopyWithImpl<_$RemoveToDoImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TLToDo newToDo) addToDo,
    required TResult Function(TLToDo newToDo) updateToDo,
    required TResult Function(TLToDo corrToDo) removeToDo,
  }) {
    return removeToDo(corrToDo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLToDo newToDo)? addToDo,
    TResult? Function(TLToDo newToDo)? updateToDo,
    TResult? Function(TLToDo corrToDo)? removeToDo,
  }) {
    return removeToDo?.call(corrToDo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLToDo newToDo)? addToDo,
    TResult Function(TLToDo newToDo)? updateToDo,
    TResult Function(TLToDo corrToDo)? removeToDo,
    required TResult orElse(),
  }) {
    if (removeToDo != null) {
      return removeToDo(corrToDo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddToDo value) addToDo,
    required TResult Function(_UpdateToDo value) updateToDo,
    required TResult Function(_RemoveToDo value) removeToDo,
  }) {
    return removeToDo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddToDo value)? addToDo,
    TResult? Function(_UpdateToDo value)? updateToDo,
    TResult? Function(_RemoveToDo value)? removeToDo,
  }) {
    return removeToDo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddToDo value)? addToDo,
    TResult Function(_UpdateToDo value)? updateToDo,
    TResult Function(_RemoveToDo value)? removeToDo,
    required TResult orElse(),
  }) {
    if (removeToDo != null) {
      return removeToDo(this);
    }
    return orElse();
  }
}

abstract class _RemoveToDo implements TLToDoAction {
  const factory _RemoveToDo({required final TLToDo corrToDo}) =
      _$RemoveToDoImpl;

  TLToDo get corrToDo;

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveToDoImplCopyWith<_$RemoveToDoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
