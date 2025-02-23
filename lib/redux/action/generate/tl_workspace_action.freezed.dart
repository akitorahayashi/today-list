// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../tl_workspace_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TLWorkspaceAction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TLWorkspace newWorkspace) addWorkspace,
    required TResult Function(TLWorkspace corrWorkspace) deleteWorkspace,
    required TResult Function(TLWorkspace corrWorkspace)
        deleteAllCheckedToDosInWorkspace,
    required TResult Function(TLWorkspace corrWorkspace) saveCorrWorkspace,
    required TResult Function(int oldIndex, int newIndex) reorderWorkspace,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult? Function(TLWorkspace corrWorkspace)? deleteWorkspace,
    TResult? Function(TLWorkspace corrWorkspace)?
        deleteAllCheckedToDosInWorkspace,
    TResult? Function(TLWorkspace corrWorkspace)? saveCorrWorkspace,
    TResult? Function(int oldIndex, int newIndex)? reorderWorkspace,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult Function(TLWorkspace corrWorkspace)? deleteWorkspace,
    TResult Function(TLWorkspace corrWorkspace)?
        deleteAllCheckedToDosInWorkspace,
    TResult Function(TLWorkspace corrWorkspace)? saveCorrWorkspace,
    TResult Function(int oldIndex, int newIndex)? reorderWorkspace,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddWorkspace value) addWorkspace,
    required TResult Function(RemoveWorkspace value) deleteWorkspace,
    required TResult Function(DeleteAllCheckedToDosInWorkspace value)
        deleteAllCheckedToDosInWorkspace,
    required TResult Function(UpdateCurrentWorkspace value) saveCorrWorkspace,
    required TResult Function(ReorderWorkspace value) reorderWorkspace,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddWorkspace value)? addWorkspace,
    TResult? Function(RemoveWorkspace value)? deleteWorkspace,
    TResult? Function(DeleteAllCheckedToDosInWorkspace value)?
        deleteAllCheckedToDosInWorkspace,
    TResult? Function(UpdateCurrentWorkspace value)? saveCorrWorkspace,
    TResult? Function(ReorderWorkspace value)? reorderWorkspace,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddWorkspace value)? addWorkspace,
    TResult Function(RemoveWorkspace value)? deleteWorkspace,
    TResult Function(DeleteAllCheckedToDosInWorkspace value)?
        deleteAllCheckedToDosInWorkspace,
    TResult Function(UpdateCurrentWorkspace value)? saveCorrWorkspace,
    TResult Function(ReorderWorkspace value)? reorderWorkspace,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TLWorkspaceActionCopyWith<$Res> {
  factory $TLWorkspaceActionCopyWith(
          TLWorkspaceAction value, $Res Function(TLWorkspaceAction) then) =
      _$TLWorkspaceActionCopyWithImpl<$Res, TLWorkspaceAction>;
}

/// @nodoc
class _$TLWorkspaceActionCopyWithImpl<$Res, $Val extends TLWorkspaceAction>
    implements $TLWorkspaceActionCopyWith<$Res> {
  _$TLWorkspaceActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AddWorkspaceImplCopyWith<$Res> {
  factory _$$AddWorkspaceImplCopyWith(
          _$AddWorkspaceImpl value, $Res Function(_$AddWorkspaceImpl) then) =
      __$$AddWorkspaceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TLWorkspace newWorkspace});

  $TLWorkspaceCopyWith<$Res> get newWorkspace;
}

/// @nodoc
class __$$AddWorkspaceImplCopyWithImpl<$Res>
    extends _$TLWorkspaceActionCopyWithImpl<$Res, _$AddWorkspaceImpl>
    implements _$$AddWorkspaceImplCopyWith<$Res> {
  __$$AddWorkspaceImplCopyWithImpl(
      _$AddWorkspaceImpl _value, $Res Function(_$AddWorkspaceImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newWorkspace = null,
  }) {
    return _then(_$AddWorkspaceImpl(
      null == newWorkspace
          ? _value.newWorkspace
          : newWorkspace // ignore: cast_nullable_to_non_nullable
              as TLWorkspace,
    ));
  }

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLWorkspaceCopyWith<$Res> get newWorkspace {
    return $TLWorkspaceCopyWith<$Res>(_value.newWorkspace, (value) {
      return _then(_value.copyWith(newWorkspace: value));
    });
  }
}

