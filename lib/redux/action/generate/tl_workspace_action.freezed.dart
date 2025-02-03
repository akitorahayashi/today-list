// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../todo/tl_workspace_action.dart';

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
    required TResult Function(int newIndex) changeCurrentWorkspaceIndex,
    required TResult Function(TLWorkspace newWorkspace) addWorkspace,
    required TResult Function(String workspaceId) removeWorkspace,
    required TResult Function(TLWorkspace updatedWorkspace)
        updateCurrentWorkspace,
    required TResult Function(List<TLWorkspace> updatedWorkspaceList)
        updateWorkspaceList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int newIndex)? changeCurrentWorkspaceIndex,
    TResult? Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult? Function(String workspaceId)? removeWorkspace,
    TResult? Function(TLWorkspace updatedWorkspace)? updateCurrentWorkspace,
    TResult? Function(List<TLWorkspace> updatedWorkspaceList)?
        updateWorkspaceList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int newIndex)? changeCurrentWorkspaceIndex,
    TResult Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult Function(String workspaceId)? removeWorkspace,
    TResult Function(TLWorkspace updatedWorkspace)? updateCurrentWorkspace,
    TResult Function(List<TLWorkspace> updatedWorkspaceList)?
        updateWorkspaceList,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangeCurrentWorkspaceIndex value)
        changeCurrentWorkspaceIndex,
    required TResult Function(AddWorkspace value) addWorkspace,
    required TResult Function(RemoveWorkspace value) removeWorkspace,
    required TResult Function(UpdateCurrentWorkspace value)
        updateCurrentWorkspace,
    required TResult Function(UpdateWorkspaceList value) updateWorkspaceList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangeCurrentWorkspaceIndex value)?
        changeCurrentWorkspaceIndex,
    TResult? Function(AddWorkspace value)? addWorkspace,
    TResult? Function(RemoveWorkspace value)? removeWorkspace,
    TResult? Function(UpdateCurrentWorkspace value)? updateCurrentWorkspace,
    TResult? Function(UpdateWorkspaceList value)? updateWorkspaceList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangeCurrentWorkspaceIndex value)?
        changeCurrentWorkspaceIndex,
    TResult Function(AddWorkspace value)? addWorkspace,
    TResult Function(RemoveWorkspace value)? removeWorkspace,
    TResult Function(UpdateCurrentWorkspace value)? updateCurrentWorkspace,
    TResult Function(UpdateWorkspaceList value)? updateWorkspaceList,
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
abstract class _$$ChangeCurrentWorkspaceIndexImplCopyWith<$Res> {
  factory _$$ChangeCurrentWorkspaceIndexImplCopyWith(
          _$ChangeCurrentWorkspaceIndexImpl value,
          $Res Function(_$ChangeCurrentWorkspaceIndexImpl) then) =
      __$$ChangeCurrentWorkspaceIndexImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int newIndex});
}

