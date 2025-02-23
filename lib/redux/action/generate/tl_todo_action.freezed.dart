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
  TLWorkspace get corrWorkspace => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TLWorkspace corrWorkspace, TLToDo newToDo)
        addToDo,
    required TResult Function(TLWorkspace corrWorkspace, TLToDo newToDo)
        updateToDo,
    required TResult Function(TLWorkspace corrWorkspace, TLToDo corrToDo)
        deleteToDo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace corrWorkspace, TLToDo newToDo)? addToDo,
    TResult? Function(TLWorkspace corrWorkspace, TLToDo newToDo)? updateToDo,
    TResult? Function(TLWorkspace corrWorkspace, TLToDo corrToDo)? deleteToDo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace corrWorkspace, TLToDo newToDo)? addToDo,
    TResult Function(TLWorkspace corrWorkspace, TLToDo newToDo)? updateToDo,
    TResult Function(TLWorkspace corrWorkspace, TLToDo corrToDo)? deleteToDo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddToDo value) addToDo,
    required TResult Function(_UpdateToDo value) updateToDo,
    required TResult Function(_RemoveToDo value) deleteToDo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddToDo value)? addToDo,
    TResult? Function(_UpdateToDo value)? updateToDo,
    TResult? Function(_RemoveToDo value)? deleteToDo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddToDo value)? addToDo,
    TResult Function(_UpdateToDo value)? updateToDo,
    TResult Function(_RemoveToDo value)? deleteToDo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TLToDoActionCopyWith<TLToDoAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TLToDoActionCopyWith<$Res> {
  factory $TLToDoActionCopyWith(
          TLToDoAction value, $Res Function(TLToDoAction) then) =
      _$TLToDoActionCopyWithImpl<$Res, TLToDoAction>;
  @useResult
  $Res call({TLWorkspace corrWorkspace});

  $TLWorkspaceCopyWith<$Res> get corrWorkspace;
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
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? corrWorkspace = null,
  }) {
    return _then(_value.copyWith(
      corrWorkspace: null == corrWorkspace
          ? _value.corrWorkspace
          : corrWorkspace // ignore: cast_nullable_to_non_nullable
              as TLWorkspace,
    ) as $Val);
  }

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLWorkspaceCopyWith<$Res> get corrWorkspace {
    return $TLWorkspaceCopyWith<$Res>(_value.corrWorkspace, (value) {
      return _then(_value.copyWith(corrWorkspace: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AddToDoImplCopyWith<$Res>
    implements $TLToDoActionCopyWith<$Res> {
  factory _$$AddToDoImplCopyWith(
          _$AddToDoImpl value, $Res Function(_$AddToDoImpl) then) =
      __$$AddToDoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TLWorkspace corrWorkspace, TLToDo newToDo});

  @override
  $TLWorkspaceCopyWith<$Res> get corrWorkspace;
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
    Object? corrWorkspace = null,
    Object? newToDo = null,
  }) {
    return _then(_$AddToDoImpl(
      corrWorkspace: null == corrWorkspace
          ? _value.corrWorkspace
          : corrWorkspace // ignore: cast_nullable_to_non_nullable
              as TLWorkspace,
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
  const _$AddToDoImpl({required this.corrWorkspace, required this.newToDo});

  @override
  final TLWorkspace corrWorkspace;
  @override
  final TLToDo newToDo;

  @override
  String toString() {
    return 'TLToDoAction.addToDo(corrWorkspace: $corrWorkspace, newToDo: $newToDo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddToDoImpl &&
            (identical(other.corrWorkspace, corrWorkspace) ||
                other.corrWorkspace == corrWorkspace) &&
            (identical(other.newToDo, newToDo) || other.newToDo == newToDo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, corrWorkspace, newToDo);

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
    required TResult Function(TLWorkspace corrWorkspace, TLToDo newToDo)
        addToDo,
    required TResult Function(TLWorkspace corrWorkspace, TLToDo newToDo)
        updateToDo,
    required TResult Function(TLWorkspace corrWorkspace, TLToDo corrToDo)
        deleteToDo,
  }) {
    return addToDo(corrWorkspace, newToDo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace corrWorkspace, TLToDo newToDo)? addToDo,
    TResult? Function(TLWorkspace corrWorkspace, TLToDo newToDo)? updateToDo,
    TResult? Function(TLWorkspace corrWorkspace, TLToDo corrToDo)? deleteToDo,
  }) {
    return addToDo?.call(corrWorkspace, newToDo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace corrWorkspace, TLToDo newToDo)? addToDo,
    TResult Function(TLWorkspace corrWorkspace, TLToDo newToDo)? updateToDo,
    TResult Function(TLWorkspace corrWorkspace, TLToDo corrToDo)? deleteToDo,
    required TResult orElse(),
  }) {
    if (addToDo != null) {
      return addToDo(corrWorkspace, newToDo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddToDo value) addToDo,
    required TResult Function(_UpdateToDo value) updateToDo,
    required TResult Function(_RemoveToDo value) deleteToDo,
  }) {
    return addToDo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddToDo value)? addToDo,
    TResult? Function(_UpdateToDo value)? updateToDo,
    TResult? Function(_RemoveToDo value)? deleteToDo,
  }) {
    return addToDo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddToDo value)? addToDo,
    TResult Function(_UpdateToDo value)? updateToDo,
    TResult Function(_RemoveToDo value)? deleteToDo,
    required TResult orElse(),
  }) {
    if (addToDo != null) {
      return addToDo(this);
    }
    return orElse();
  }
}