/// @nodoc

class _$AddWorkspaceImpl implements AddWorkspace {
  const _$AddWorkspaceImpl(this.newWorkspace);

  @override
  final TLWorkspace newWorkspace;

  @override
  String toString() {
    return 'TLWorkspaceAction.addWorkspace(newWorkspace: $newWorkspace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddWorkspaceImpl &&
            (identical(other.newWorkspace, newWorkspace) ||
                other.newWorkspace == newWorkspace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newWorkspace);

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddWorkspaceImplCopyWith<_$AddWorkspaceImpl> get copyWith =>
      __$$AddWorkspaceImplCopyWithImpl<_$AddWorkspaceImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TLWorkspace newWorkspace) addWorkspace,
    required TResult Function(TLWorkspace corrWorkspace) deleteWorkspace,
    required TResult Function(TLWorkspace corrWorkspace)
        deleteAllCheckedToDosInWorkspace,
    required TResult Function(TLWorkspace corrWorkspace) saveCorrWorkspace,
    required TResult Function(int oldIndex, int newIndex) reorderWorkspace,
  }) {
    return addWorkspace(newWorkspace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult? Function(TLWorkspace corrWorkspace)? deleteWorkspace,
    TResult? Function(TLWorkspace corrWorkspace)?
        deleteAllCheckedToDosInWorkspace,
    TResult? Function(TLWorkspace corrWorkspace)? saveCorrWorkspace,
    TResult? Function(int oldIndex, int newIndex)? reorderWorkspace,
  }) {
    return addWorkspace?.call(newWorkspace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult Function(TLWorkspace corrWorkspace)? deleteWorkspace,
    TResult Function(TLWorkspace corrWorkspace)?
        deleteAllCheckedToDosInWorkspace,
    TResult Function(TLWorkspace corrWorkspace)? saveCorrWorkspace,
    TResult Function(int oldIndex, int newIndex)? reorderWorkspace,
    required TResult orElse(),
  }) {
    if (addWorkspace != null) {
      return addWorkspace(newWorkspace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddWorkspace value) addWorkspace,
    required TResult Function(RemoveWorkspace value) deleteWorkspace,
    required TResult Function(DeleteAllCheckedToDosInWorkspace value)
        deleteAllCheckedToDosInWorkspace,
    required TResult Function(UpdateCurrentWorkspace value) saveCorrWorkspace,
    required TResult Function(ReorderWorkspace value) reorderWorkspace,
  }) {
    return addWorkspace(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddWorkspace value)? addWorkspace,
    TResult? Function(RemoveWorkspace value)? deleteWorkspace,
    TResult? Function(DeleteAllCheckedToDosInWorkspace value)?
        deleteAllCheckedToDosInWorkspace,
    TResult? Function(UpdateCurrentWorkspace value)? saveCorrWorkspace,
    TResult? Function(ReorderWorkspace value)? reorderWorkspace,
  }) {
    return addWorkspace?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddWorkspace value)? addWorkspace,
    TResult Function(RemoveWorkspace value)? deleteWorkspace,
    TResult Function(DeleteAllCheckedToDosInWorkspace value)?
        deleteAllCheckedToDosInWorkspace,
    TResult Function(UpdateCurrentWorkspace value)? saveCorrWorkspace,
    TResult Function(ReorderWorkspace value)? reorderWorkspace,
    required TResult orElse(),
  }) {
    if (addWorkspace != null) {
      return addWorkspace(this);
    }
    return orElse();
  }
}

abstract class AddWorkspace implements TLWorkspaceAction {
  const factory AddWorkspace(final TLWorkspace newWorkspace) =
      _$AddWorkspaceImpl;

  TLWorkspace get newWorkspace;

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddWorkspaceImplCopyWith<_$AddWorkspaceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveWorkspaceImplCopyWith<$Res> {
  factory _$$RemoveWorkspaceImplCopyWith(_$RemoveWorkspaceImpl value,
          $Res Function(_$RemoveWorkspaceImpl) then) =
      __$$RemoveWorkspaceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TLWorkspace corrWorkspace});

  $TLWorkspaceCopyWith<$Res> get corrWorkspace;
}