/// @nodoc
class __$$ChangeCurrentWorkspaceIndexImplCopyWithImpl<$Res>
    extends _$TLWorkspaceActionCopyWithImpl<$Res,
        _$ChangeCurrentWorkspaceIndexImpl>
    implements _$$ChangeCurrentWorkspaceIndexImplCopyWith<$Res> {
  __$$ChangeCurrentWorkspaceIndexImplCopyWithImpl(
      _$ChangeCurrentWorkspaceIndexImpl _value,
      $Res Function(_$ChangeCurrentWorkspaceIndexImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newIndex = null,
  }) {
    return _then(_$ChangeCurrentWorkspaceIndexImpl(
      null == newIndex
          ? _value.newIndex
          : newIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ChangeCurrentWorkspaceIndexImpl implements ChangeCurrentWorkspaceIndex {
  const _$ChangeCurrentWorkspaceIndexImpl(this.newIndex);

  @override
  final int newIndex;

  @override
  String toString() {
    return 'TLWorkspaceAction.changeCurrentWorkspaceIndex(newIndex: $newIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeCurrentWorkspaceIndexImpl &&
            (identical(other.newIndex, newIndex) ||
                other.newIndex == newIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newIndex);

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeCurrentWorkspaceIndexImplCopyWith<_$ChangeCurrentWorkspaceIndexImpl>
      get copyWith => __$$ChangeCurrentWorkspaceIndexImplCopyWithImpl<
          _$ChangeCurrentWorkspaceIndexImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int newIndex) changeCurrentWorkspaceIndex,
    required TResult Function(TLWorkspace newWorkspace) addWorkspace,
    required TResult Function(String workspaceId) removeWorkspace,
    required TResult Function(TLWorkspace updatedWorkspace)
        updateCurrentWorkspace,
    required TResult Function(List<TLWorkspace> updatedWorkspaceList)
        updateWorkspaceList,
  }) {
    return changeCurrentWorkspaceIndex(newIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int newIndex)? changeCurrentWorkspaceIndex,
    TResult? Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult? Function(String workspaceId)? removeWorkspace,
    TResult? Function(TLWorkspace updatedWorkspace)? updateCurrentWorkspace,
    TResult? Function(List<TLWorkspace> updatedWorkspaceList)?
        updateWorkspaceList,
  }) {
    return changeCurrentWorkspaceIndex?.call(newIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int newIndex)? changeCurrentWorkspaceIndex,
    TResult Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult Function(String workspaceId)? removeWorkspace,
    TResult Function(TLWorkspace updatedWorkspace)? updateCurrentWorkspace,
    TResult Function(List<TLWorkspace> updatedWorkspaceList)?
        updateWorkspaceList,
    required TResult orElse(),
  }) {
    if (changeCurrentWorkspaceIndex != null) {
      return changeCurrentWorkspaceIndex(newIndex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangeCurrentWorkspaceIndex value)
        changeCurrentWorkspaceIndex,
    required TResult Function(AddWorkspace value) addWorkspace,
    required TResult Function(RemoveWorkspace value) removeWorkspace,
    required TResult Function(UpdateCurrentWorkspace value)
        updateCurrentWorkspace,
    required TResult Function(UpdateWorkspaceList value) updateWorkspaceList,
  }) {
    return changeCurrentWorkspaceIndex(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangeCurrentWorkspaceIndex value)?
        changeCurrentWorkspaceIndex,
    TResult? Function(AddWorkspace value)? addWorkspace,
    TResult? Function(RemoveWorkspace value)? removeWorkspace,
    TResult? Function(UpdateCurrentWorkspace value)? updateCurrentWorkspace,
    TResult? Function(UpdateWorkspaceList value)? updateWorkspaceList,
  }) {
    return changeCurrentWorkspaceIndex?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangeCurrentWorkspaceIndex value)?
        changeCurrentWorkspaceIndex,
    TResult Function(AddWorkspace value)? addWorkspace,
    TResult Function(RemoveWorkspace value)? removeWorkspace,
    TResult Function(UpdateCurrentWorkspace value)? updateCurrentWorkspace,
    TResult Function(UpdateWorkspaceList value)? updateWorkspaceList,
    required TResult orElse(),
  }) {
    if (changeCurrentWorkspaceIndex != null) {
      return changeCurrentWorkspaceIndex(this);
    }
    return orElse();
  }
}

abstract class ChangeCurrentWorkspaceIndex implements TLWorkspaceAction {
  const factory ChangeCurrentWorkspaceIndex(final int newIndex) =
      _$ChangeCurrentWorkspaceIndexImpl;