abstract class _AddToDo implements TLToDoAction {
  const factory _AddToDo(
      {required final TLWorkspace corrWorkspace,
      required final TLToDo newToDo}) = _$AddToDoImpl;

  @override
  TLWorkspace get corrWorkspace;
  TLToDo get newToDo;

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddToDoImplCopyWith<_$AddToDoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateToDoImplCopyWith<$Res>
    implements $TLToDoActionCopyWith<$Res> {
  factory _$$UpdateToDoImplCopyWith(
          _$UpdateToDoImpl value, $Res Function(_$UpdateToDoImpl) then) =
      __$$UpdateToDoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TLWorkspace corrWorkspace, TLToDo newToDo});

  @override
  $TLWorkspaceCopyWith<$Res> get corrWorkspace;
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
    Object? corrWorkspace = null,
    Object? newToDo = null,
  }) {
    return _then(_$UpdateToDoImpl(
      corrWorkspace: null == corrWorkspace
          ? _value.corrWorkspace
          : corrWorkspace // ignore: cast_nullable_to_non_nullable
              as TLWorkspace,
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
  const _$UpdateToDoImpl({required this.corrWorkspace, required this.newToDo});

  @override
  final TLWorkspace corrWorkspace;
  @override
  final TLToDo newToDo;

  @override
  String toString() {
    return 'TLToDoAction.updateToDo(corrWorkspace: $corrWorkspace, newToDo: $newToDo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateToDoImpl &&
            (identical(other.corrWorkspace, corrWorkspace) ||
                other.corrWorkspace == corrWorkspace) &&
            (identical(other.newToDo, newToDo) || other.newToDo == newToDo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, corrWorkspace, newToDo);

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
    required TResult Function(TLWorkspace corrWorkspace, TLToDo newToDo)
        addToDo,
    required TResult Function(TLWorkspace corrWorkspace, TLToDo newToDo)
        updateToDo,
    required TResult Function(TLWorkspace corrWorkspace, TLToDo corrToDo)
        deleteToDo,
  }) {
    return updateToDo(corrWorkspace, newToDo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace corrWorkspace, TLToDo newToDo)? addToDo,
    TResult? Function(TLWorkspace corrWorkspace, TLToDo newToDo)? updateToDo,
    TResult? Function(TLWorkspace corrWorkspace, TLToDo corrToDo)? deleteToDo,
  }) {
    return updateToDo?.call(corrWorkspace, newToDo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace corrWorkspace, TLToDo newToDo)? addToDo,
    TResult Function(TLWorkspace corrWorkspace, TLToDo newToDo)? updateToDo,
    TResult Function(TLWorkspace corrWorkspace, TLToDo corrToDo)? deleteToDo,
    required TResult orElse(),
  }) {
    if (updateToDo != null) {
      return updateToDo(corrWorkspace, newToDo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddToDo value) addToDo,
    required TResult Function(_UpdateToDo value) updateToDo,
    required TResult Function(_RemoveToDo value) deleteToDo,
  }) {
    return updateToDo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddToDo value)? addToDo,
    TResult? Function(_UpdateToDo value)? updateToDo,
    TResult? Function(_RemoveToDo value)? deleteToDo,
  }) {
    return updateToDo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddToDo value)? addToDo,
    TResult Function(_UpdateToDo value)? updateToDo,
    TResult Function(_RemoveToDo value)? deleteToDo,
    required TResult orElse(),
  }) {
    if (updateToDo != null) {
      return updateToDo(this);
    }
    return orElse();
  }
}