/// @nodoc
class __$$RemoveWorkspaceImplCopyWithImpl<$Res>
    extends _$TLWorkspaceActionCopyWithImpl<$Res, _$RemoveWorkspaceImpl>
    implements _$$RemoveWorkspaceImplCopyWith<$Res> {
  __$$RemoveWorkspaceImplCopyWithImpl(
      _$RemoveWorkspaceImpl _value, $Res Function(_$RemoveWorkspaceImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? corrWorkspace = null,
  }) {
    return _then(_$RemoveWorkspaceImpl(
      null == corrWorkspace
          ? _value.corrWorkspace
          : corrWorkspace // ignore: cast_nullable_to_non_nullable
              as TLWorkspace,
    ));
  }

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLWorkspaceCopyWith<$Res> get corrWorkspace {
    return $TLWorkspaceCopyWith<$Res>(_value.corrWorkspace, (value) {
      return _then(_value.copyWith(corrWorkspace: value));
    });
  }
}

/// @nodoc

class _$RemoveWorkspaceImpl implements RemoveWorkspace {
  const _$RemoveWorkspaceImpl(this.corrWorkspace);

  @override
  final TLWorkspace corrWorkspace;

  @override
  String toString() {
    return 'TLWorkspaceAction.deleteWorkspace(corrWorkspace: $corrWorkspace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveWorkspaceImpl &&
            (identical(other.corrWorkspace, corrWorkspace) ||
                other.corrWorkspace == corrWorkspace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, corrWorkspace);

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveWorkspaceImplCopyWith<_$RemoveWorkspaceImpl> get copyWith =>
      __$$RemoveWorkspaceImplCopyWithImpl<_$RemoveWorkspaceImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TLWorkspace newWorkspace) addWorkspace,
    required TResult Function(TLWorkspace corrWorkspace) deleteWorkspace,
    required TResult Function(TLWorkspace corrWorkspace)
        deleteAllCheckedToDosInWorkspace,
    required TResult Function(TLWorkspace corrWorkspace) saveCorrWorkspace,
    required TResult Function(int oldIndex, int newIndex) reorderWorkspace,
  }) {
    return deleteWorkspace(corrWorkspace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult? Function(TLWorkspace corrWorkspace)? deleteWorkspace,
    TResult? Function(TLWorkspace corrWorkspace)?
        deleteAllCheckedToDosInWorkspace,
    TResult? Function(TLWorkspace corrWorkspace)? saveCorrWorkspace,
    TResult? Function(int oldIndex, int newIndex)? reorderWorkspace,
  }) {
    return deleteWorkspace?.call(corrWorkspace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult Function(TLWorkspace corrWorkspace)? deleteWorkspace,
    TResult Function(TLWorkspace corrWorkspace)?
        deleteAllCheckedToDosInWorkspace,
    TResult Function(TLWorkspace corrWorkspace)? saveCorrWorkspace,
    TResult Function(int oldIndex, int newIndex)? reorderWorkspace,
    required TResult orElse(),
  }) {
    if (deleteWorkspace != null) {
      return deleteWorkspace(corrWorkspace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddWorkspace value) addWorkspace,
    required TResult Function(RemoveWorkspace value) deleteWorkspace,
    required TResult Function(DeleteAllCheckedToDosInWorkspace value)
        deleteAllCheckedToDosInWorkspace,
    required TResult Function(UpdateCurrentWorkspace value) saveCorrWorkspace,
    required TResult Function(ReorderWorkspace value) reorderWorkspace,
  }) {
    return deleteWorkspace(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddWorkspace value)? addWorkspace,
    TResult? Function(RemoveWorkspace value)? deleteWorkspace,
    TResult? Function(DeleteAllCheckedToDosInWorkspace value)?
        deleteAllCheckedToDosInWorkspace,
    TResult? Function(UpdateCurrentWorkspace value)? saveCorrWorkspace,
    TResult? Function(ReorderWorkspace value)? reorderWorkspace,
  }) {
    return deleteWorkspace?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddWorkspace value)? addWorkspace,
    TResult Function(RemoveWorkspace value)? deleteWorkspace,
    TResult Function(DeleteAllCheckedToDosInWorkspace value)?
        deleteAllCheckedToDosInWorkspace,
    TResult Function(UpdateCurrentWorkspace value)? saveCorrWorkspace,
    TResult Function(ReorderWorkspace value)? reorderWorkspace,
    required TResult orElse(),
  }) {
    if (deleteWorkspace != null) {
      return deleteWorkspace(this);
    }
    return orElse();
  }
}