  int get newIndex;

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangeCurrentWorkspaceIndexImplCopyWith<_$ChangeCurrentWorkspaceIndexImpl>
      get copyWith => throw _privateConstructorUsedError;
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
    required TResult Function(int newIndex) changeCurrentWorkspaceIndex,
    required TResult Function(TLWorkspace newWorkspace) addWorkspace,
    required TResult Function(String workspaceId) removeWorkspace,
    required TResult Function(TLWorkspace updatedWorkspace)
        updateCurrentWorkspace,
    required TResult Function(List<TLWorkspace> updatedWorkspaceList)
        updateWorkspaceList,
  }) {
    return addWorkspace(newWorkspace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int newIndex)? changeCurrentWorkspaceIndex,
    TResult? Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult? Function(String workspaceId)? removeWorkspace,
    TResult? Function(TLWorkspace updatedWorkspace)? updateCurrentWorkspace,
    TResult? Function(List<TLWorkspace> updatedWorkspaceList)?
        updateWorkspaceList,
  }) {
    return addWorkspace?.call(newWorkspace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int newIndex)? changeCurrentWorkspaceIndex,
    TResult Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult Function(String workspaceId)? removeWorkspace,
    TResult Function(TLWorkspace updatedWorkspace)? updateCurrentWorkspace,
    TResult Function(List<TLWorkspace> updatedWorkspaceList)?
        updateWorkspaceList,
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
    required TResult Function(ChangeCurrentWorkspaceIndex value)
        changeCurrentWorkspaceIndex,
    required TResult Function(AddWorkspace value) addWorkspace,
    required TResult Function(RemoveWorkspace value) removeWorkspace,
    required TResult Function(UpdateCurrentWorkspace value)
        updateCurrentWorkspace,
    required TResult Function(UpdateWorkspaceList value) updateWorkspaceList,
  }) {
    return addWorkspace(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangeCurrentWorkspaceIndex value)?
        changeCurrentWorkspaceIndex,
    TResult? Function(AddWorkspace value)? addWorkspace,
    TResult? Function(RemoveWorkspace value)? removeWorkspace,
    TResult? Function(UpdateCurrentWorkspace value)? updateCurrentWorkspace,
    TResult? Function(UpdateWorkspaceList value)? updateWorkspaceList,
  }) {
    return addWorkspace?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangeCurrentWorkspaceIndex value)?
        changeCurrentWorkspaceIndex,
    TResult Function(AddWorkspace value)? addWorkspace,
    TResult Function(RemoveWorkspace value)? removeWorkspace,
    TResult Function(UpdateCurrentWorkspace value)? updateCurrentWorkspace,
    TResult Function(UpdateWorkspaceList value)? updateWorkspaceList,
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
  $Res call({String workspaceId});
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
    Object? workspaceId = null,
  }) {
    return _then(_$RemoveWorkspaceImpl(
      null == workspaceId
          ? _value.workspaceId
          : workspaceId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RemoveWorkspaceImpl implements RemoveWorkspace {
  const _$RemoveWorkspaceImpl(this.workspaceId);

  @override
  final String workspaceId;

  @override
  String toString() {
    return 'TLWorkspaceAction.removeWorkspace(workspaceId: $workspaceId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveWorkspaceImpl &&
            (identical(other.workspaceId, workspaceId) ||
                other.workspaceId == workspaceId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, workspaceId);

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
    required TResult Function(int newIndex) changeCurrentWorkspaceIndex,
    required TResult Function(TLWorkspace newWorkspace) addWorkspace,
    required TResult Function(String workspaceId) removeWorkspace,
    required TResult Function(TLWorkspace updatedWorkspace)
        updateCurrentWorkspace,
    required TResult Function(List<TLWorkspace> updatedWorkspaceList)
        updateWorkspaceList,
  }) {
    return removeWorkspace(workspaceId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int newIndex)? changeCurrentWorkspaceIndex,
    TResult? Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult? Function(String workspaceId)? removeWorkspace,
    TResult? Function(TLWorkspace updatedWorkspace)? updateCurrentWorkspace,
    TResult? Function(List<TLWorkspace> updatedWorkspaceList)?
        updateWorkspaceList,
  }) {
    return removeWorkspace?.call(workspaceId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int newIndex)? changeCurrentWorkspaceIndex,
    TResult Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult Function(String workspaceId)? removeWorkspace,
    TResult Function(TLWorkspace updatedWorkspace)? updateCurrentWorkspace,
    TResult Function(List<TLWorkspace> updatedWorkspaceList)?
        updateWorkspaceList,
    required TResult orElse(),
  }) {
    if (removeWorkspace != null) {
      return removeWorkspace(workspaceId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangeCurrentWorkspaceIndex value)
        changeCurrentWorkspaceIndex,
    required TResult Function(AddWorkspace value) addWorkspace,
    required TResult Function(RemoveWorkspace value) removeWorkspace,
    required TResult Function(UpdateCurrentWorkspace value)
        updateCurrentWorkspace,
    required TResult Function(UpdateWorkspaceList value) updateWorkspaceList,
  }) {
    return removeWorkspace(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangeCurrentWorkspaceIndex value)?
        changeCurrentWorkspaceIndex,
    TResult? Function(AddWorkspace value)? addWorkspace,
    TResult? Function(RemoveWorkspace value)? removeWorkspace,
    TResult? Function(UpdateCurrentWorkspace value)? updateCurrentWorkspace,
    TResult? Function(UpdateWorkspaceList value)? updateWorkspaceList,
  }) {
    return removeWorkspace?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangeCurrentWorkspaceIndex value)?
        changeCurrentWorkspaceIndex,
    TResult Function(AddWorkspace value)? addWorkspace,
    TResult Function(RemoveWorkspace value)? removeWorkspace,
    TResult Function(UpdateCurrentWorkspace value)? updateCurrentWorkspace,
    TResult Function(UpdateWorkspaceList value)? updateWorkspaceList,
    required TResult orElse(),
  }) {
    if (removeWorkspace != null) {
      return removeWorkspace(this);
    }
    return orElse();
  }
}