abstract class _UpdateToDo implements TLToDoAction {
  const factory _UpdateToDo(
      {required final TLWorkspace corrWorkspace,
      required final TLToDo newToDo}) = _$UpdateToDoImpl;

  @override
  TLWorkspace get corrWorkspace;
  TLToDo get newToDo;

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateToDoImplCopyWith<_$UpdateToDoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveToDoImplCopyWith<$Res>
    implements $TLToDoActionCopyWith<$Res> {
  factory _$$RemoveToDoImplCopyWith(
          _$RemoveToDoImpl value, $Res Function(_$RemoveToDoImpl) then) =
      __$$RemoveToDoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TLWorkspace corrWorkspace, TLToDo corrToDo});

  @override
  $TLWorkspaceCopyWith<$Res> get corrWorkspace;
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
    Object? corrWorkspace = null,
    Object? corrToDo = null,
  }) {
    return _then(_$RemoveToDoImpl(
      corrWorkspace: null == corrWorkspace
          ? _value.corrWorkspace
          : corrWorkspace // ignore: cast_nullable_to_non_nullable
              as TLWorkspace,
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
  const _$RemoveToDoImpl({required this.corrWorkspace, required this.corrToDo});

  @override
  final TLWorkspace corrWorkspace;
  @override
  final TLToDo corrToDo;

  @override
  String toString() {
    return 'TLToDoAction.deleteToDo(corrWorkspace: $corrWorkspace, corrToDo: $corrToDo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveToDoImpl &&
            (identical(other.corrWorkspace, corrWorkspace) ||
                other.corrWorkspace == corrWorkspace) &&
            (identical(other.corrToDo, corrToDo) ||
                other.corrToDo == corrToDo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, corrWorkspace, corrToDo);

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
    required TResult Function(TLWorkspace corrWorkspace, TLToDo newToDo)
        addToDo,
    required TResult Function(TLWorkspace corrWorkspace, TLToDo newToDo)
        updateToDo,
    required TResult Function(TLWorkspace corrWorkspace, TLToDo corrToDo)
        deleteToDo,
  }) {
    return deleteToDo(corrWorkspace, corrToDo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace corrWorkspace, TLToDo newToDo)? addToDo,
    TResult? Function(TLWorkspace corrWorkspace, TLToDo newToDo)? updateToDo,
    TResult? Function(TLWorkspace corrWorkspace, TLToDo corrToDo)? deleteToDo,
  }) {
    return deleteToDo?.call(corrWorkspace, corrToDo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace corrWorkspace, TLToDo newToDo)? addToDo,
    TResult Function(TLWorkspace corrWorkspace, TLToDo newToDo)? updateToDo,
    TResult Function(TLWorkspace corrWorkspace, TLToDo corrToDo)? deleteToDo,
    required TResult orElse(),
  }) {
    if (deleteToDo != null) {
      return deleteToDo(corrWorkspace, corrToDo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddToDo value) addToDo,
    required TResult Function(_UpdateToDo value) updateToDo,
    required TResult Function(_RemoveToDo value) deleteToDo,
  }) {
    return deleteToDo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddToDo value)? addToDo,
    TResult? Function(_UpdateToDo value)? updateToDo,
    TResult? Function(_RemoveToDo value)? deleteToDo,
  }) {
    return deleteToDo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddToDo value)? addToDo,
    TResult Function(_UpdateToDo value)? updateToDo,
    TResult Function(_RemoveToDo value)? deleteToDo,
    required TResult orElse(),
  }) {
    if (deleteToDo != null) {
      return deleteToDo(this);
    }
    return orElse();
  }
}

abstract class _RemoveToDo implements TLToDoAction {
  const factory _RemoveToDo(
      {required final TLWorkspace corrWorkspace,
      required final TLToDo corrToDo}) = _$RemoveToDoImpl;

  @override
  TLWorkspace get corrWorkspace;
  TLToDo get corrToDo;

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveToDoImplCopyWith<_$RemoveToDoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