abstract class RemoveWorkspace implements TLWorkspaceAction {
  const factory RemoveWorkspace(final TLWorkspace corrWorkspace) =
      _$RemoveWorkspaceImpl;

  TLWorkspace get corrWorkspace;

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveWorkspaceImplCopyWith<_$RemoveWorkspaceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteAllCheckedToDosInWorkspaceImplCopyWith<$Res> {
  factory _$$DeleteAllCheckedToDosInWorkspaceImplCopyWith(
          _$DeleteAllCheckedToDosInWorkspaceImpl value,
          $Res Function(_$DeleteAllCheckedToDosInWorkspaceImpl) then) =
      __$$DeleteAllCheckedToDosInWorkspaceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TLWorkspace corrWorkspace});

  $TLWorkspaceCopyWith<$Res> get corrWorkspace;
}

/// @nodoc
class __$$DeleteAllCheckedToDosInWorkspaceImplCopyWithImpl<$Res>
    extends _$TLWorkspaceActionCopyWithImpl<$Res,
        _$DeleteAllCheckedToDosInWorkspaceImpl>
    implements _$$DeleteAllCheckedToDosInWorkspaceImplCopyWith<$Res> {
  __$$DeleteAllCheckedToDosInWorkspaceImplCopyWithImpl(
      _$DeleteAllCheckedToDosInWorkspaceImpl _value,
      $Res Function(_$DeleteAllCheckedToDosInWorkspaceImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? corrWorkspace = null,
  }) {
    return _then(_$DeleteAllCheckedToDosInWorkspaceImpl(
      null == corrWorkspace
          ? _value.corrWorkspace
          : corrWorkspace // ignore: cast_nullable_to_non_nullable
              as TLWorkspace,
    ));
  }

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLWorkspaceCopyWith<$Res> get corrWorkspace {
    return $TLWorkspaceCopyWith<$Res>(_value.corrWorkspace, (value) {
      return _then(_value.copyWith(corrWorkspace: value));
    });
  }
}

/// @nodoc

class _$DeleteAllCheckedToDosInWorkspaceImpl
    implements DeleteAllCheckedToDosInWorkspace {
  const _$DeleteAllCheckedToDosInWorkspaceImpl(this.corrWorkspace);

  @override
  final TLWorkspace corrWorkspace;

  @override
  String toString() {
    return 'TLWorkspaceAction.deleteAllCheckedToDosInWorkspace(corrWorkspace: $corrWorkspace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteAllCheckedToDosInWorkspaceImpl &&
            (identical(other.corrWorkspace, corrWorkspace) ||
                other.corrWorkspace == corrWorkspace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, corrWorkspace);

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteAllCheckedToDosInWorkspaceImplCopyWith<
          _$DeleteAllCheckedToDosInWorkspaceImpl>
      get copyWith => __$$DeleteAllCheckedToDosInWorkspaceImplCopyWithImpl<
          _$DeleteAllCheckedToDosInWorkspaceImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TLWorkspace newWorkspace) addWorkspace,
    required TResult Function(TLWorkspace corrWorkspace) deleteWorkspace,
    required TResult Function(TLWorkspace corrWorkspace)
        deleteAllCheckedToDosInWorkspace,
    required TResult Function(TLWorkspace corrWorkspace) saveCorrWorkspace,
    required TResult Function(int oldIndex, int newIndex) reorderWorkspace,
  }) {
    return deleteAllCheckedToDosInWorkspace(corrWorkspace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult? Function(TLWorkspace corrWorkspace)? deleteWorkspace,
    TResult? Function(TLWorkspace corrWorkspace)?
        deleteAllCheckedToDosInWorkspace,
    TResult? Function(TLWorkspace corrWorkspace)? saveCorrWorkspace,
    TResult? Function(int oldIndex, int newIndex)? reorderWorkspace,
  }) {
    return deleteAllCheckedToDosInWorkspace?.call(corrWorkspace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult Function(TLWorkspace corrWorkspace)? deleteWorkspace,
    TResult Function(TLWorkspace corrWorkspace)?
        deleteAllCheckedToDosInWorkspace,
    TResult Function(TLWorkspace corrWorkspace)? saveCorrWorkspace,
    TResult Function(int oldIndex, int newIndex)? reorderWorkspace,
    required TResult orElse(),
  }) {
    if (deleteAllCheckedToDosInWorkspace != null) {
      return deleteAllCheckedToDosInWorkspace(corrWorkspace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddWorkspace value) addWorkspace,
    required TResult Function(RemoveWorkspace value) deleteWorkspace,
    required TResult Function(DeleteAllCheckedToDosInWorkspace value)
        deleteAllCheckedToDosInWorkspace,
    required TResult Function(UpdateCurrentWorkspace value) saveCorrWorkspace,
    required TResult Function(ReorderWorkspace value) reorderWorkspace,
  }) {
    return deleteAllCheckedToDosInWorkspace(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddWorkspace value)? addWorkspace,
    TResult? Function(RemoveWorkspace value)? deleteWorkspace,
    TResult? Function(DeleteAllCheckedToDosInWorkspace value)?
        deleteAllCheckedToDosInWorkspace,
    TResult? Function(UpdateCurrentWorkspace value)? saveCorrWorkspace,
    TResult? Function(ReorderWorkspace value)? reorderWorkspace,
  }) {
    return deleteAllCheckedToDosInWorkspace?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddWorkspace value)? addWorkspace,
    TResult Function(RemoveWorkspace value)? deleteWorkspace,
    TResult Function(DeleteAllCheckedToDosInWorkspace value)?
        deleteAllCheckedToDosInWorkspace,
    TResult Function(UpdateCurrentWorkspace value)? saveCorrWorkspace,
    TResult Function(ReorderWorkspace value)? reorderWorkspace,
    required TResult orElse(),
  }) {
    if (deleteAllCheckedToDosInWorkspace != null) {
      return deleteAllCheckedToDosInWorkspace(this);
    }
    return orElse();
  }
}

