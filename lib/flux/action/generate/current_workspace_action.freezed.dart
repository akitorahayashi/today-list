// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../current_workspace_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CurrentWorkspaceAction {
  String? get workspaceId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? workspaceId) setCurrentWorkspaceId,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? workspaceId)? setCurrentWorkspaceId,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? workspaceId)? setCurrentWorkspaceId,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetCurrentWorkspaceId value)
    setCurrentWorkspaceId,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetCurrentWorkspaceId value)? setCurrentWorkspaceId,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetCurrentWorkspaceId value)? setCurrentWorkspaceId,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of CurrentWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CurrentWorkspaceActionCopyWith<CurrentWorkspaceAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrentWorkspaceActionCopyWith<$Res> {
  factory $CurrentWorkspaceActionCopyWith(
    CurrentWorkspaceAction value,
    $Res Function(CurrentWorkspaceAction) then,
  ) = _$CurrentWorkspaceActionCopyWithImpl<$Res, CurrentWorkspaceAction>;
  @useResult
  $Res call({String? workspaceId});
}

/// @nodoc
class _$CurrentWorkspaceActionCopyWithImpl<
  $Res,
  $Val extends CurrentWorkspaceAction
>
    implements $CurrentWorkspaceActionCopyWith<$Res> {
  _$CurrentWorkspaceActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CurrentWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? workspaceId = freezed}) {
    return _then(
      _value.copyWith(
            workspaceId:
                freezed == workspaceId
                    ? _value.workspaceId
                    : workspaceId // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SetCurrentWorkspaceIdImplCopyWith<$Res>
    implements $CurrentWorkspaceActionCopyWith<$Res> {
  factory _$$SetCurrentWorkspaceIdImplCopyWith(
    _$SetCurrentWorkspaceIdImpl value,
    $Res Function(_$SetCurrentWorkspaceIdImpl) then,
  ) = __$$SetCurrentWorkspaceIdImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? workspaceId});
}

/// @nodoc
class __$$SetCurrentWorkspaceIdImplCopyWithImpl<$Res>
    extends
        _$CurrentWorkspaceActionCopyWithImpl<$Res, _$SetCurrentWorkspaceIdImpl>
    implements _$$SetCurrentWorkspaceIdImplCopyWith<$Res> {
  __$$SetCurrentWorkspaceIdImplCopyWithImpl(
    _$SetCurrentWorkspaceIdImpl _value,
    $Res Function(_$SetCurrentWorkspaceIdImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CurrentWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? workspaceId = freezed}) {
    return _then(
      _$SetCurrentWorkspaceIdImpl(
        freezed == workspaceId
            ? _value.workspaceId
            : workspaceId // ignore: cast_nullable_to_non_nullable
                as String?,
      ),
    );
  }
}

/// @nodoc

class _$SetCurrentWorkspaceIdImpl implements SetCurrentWorkspaceId {
  const _$SetCurrentWorkspaceIdImpl(this.workspaceId);

  @override
  final String? workspaceId;

  @override
  String toString() {
    return 'CurrentWorkspaceAction.setCurrentWorkspaceId(workspaceId: $workspaceId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetCurrentWorkspaceIdImpl &&
            (identical(other.workspaceId, workspaceId) ||
                other.workspaceId == workspaceId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, workspaceId);

  /// Create a copy of CurrentWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetCurrentWorkspaceIdImplCopyWith<_$SetCurrentWorkspaceIdImpl>
  get copyWith =>
      __$$SetCurrentWorkspaceIdImplCopyWithImpl<_$SetCurrentWorkspaceIdImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? workspaceId) setCurrentWorkspaceId,
  }) {
    return setCurrentWorkspaceId(workspaceId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? workspaceId)? setCurrentWorkspaceId,
  }) {
    return setCurrentWorkspaceId?.call(workspaceId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? workspaceId)? setCurrentWorkspaceId,
    required TResult orElse(),
  }) {
    if (setCurrentWorkspaceId != null) {
      return setCurrentWorkspaceId(workspaceId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetCurrentWorkspaceId value)
    setCurrentWorkspaceId,
  }) {
    return setCurrentWorkspaceId(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetCurrentWorkspaceId value)? setCurrentWorkspaceId,
  }) {
    return setCurrentWorkspaceId?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetCurrentWorkspaceId value)? setCurrentWorkspaceId,
    required TResult orElse(),
  }) {
    if (setCurrentWorkspaceId != null) {
      return setCurrentWorkspaceId(this);
    }
    return orElse();
  }
}

abstract class SetCurrentWorkspaceId implements CurrentWorkspaceAction {
  const factory SetCurrentWorkspaceId(final String? workspaceId) =
      _$SetCurrentWorkspaceIdImpl;

  @override
  String? get workspaceId;

  /// Create a copy of CurrentWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetCurrentWorkspaceIdImplCopyWith<_$SetCurrentWorkspaceIdImpl>
  get copyWith => throw _privateConstructorUsedError;
}