abstract class RemoveWorkspace implements TLWorkspaceAction {
  const factory RemoveWorkspace(final String workspaceId) =
      _$RemoveWorkspaceImpl;

  String get workspaceId;

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveWorkspaceImplCopyWith<_$RemoveWorkspaceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateCurrentWorkspaceImplCopyWith<$Res> {
  factory _$$UpdateCurrentWorkspaceImplCopyWith(
          _$UpdateCurrentWorkspaceImpl value,
          $Res Function(_$UpdateCurrentWorkspaceImpl) then) =
      __$$UpdateCurrentWorkspaceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TLWorkspace updatedWorkspace});

  $TLWorkspaceCopyWith<$Res> get updatedWorkspace;
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
    Object? updatedWorkspace = null,
  }) {
    return _then(_$UpdateCurrentWorkspaceImpl(
      null == updatedWorkspace
          ? _value.updatedWorkspace
          : updatedWorkspace // ignore: cast_nullable_to_non_nullable
              as TLWorkspace,
    ));
  }

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLWorkspaceCopyWith<$Res> get updatedWorkspace {
    return $TLWorkspaceCopyWith<$Res>(_value.updatedWorkspace, (value) {
      return _then(_value.copyWith(updatedWorkspace: value));
    });
  }
}

/// @nodoc

class _$UpdateCurrentWorkspaceImpl implements UpdateCurrentWorkspace {
  const _$UpdateCurrentWorkspaceImpl(this.updatedWorkspace);

  @override
  final TLWorkspace updatedWorkspace;