abstract class DeleteAllCheckedToDosInWorkspace implements TLWorkspaceAction {
  const factory DeleteAllCheckedToDosInWorkspace(
      final TLWorkspace corrWorkspace) = _$DeleteAllCheckedToDosInWorkspaceImpl;

  TLWorkspace get corrWorkspace;

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteAllCheckedToDosInWorkspaceImplCopyWith<
          _$DeleteAllCheckedToDosInWorkspaceImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateCurrentWorkspaceImplCopyWith<$Res> {
  factory _$$UpdateCurrentWorkspaceImplCopyWith(
          _$UpdateCurrentWorkspaceImpl value,
          $Res Function(_$UpdateCurrentWorkspaceImpl) then) =
      __$$UpdateCurrentWorkspaceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TLWorkspace corrWorkspace});

  $TLWorkspaceCopyWith<$Res> get corrWorkspace;
}

/// @nodoc
class __$$UpdateCurrentWorkspaceImplCopyWithImpl<$Res>
    extends _$TLWorkspaceActionCopyWithImpl<$Res, _$UpdateCurrentWorkspaceImpl>
    implements _$$UpdateCurrentWorkspaceImplCopyWith<$Res> {
  __$$UpdateCurrentWorkspaceImplCopyWithImpl(
      _$UpdateCurrentWorkspaceImpl _value,
      $Res Function(_$UpdateCurrentWorkspaceImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? corrWorkspace = null,
  }) {
    return _then(_$UpdateCurrentWorkspaceImpl(
      null == corrWorkspace
          ? _value.corrWorkspace
          : corrWorkspace // ignore: cast_nullable_to_non_nullable
              as TLWorkspace,
    ));
  }

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLWorkspaceCopyWith<$Res> get corrWorkspace {
    return $TLWorkspaceCopyWith<$Res>(_value.corrWorkspace, (value) {
      return _then(_value.copyWith(corrWorkspace: value));
    });
  }
}

/// @nodoc

class _$UpdateCurrentWorkspaceImpl implements UpdateCurrentWorkspace {
  const _$UpdateCurrentWorkspaceImpl(this.corrWorkspace);

  @override
  final TLWorkspace corrWorkspace;

  @override
  String toString() {
    return 'TLWorkspaceAction.saveCorrWorkspace(corrWorkspace: $corrWorkspace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateCurrentWorkspaceImpl &&
            (identical(other.corrWorkspace, corrWorkspace) ||
                other.corrWorkspace == corrWorkspace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, corrWorkspace);

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateCurrentWorkspaceImplCopyWith<_$UpdateCurrentWorkspaceImpl>
      get copyWith => __$$UpdateCurrentWorkspaceImplCopyWithImpl<
          _$UpdateCurrentWorkspaceImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TLWorkspace newWorkspace) addWorkspace,
    required TResult Function(TLWorkspace corrWorkspace) deleteWorkspace,
    required TResult Function(TLWorkspace corrWorkspace)
        deleteAllCheckedToDosInWorkspace,
    required TResult Function(TLWorkspace corrWorkspace) saveCorrWorkspace,
    required TResult Function(int oldIndex, int newIndex) reorderWorkspace,
  }) {
    return saveCorrWorkspace(corrWorkspace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult? Function(TLWorkspace corrWorkspace)? deleteWorkspace,
    TResult? Function(TLWorkspace corrWorkspace)?
        deleteAllCheckedToDosInWorkspace,
    TResult? Function(TLWorkspace corrWorkspace)? saveCorrWorkspace,
    TResult? Function(int oldIndex, int newIndex)? reorderWorkspace,
  }) {
    return saveCorrWorkspace?.call(corrWorkspace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult Function(TLWorkspace corrWorkspace)? deleteWorkspace,
    TResult Function(TLWorkspace corrWorkspace)?
        deleteAllCheckedToDosInWorkspace,
    TResult Function(TLWorkspace corrWorkspace)? saveCorrWorkspace,
    TResult Function(int oldIndex, int newIndex)? reorderWorkspace,
    required TResult orElse(),
  }) {
    if (saveCorrWorkspace != null) {
      return saveCorrWorkspace(corrWorkspace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddWorkspace value) addWorkspace,
    required TResult Function(RemoveWorkspace value) deleteWorkspace,
    required TResult Function(DeleteAllCheckedToDosInWorkspace value)
        deleteAllCheckedToDosInWorkspace,
    required TResult Function(UpdateCurrentWorkspace value) saveCorrWorkspace,
    required TResult Function(ReorderWorkspace value) reorderWorkspace,
  }) {
    return saveCorrWorkspace(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddWorkspace value)? addWorkspace,
    TResult? Function(RemoveWorkspace value)? deleteWorkspace,
    TResult? Function(DeleteAllCheckedToDosInWorkspace value)?
        deleteAllCheckedToDosInWorkspace,
    TResult? Function(UpdateCurrentWorkspace value)? saveCorrWorkspace,
    TResult? Function(ReorderWorkspace value)? reorderWorkspace,
  }) {
    return saveCorrWorkspace?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddWorkspace value)? addWorkspace,
    TResult Function(RemoveWorkspace value)? deleteWorkspace,
    TResult Function(DeleteAllCheckedToDosInWorkspace value)?
        deleteAllCheckedToDosInWorkspace,
    TResult Function(UpdateCurrentWorkspace value)? saveCorrWorkspace,
    TResult Function(ReorderWorkspace value)? reorderWorkspace,
    required TResult orElse(),
  }) {
    if (saveCorrWorkspace != null) {
      return saveCorrWorkspace(this);
    }
    return orElse();
  }
}

abstract class UpdateCurrentWorkspace implements TLWorkspaceAction {
  const factory UpdateCurrentWorkspace(final TLWorkspace corrWorkspace) =
      _$UpdateCurrentWorkspaceImpl;

  TLWorkspace get corrWorkspace;

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateCurrentWorkspaceImplCopyWith<_$UpdateCurrentWorkspaceImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReorderWorkspaceImplCopyWith<$Res> {
  factory _$$ReorderWorkspaceImplCopyWith(_$ReorderWorkspaceImpl value,
          $Res Function(_$ReorderWorkspaceImpl) then) =
      __$$ReorderWorkspaceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int oldIndex, int newIndex});
}