  @override
  String toString() {
    return 'TLWorkspaceAction.updateCurrentWorkspace(updatedWorkspace: $updatedWorkspace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateCurrentWorkspaceImpl &&
            (identical(other.updatedWorkspace, updatedWorkspace) ||
                other.updatedWorkspace == updatedWorkspace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, updatedWorkspace);

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
    required TResult Function(int newIndex) changeCurrentWorkspaceIndex,
    required TResult Function(TLWorkspace newWorkspace) addWorkspace,
    required TResult Function(String workspaceId) removeWorkspace,
    required TResult Function(TLWorkspace updatedWorkspace)
        updateCurrentWorkspace,
    required TResult Function(List<TLWorkspace> updatedWorkspaceList)
        updateWorkspaceList,
  }) {
    return updateCurrentWorkspace(updatedWorkspace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int newIndex)? changeCurrentWorkspaceIndex,
    TResult? Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult? Function(String workspaceId)? removeWorkspace,
    TResult? Function(TLWorkspace updatedWorkspace)? updateCurrentWorkspace,
    TResult? Function(List<TLWorkspace> updatedWorkspaceList)?
        updateWorkspaceList,
  }) {
    return updateCurrentWorkspace?.call(updatedWorkspace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int newIndex)? changeCurrentWorkspaceIndex,
    TResult Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult Function(String workspaceId)? removeWorkspace,
    TResult Function(TLWorkspace updatedWorkspace)? updateCurrentWorkspace,
    TResult Function(List<TLWorkspace> updatedWorkspaceList)?
        updateWorkspaceList,
    required TResult orElse(),
  }) {
    if (updateCurrentWorkspace != null) {
      return updateCurrentWorkspace(updatedWorkspace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangeCurrentWorkspaceIndex value)
        changeCurrentWorkspaceIndex,
    required TResult Function(AddWorkspace value) addWorkspace,
    required TResult Function(RemoveWorkspace value) removeWorkspace,
    required TResult Function(UpdateCurrentWorkspace value)
        updateCurrentWorkspace,
    required TResult Function(UpdateWorkspaceList value) updateWorkspaceList,
  }) {
    return updateCurrentWorkspace(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangeCurrentWorkspaceIndex value)?
        changeCurrentWorkspaceIndex,
    TResult? Function(AddWorkspace value)? addWorkspace,
    TResult? Function(RemoveWorkspace value)? removeWorkspace,
    TResult? Function(UpdateCurrentWorkspace value)? updateCurrentWorkspace,
    TResult? Function(UpdateWorkspaceList value)? updateWorkspaceList,
  }) {
    return updateCurrentWorkspace?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangeCurrentWorkspaceIndex value)?
        changeCurrentWorkspaceIndex,
    TResult Function(AddWorkspace value)? addWorkspace,
    TResult Function(RemoveWorkspace value)? removeWorkspace,
    TResult Function(UpdateCurrentWorkspace value)? updateCurrentWorkspace,
    TResult Function(UpdateWorkspaceList value)? updateWorkspaceList,
    required TResult orElse(),
  }) {
    if (updateCurrentWorkspace != null) {
      return updateCurrentWorkspace(this);
    }
    return orElse();
  }
}

abstract class UpdateCurrentWorkspace implements TLWorkspaceAction {
  const factory UpdateCurrentWorkspace(final TLWorkspace updatedWorkspace) =
      _$UpdateCurrentWorkspaceImpl;

  TLWorkspace get updatedWorkspace;

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateCurrentWorkspaceImplCopyWith<_$UpdateCurrentWorkspaceImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateWorkspaceListImplCopyWith<$Res> {
  factory _$$UpdateWorkspaceListImplCopyWith(_$UpdateWorkspaceListImpl value,
          $Res Function(_$UpdateWorkspaceListImpl) then) =
      __$$UpdateWorkspaceListImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<TLWorkspace> updatedWorkspaceList});
}

/// @nodoc
class __$$UpdateWorkspaceListImplCopyWithImpl<$Res>
    extends _$TLWorkspaceActionCopyWithImpl<$Res, _$UpdateWorkspaceListImpl>
    implements _$$UpdateWorkspaceListImplCopyWith<$Res> {
  __$$UpdateWorkspaceListImplCopyWithImpl(_$UpdateWorkspaceListImpl _value,
      $Res Function(_$UpdateWorkspaceListImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updatedWorkspaceList = null,
  }) {
    return _then(_$UpdateWorkspaceListImpl(
      null == updatedWorkspaceList
          ? _value._updatedWorkspaceList
          : updatedWorkspaceList // ignore: cast_nullable_to_non_nullable
              as List<TLWorkspace>,
    ));
  }
}

/// @nodoc

class _$UpdateWorkspaceListImpl implements UpdateWorkspaceList {
  const _$UpdateWorkspaceListImpl(final List<TLWorkspace> updatedWorkspaceList)
      : _updatedWorkspaceList = updatedWorkspaceList;

  final List<TLWorkspace> _updatedWorkspaceList;
  @override
  List<TLWorkspace> get updatedWorkspaceList {
    if (_updatedWorkspaceList is EqualUnmodifiableListView)
      return _updatedWorkspaceList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_updatedWorkspaceList);
  }

  @override
  String toString() {
    return 'TLWorkspaceAction.updateWorkspaceList(updatedWorkspaceList: $updatedWorkspaceList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateWorkspaceListImpl &&
            const DeepCollectionEquality()
                .equals(other._updatedWorkspaceList, _updatedWorkspaceList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_updatedWorkspaceList));

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateWorkspaceListImplCopyWith<_$UpdateWorkspaceListImpl> get copyWith =>
      __$$UpdateWorkspaceListImplCopyWithImpl<_$UpdateWorkspaceListImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int newIndex) changeCurrentWorkspaceIndex,
    required TResult Function(TLWorkspace newWorkspace) addWorkspace,
    required TResult Function(String workspaceId) removeWorkspace,
    required TResult Function(TLWorkspace updatedWorkspace)
        updateCurrentWorkspace,
    required TResult Function(List<TLWorkspace> updatedWorkspaceList)
        updateWorkspaceList,
  }) {
    return updateWorkspaceList(updatedWorkspaceList);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int newIndex)? changeCurrentWorkspaceIndex,
    TResult? Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult? Function(String workspaceId)? removeWorkspace,
    TResult? Function(TLWorkspace updatedWorkspace)? updateCurrentWorkspace,
    TResult? Function(List<TLWorkspace> updatedWorkspaceList)?
        updateWorkspaceList,
  }) {
    return updateWorkspaceList?.call(updatedWorkspaceList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int newIndex)? changeCurrentWorkspaceIndex,
    TResult Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult Function(String workspaceId)? removeWorkspace,
    TResult Function(TLWorkspace updatedWorkspace)? updateCurrentWorkspace,
    TResult Function(List<TLWorkspace> updatedWorkspaceList)?
        updateWorkspaceList,
    required TResult orElse(),
  }) {
    if (updateWorkspaceList != null) {
      return updateWorkspaceList(updatedWorkspaceList);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangeCurrentWorkspaceIndex value)
        changeCurrentWorkspaceIndex,
    required TResult Function(AddWorkspace value) addWorkspace,
    required TResult Function(RemoveWorkspace value) removeWorkspace,
    required TResult Function(UpdateCurrentWorkspace value)
        updateCurrentWorkspace,
    required TResult Function(UpdateWorkspaceList value) updateWorkspaceList,
  }) {
    return updateWorkspaceList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangeCurrentWorkspaceIndex value)?
        changeCurrentWorkspaceIndex,
    TResult? Function(AddWorkspace value)? addWorkspace,
    TResult? Function(RemoveWorkspace value)? removeWorkspace,
    TResult? Function(UpdateCurrentWorkspace value)? updateCurrentWorkspace,
    TResult? Function(UpdateWorkspaceList value)? updateWorkspaceList,
  }) {
    return updateWorkspaceList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangeCurrentWorkspaceIndex value)?
        changeCurrentWorkspaceIndex,
    TResult Function(AddWorkspace value)? addWorkspace,
    TResult Function(RemoveWorkspace value)? removeWorkspace,
    TResult Function(UpdateCurrentWorkspace value)? updateCurrentWorkspace,
    TResult Function(UpdateWorkspaceList value)? updateWorkspaceList,
    required TResult orElse(),
  }) {
    if (updateWorkspaceList != null) {
      return updateWorkspaceList(this);
    }
    return orElse();
  }
}

abstract class UpdateWorkspaceList implements TLWorkspaceAction {
  const factory UpdateWorkspaceList(
      final List<TLWorkspace> updatedWorkspaceList) = _$UpdateWorkspaceListImpl;

  List<TLWorkspace> get updatedWorkspaceList;

  /// Create a copy of TLWorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateWorkspaceListImplCopyWith<_$UpdateWorkspaceListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