/// @nodoc
class __$$ReorderWorkspaceImplCopyWithImpl<$Res>
    extends _$TLWorkspaceActionCopyWithImpl<$Res, _$ReorderWorkspaceImpl>
    implements _$$ReorderWorkspaceImplCopyWith<$Res> {
  __$$ReorderWorkspaceImplCopyWithImpl(_$ReorderWorkspaceImpl _value,
      $Res Function(_$ReorderWorkspaceImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldIndex = null,
    Object? newIndex = null,
  }) {
    return _then(_$ReorderWorkspaceImpl(
      oldIndex: null == oldIndex
          ? _value.oldIndex
          : oldIndex // ignore: cast_nullable_to_non_nullable
              as int,
      newIndex: null == newIndex
          ? _value.newIndex
          : newIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ReorderWorkspaceImpl implements ReorderWorkspace {
  const _$ReorderWorkspaceImpl(
      {required this.oldIndex, required this.newIndex});

  @override
  final int oldIndex;
  @override
  final int newIndex;

  @override
  String toString() {
    return 'TLWorkspaceAction.reorderWorkspace(oldIndex: $oldIndex, newIndex: $newIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReorderWorkspaceImpl &&
            (identical(other.oldIndex, oldIndex) ||
                other.oldIndex == oldIndex) &&
            (identical(other.newIndex, newIndex) ||
                other.newIndex == newIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, oldIndex, newIndex);

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReorderWorkspaceImplCopyWith<_$ReorderWorkspaceImpl> get copyWith =>
      __$$ReorderWorkspaceImplCopyWithImpl<_$ReorderWorkspaceImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TLWorkspace newWorkspace) addWorkspace,
    required TResult Function(TLWorkspace corrWorkspace) deleteWorkspace,
    required TResult Function(TLWorkspace corrWorkspace)
        deleteAllCheckedToDosInWorkspace,
    required TResult Function(TLWorkspace corrWorkspace) saveCorrWorkspace,
    required TResult Function(int oldIndex, int newIndex) reorderWorkspace,
  }) {
    return reorderWorkspace(oldIndex, newIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult? Function(TLWorkspace corrWorkspace)? deleteWorkspace,
    TResult? Function(TLWorkspace corrWorkspace)?
        deleteAllCheckedToDosInWorkspace,
    TResult? Function(TLWorkspace corrWorkspace)? saveCorrWorkspace,
    TResult? Function(int oldIndex, int newIndex)? reorderWorkspace,
  }) {
    return reorderWorkspace?.call(oldIndex, newIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult Function(TLWorkspace corrWorkspace)? deleteWorkspace,
    TResult Function(TLWorkspace corrWorkspace)?
        deleteAllCheckedToDosInWorkspace,
    TResult Function(TLWorkspace corrWorkspace)? saveCorrWorkspace,
    TResult Function(int oldIndex, int newIndex)? reorderWorkspace,
    required TResult orElse(),
  }) {
    if (reorderWorkspace != null) {
      return reorderWorkspace(oldIndex, newIndex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddWorkspace value) addWorkspace,
    required TResult Function(RemoveWorkspace value) deleteWorkspace,
    required TResult Function(DeleteAllCheckedToDosInWorkspace value)
        deleteAllCheckedToDosInWorkspace,
    required TResult Function(UpdateCurrentWorkspace value) saveCorrWorkspace,
    required TResult Function(ReorderWorkspace value) reorderWorkspace,
  }) {
    return reorderWorkspace(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddWorkspace value)? addWorkspace,
    TResult? Function(RemoveWorkspace value)? deleteWorkspace,
    TResult? Function(DeleteAllCheckedToDosInWorkspace value)?
        deleteAllCheckedToDosInWorkspace,
    TResult? Function(UpdateCurrentWorkspace value)? saveCorrWorkspace,
    TResult? Function(ReorderWorkspace value)? reorderWorkspace,
  }) {
    return reorderWorkspace?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddWorkspace value)? addWorkspace,
    TResult Function(RemoveWorkspace value)? deleteWorkspace,
    TResult Function(DeleteAllCheckedToDosInWorkspace value)?
        deleteAllCheckedToDosInWorkspace,
    TResult Function(UpdateCurrentWorkspace value)? saveCorrWorkspace,
    TResult Function(ReorderWorkspace value)? reorderWorkspace,
    required TResult orElse(),
  }) {
    if (reorderWorkspace != null) {
      return reorderWorkspace(this);
    }
    return orElse();
  }
}

abstract class ReorderWorkspace implements TLWorkspaceAction {
  const factory ReorderWorkspace(
      {required final int oldIndex,
      required final int newIndex}) = _$ReorderWorkspaceImpl;

  int get oldIndex;
  int get newIndex;

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReorderWorkspaceImplCopyWith<_$ReorderWorkspaceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
