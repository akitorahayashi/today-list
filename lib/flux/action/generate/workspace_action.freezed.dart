// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../workspace_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WorkspaceAction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TLWorkspace newWorkspace) addWorkspace,
    required TResult Function(String workspaceId) deleteWorkspace,
    required TResult Function(TLWorkspace workspace)
        deleteAllCheckedToDosInWorkspace,
    required TResult Function(TLWorkspace workspace) updateWorkspace,
    required TResult Function(int oldIndex, int newIndex) reorderWorkspace,
    required TResult Function(List<TLWorkspace> workspaces)
        deleteAllCheckedToDosInToday,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult? Function(String workspaceId)? deleteWorkspace,
    TResult? Function(TLWorkspace workspace)? deleteAllCheckedToDosInWorkspace,
    TResult? Function(TLWorkspace workspace)? updateWorkspace,
    TResult? Function(int oldIndex, int newIndex)? reorderWorkspace,
    TResult? Function(List<TLWorkspace> workspaces)?
        deleteAllCheckedToDosInToday,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult Function(String workspaceId)? deleteWorkspace,
    TResult Function(TLWorkspace workspace)? deleteAllCheckedToDosInWorkspace,
    TResult Function(TLWorkspace workspace)? updateWorkspace,
    TResult Function(int oldIndex, int newIndex)? reorderWorkspace,
    TResult Function(List<TLWorkspace> workspaces)?
        deleteAllCheckedToDosInToday,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddWorkspace value) addWorkspace,
    required TResult Function(DeleteWorkspace value) deleteWorkspace,
    required TResult Function(DeleteAllCheckedToDosInWorkspace value)
        deleteAllCheckedToDosInWorkspace,
    required TResult Function(UpdateWorkspace value) updateWorkspace,
    required TResult Function(ReorderWorkspace value) reorderWorkspace,
    required TResult Function(DeleteAllCheckedToDosInToday value)
        deleteAllCheckedToDosInToday,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddWorkspace value)? addWorkspace,
    TResult? Function(DeleteWorkspace value)? deleteWorkspace,
    TResult? Function(DeleteAllCheckedToDosInWorkspace value)?
        deleteAllCheckedToDosInWorkspace,
    TResult? Function(UpdateWorkspace value)? updateWorkspace,
    TResult? Function(ReorderWorkspace value)? reorderWorkspace,
    TResult? Function(DeleteAllCheckedToDosInToday value)?
        deleteAllCheckedToDosInToday,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddWorkspace value)? addWorkspace,
    TResult Function(DeleteWorkspace value)? deleteWorkspace,
    TResult Function(DeleteAllCheckedToDosInWorkspace value)?
        deleteAllCheckedToDosInWorkspace,
    TResult Function(UpdateWorkspace value)? updateWorkspace,
    TResult Function(ReorderWorkspace value)? reorderWorkspace,
    TResult Function(DeleteAllCheckedToDosInToday value)?
        deleteAllCheckedToDosInToday,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkspaceActionCopyWith<$Res> {
  factory $WorkspaceActionCopyWith(
          WorkspaceAction value, $Res Function(WorkspaceAction) then) =
      _$WorkspaceActionCopyWithImpl<$Res, WorkspaceAction>;
}

/// @nodoc
class _$WorkspaceActionCopyWithImpl<$Res, $Val extends WorkspaceAction>
    implements $WorkspaceActionCopyWith<$Res> {
  _$WorkspaceActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkspaceAction
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
    extends _$WorkspaceActionCopyWithImpl<$Res, _$AddWorkspaceImpl>
    implements _$$AddWorkspaceImplCopyWith<$Res> {
  __$$AddWorkspaceImplCopyWithImpl(
      _$AddWorkspaceImpl _value, $Res Function(_$AddWorkspaceImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkspaceAction
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

  /// Create a copy of WorkspaceAction
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
    return 'WorkspaceAction.addWorkspace(newWorkspace: $newWorkspace)';
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

  /// Create a copy of WorkspaceAction
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
    required TResult Function(String workspaceId) deleteWorkspace,
    required TResult Function(TLWorkspace workspace)
        deleteAllCheckedToDosInWorkspace,
    required TResult Function(TLWorkspace workspace) updateWorkspace,
    required TResult Function(int oldIndex, int newIndex) reorderWorkspace,
    required TResult Function(List<TLWorkspace> workspaces)
        deleteAllCheckedToDosInToday,
  }) {
    return addWorkspace(newWorkspace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult? Function(String workspaceId)? deleteWorkspace,
    TResult? Function(TLWorkspace workspace)? deleteAllCheckedToDosInWorkspace,
    TResult? Function(TLWorkspace workspace)? updateWorkspace,
    TResult? Function(int oldIndex, int newIndex)? reorderWorkspace,
    TResult? Function(List<TLWorkspace> workspaces)?
        deleteAllCheckedToDosInToday,
  }) {
    return addWorkspace?.call(newWorkspace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult Function(String workspaceId)? deleteWorkspace,
    TResult Function(TLWorkspace workspace)? deleteAllCheckedToDosInWorkspace,
    TResult Function(TLWorkspace workspace)? updateWorkspace,
    TResult Function(int oldIndex, int newIndex)? reorderWorkspace,
    TResult Function(List<TLWorkspace> workspaces)?
        deleteAllCheckedToDosInToday,
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
    required TResult Function(DeleteWorkspace value) deleteWorkspace,
    required TResult Function(DeleteAllCheckedToDosInWorkspace value)
        deleteAllCheckedToDosInWorkspace,
    required TResult Function(UpdateWorkspace value) updateWorkspace,
    required TResult Function(ReorderWorkspace value) reorderWorkspace,
    required TResult Function(DeleteAllCheckedToDosInToday value)
        deleteAllCheckedToDosInToday,
  }) {
    return addWorkspace(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddWorkspace value)? addWorkspace,
    TResult? Function(DeleteWorkspace value)? deleteWorkspace,
    TResult? Function(DeleteAllCheckedToDosInWorkspace value)?
        deleteAllCheckedToDosInWorkspace,
    TResult? Function(UpdateWorkspace value)? updateWorkspace,
    TResult? Function(ReorderWorkspace value)? reorderWorkspace,
    TResult? Function(DeleteAllCheckedToDosInToday value)?
        deleteAllCheckedToDosInToday,
  }) {
    return addWorkspace?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddWorkspace value)? addWorkspace,
    TResult Function(DeleteWorkspace value)? deleteWorkspace,
    TResult Function(DeleteAllCheckedToDosInWorkspace value)?
        deleteAllCheckedToDosInWorkspace,
    TResult Function(UpdateWorkspace value)? updateWorkspace,
    TResult Function(ReorderWorkspace value)? reorderWorkspace,
    TResult Function(DeleteAllCheckedToDosInToday value)?
        deleteAllCheckedToDosInToday,
    required TResult orElse(),
  }) {
    if (addWorkspace != null) {
      return addWorkspace(this);
    }
    return orElse();
  }
}

abstract class AddWorkspace implements WorkspaceAction {
  const factory AddWorkspace(final TLWorkspace newWorkspace) =
      _$AddWorkspaceImpl;

  TLWorkspace get newWorkspace;

  /// Create a copy of WorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddWorkspaceImplCopyWith<_$AddWorkspaceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteWorkspaceImplCopyWith<$Res> {
  factory _$$DeleteWorkspaceImplCopyWith(_$DeleteWorkspaceImpl value,
          $Res Function(_$DeleteWorkspaceImpl) then) =
      __$$DeleteWorkspaceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String workspaceId});
}

/// @nodoc
class __$$DeleteWorkspaceImplCopyWithImpl<$Res>
    extends _$WorkspaceActionCopyWithImpl<$Res, _$DeleteWorkspaceImpl>
    implements _$$DeleteWorkspaceImplCopyWith<$Res> {
  __$$DeleteWorkspaceImplCopyWithImpl(
      _$DeleteWorkspaceImpl _value, $Res Function(_$DeleteWorkspaceImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workspaceId = null,
  }) {
    return _then(_$DeleteWorkspaceImpl(
      null == workspaceId
          ? _value.workspaceId
          : workspaceId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeleteWorkspaceImpl implements DeleteWorkspace {
  const _$DeleteWorkspaceImpl(this.workspaceId);

  @override
  final String workspaceId;

  @override
  String toString() {
    return 'WorkspaceAction.deleteWorkspace(workspaceId: $workspaceId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteWorkspaceImpl &&
            (identical(other.workspaceId, workspaceId) ||
                other.workspaceId == workspaceId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, workspaceId);

  /// Create a copy of WorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteWorkspaceImplCopyWith<_$DeleteWorkspaceImpl> get copyWith =>
      __$$DeleteWorkspaceImplCopyWithImpl<_$DeleteWorkspaceImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TLWorkspace newWorkspace) addWorkspace,
    required TResult Function(String workspaceId) deleteWorkspace,
    required TResult Function(TLWorkspace workspace)
        deleteAllCheckedToDosInWorkspace,
    required TResult Function(TLWorkspace workspace) updateWorkspace,
    required TResult Function(int oldIndex, int newIndex) reorderWorkspace,
    required TResult Function(List<TLWorkspace> workspaces)
        deleteAllCheckedToDosInToday,
  }) {
    return deleteWorkspace(workspaceId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult? Function(String workspaceId)? deleteWorkspace,
    TResult? Function(TLWorkspace workspace)? deleteAllCheckedToDosInWorkspace,
    TResult? Function(TLWorkspace workspace)? updateWorkspace,
    TResult? Function(int oldIndex, int newIndex)? reorderWorkspace,
    TResult? Function(List<TLWorkspace> workspaces)?
        deleteAllCheckedToDosInToday,
  }) {
    return deleteWorkspace?.call(workspaceId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult Function(String workspaceId)? deleteWorkspace,
    TResult Function(TLWorkspace workspace)? deleteAllCheckedToDosInWorkspace,
    TResult Function(TLWorkspace workspace)? updateWorkspace,
    TResult Function(int oldIndex, int newIndex)? reorderWorkspace,
    TResult Function(List<TLWorkspace> workspaces)?
        deleteAllCheckedToDosInToday,
    required TResult orElse(),
  }) {
    if (deleteWorkspace != null) {
      return deleteWorkspace(workspaceId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddWorkspace value) addWorkspace,
    required TResult Function(DeleteWorkspace value) deleteWorkspace,
    required TResult Function(DeleteAllCheckedToDosInWorkspace value)
        deleteAllCheckedToDosInWorkspace,
    required TResult Function(UpdateWorkspace value) updateWorkspace,
    required TResult Function(ReorderWorkspace value) reorderWorkspace,
    required TResult Function(DeleteAllCheckedToDosInToday value)
        deleteAllCheckedToDosInToday,
  }) {
    return deleteWorkspace(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddWorkspace value)? addWorkspace,
    TResult? Function(DeleteWorkspace value)? deleteWorkspace,
    TResult? Function(DeleteAllCheckedToDosInWorkspace value)?
        deleteAllCheckedToDosInWorkspace,
    TResult? Function(UpdateWorkspace value)? updateWorkspace,
    TResult? Function(ReorderWorkspace value)? reorderWorkspace,
    TResult? Function(DeleteAllCheckedToDosInToday value)?
        deleteAllCheckedToDosInToday,
  }) {
    return deleteWorkspace?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddWorkspace value)? addWorkspace,
    TResult Function(DeleteWorkspace value)? deleteWorkspace,
    TResult Function(DeleteAllCheckedToDosInWorkspace value)?
        deleteAllCheckedToDosInWorkspace,
    TResult Function(UpdateWorkspace value)? updateWorkspace,
    TResult Function(ReorderWorkspace value)? reorderWorkspace,
    TResult Function(DeleteAllCheckedToDosInToday value)?
        deleteAllCheckedToDosInToday,
    required TResult orElse(),
  }) {
    if (deleteWorkspace != null) {
      return deleteWorkspace(this);
    }
    return orElse();
  }
}

abstract class DeleteWorkspace implements WorkspaceAction {
  const factory DeleteWorkspace(final String workspaceId) =
      _$DeleteWorkspaceImpl;

  String get workspaceId;

  /// Create a copy of WorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteWorkspaceImplCopyWith<_$DeleteWorkspaceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteAllCheckedToDosInWorkspaceImplCopyWith<$Res> {
  factory _$$DeleteAllCheckedToDosInWorkspaceImplCopyWith(
          _$DeleteAllCheckedToDosInWorkspaceImpl value,
          $Res Function(_$DeleteAllCheckedToDosInWorkspaceImpl) then) =
      __$$DeleteAllCheckedToDosInWorkspaceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TLWorkspace workspace});

  $TLWorkspaceCopyWith<$Res> get workspace;
}

/// @nodoc
class __$$DeleteAllCheckedToDosInWorkspaceImplCopyWithImpl<$Res>
    extends _$WorkspaceActionCopyWithImpl<$Res,
        _$DeleteAllCheckedToDosInWorkspaceImpl>
    implements _$$DeleteAllCheckedToDosInWorkspaceImplCopyWith<$Res> {
  __$$DeleteAllCheckedToDosInWorkspaceImplCopyWithImpl(
      _$DeleteAllCheckedToDosInWorkspaceImpl _value,
      $Res Function(_$DeleteAllCheckedToDosInWorkspaceImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workspace = null,
  }) {
    return _then(_$DeleteAllCheckedToDosInWorkspaceImpl(
      null == workspace
          ? _value.workspace
          : workspace // ignore: cast_nullable_to_non_nullable
              as TLWorkspace,
    ));
  }

  /// Create a copy of WorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLWorkspaceCopyWith<$Res> get workspace {
    return $TLWorkspaceCopyWith<$Res>(_value.workspace, (value) {
      return _then(_value.copyWith(workspace: value));
    });
  }
}

/// @nodoc

class _$DeleteAllCheckedToDosInWorkspaceImpl
    implements DeleteAllCheckedToDosInWorkspace {
  const _$DeleteAllCheckedToDosInWorkspaceImpl(this.workspace);

  @override
  final TLWorkspace workspace;

  @override
  String toString() {
    return 'WorkspaceAction.deleteAllCheckedToDosInWorkspace(workspace: $workspace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteAllCheckedToDosInWorkspaceImpl &&
            (identical(other.workspace, workspace) ||
                other.workspace == workspace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, workspace);

  /// Create a copy of WorkspaceAction
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
    required TResult Function(String workspaceId) deleteWorkspace,
    required TResult Function(TLWorkspace workspace)
        deleteAllCheckedToDosInWorkspace,
    required TResult Function(TLWorkspace workspace) updateWorkspace,
    required TResult Function(int oldIndex, int newIndex) reorderWorkspace,
    required TResult Function(List<TLWorkspace> workspaces)
        deleteAllCheckedToDosInToday,
  }) {
    return deleteAllCheckedToDosInWorkspace(workspace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult? Function(String workspaceId)? deleteWorkspace,
    TResult? Function(TLWorkspace workspace)? deleteAllCheckedToDosInWorkspace,
    TResult? Function(TLWorkspace workspace)? updateWorkspace,
    TResult? Function(int oldIndex, int newIndex)? reorderWorkspace,
    TResult? Function(List<TLWorkspace> workspaces)?
        deleteAllCheckedToDosInToday,
  }) {
    return deleteAllCheckedToDosInWorkspace?.call(workspace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult Function(String workspaceId)? deleteWorkspace,
    TResult Function(TLWorkspace workspace)? deleteAllCheckedToDosInWorkspace,
    TResult Function(TLWorkspace workspace)? updateWorkspace,
    TResult Function(int oldIndex, int newIndex)? reorderWorkspace,
    TResult Function(List<TLWorkspace> workspaces)?
        deleteAllCheckedToDosInToday,
    required TResult orElse(),
  }) {
    if (deleteAllCheckedToDosInWorkspace != null) {
      return deleteAllCheckedToDosInWorkspace(workspace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddWorkspace value) addWorkspace,
    required TResult Function(DeleteWorkspace value) deleteWorkspace,
    required TResult Function(DeleteAllCheckedToDosInWorkspace value)
        deleteAllCheckedToDosInWorkspace,
    required TResult Function(UpdateWorkspace value) updateWorkspace,
    required TResult Function(ReorderWorkspace value) reorderWorkspace,
    required TResult Function(DeleteAllCheckedToDosInToday value)
        deleteAllCheckedToDosInToday,
  }) {
    return deleteAllCheckedToDosInWorkspace(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddWorkspace value)? addWorkspace,
    TResult? Function(DeleteWorkspace value)? deleteWorkspace,
    TResult? Function(DeleteAllCheckedToDosInWorkspace value)?
        deleteAllCheckedToDosInWorkspace,
    TResult? Function(UpdateWorkspace value)? updateWorkspace,
    TResult? Function(ReorderWorkspace value)? reorderWorkspace,
    TResult? Function(DeleteAllCheckedToDosInToday value)?
        deleteAllCheckedToDosInToday,
  }) {
    return deleteAllCheckedToDosInWorkspace?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddWorkspace value)? addWorkspace,
    TResult Function(DeleteWorkspace value)? deleteWorkspace,
    TResult Function(DeleteAllCheckedToDosInWorkspace value)?
        deleteAllCheckedToDosInWorkspace,
    TResult Function(UpdateWorkspace value)? updateWorkspace,
    TResult Function(ReorderWorkspace value)? reorderWorkspace,
    TResult Function(DeleteAllCheckedToDosInToday value)?
        deleteAllCheckedToDosInToday,
    required TResult orElse(),
  }) {
    if (deleteAllCheckedToDosInWorkspace != null) {
      return deleteAllCheckedToDosInWorkspace(this);
    }
    return orElse();
  }
}

abstract class DeleteAllCheckedToDosInWorkspace implements WorkspaceAction {
  const factory DeleteAllCheckedToDosInWorkspace(final TLWorkspace workspace) =
      _$DeleteAllCheckedToDosInWorkspaceImpl;

  TLWorkspace get workspace;

  /// Create a copy of WorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteAllCheckedToDosInWorkspaceImplCopyWith<
          _$DeleteAllCheckedToDosInWorkspaceImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateWorkspaceImplCopyWith<$Res> {
  factory _$$UpdateWorkspaceImplCopyWith(_$UpdateWorkspaceImpl value,
          $Res Function(_$UpdateWorkspaceImpl) then) =
      __$$UpdateWorkspaceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TLWorkspace workspace});

  $TLWorkspaceCopyWith<$Res> get workspace;
}

/// @nodoc
class __$$UpdateWorkspaceImplCopyWithImpl<$Res>
    extends _$WorkspaceActionCopyWithImpl<$Res, _$UpdateWorkspaceImpl>
    implements _$$UpdateWorkspaceImplCopyWith<$Res> {
  __$$UpdateWorkspaceImplCopyWithImpl(
      _$UpdateWorkspaceImpl _value, $Res Function(_$UpdateWorkspaceImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workspace = null,
  }) {
    return _then(_$UpdateWorkspaceImpl(
      null == workspace
          ? _value.workspace
          : workspace // ignore: cast_nullable_to_non_nullable
              as TLWorkspace,
    ));
  }

  /// Create a copy of WorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLWorkspaceCopyWith<$Res> get workspace {
    return $TLWorkspaceCopyWith<$Res>(_value.workspace, (value) {
      return _then(_value.copyWith(workspace: value));
    });
  }
}

/// @nodoc

class _$UpdateWorkspaceImpl implements UpdateWorkspace {
  const _$UpdateWorkspaceImpl(this.workspace);

  @override
  final TLWorkspace workspace;

  @override
  String toString() {
    return 'WorkspaceAction.updateWorkspace(workspace: $workspace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateWorkspaceImpl &&
            (identical(other.workspace, workspace) ||
                other.workspace == workspace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, workspace);

  /// Create a copy of WorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateWorkspaceImplCopyWith<_$UpdateWorkspaceImpl> get copyWith =>
      __$$UpdateWorkspaceImplCopyWithImpl<_$UpdateWorkspaceImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TLWorkspace newWorkspace) addWorkspace,
    required TResult Function(String workspaceId) deleteWorkspace,
    required TResult Function(TLWorkspace workspace)
        deleteAllCheckedToDosInWorkspace,
    required TResult Function(TLWorkspace workspace) updateWorkspace,
    required TResult Function(int oldIndex, int newIndex) reorderWorkspace,
    required TResult Function(List<TLWorkspace> workspaces)
        deleteAllCheckedToDosInToday,
  }) {
    return updateWorkspace(workspace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult? Function(String workspaceId)? deleteWorkspace,
    TResult? Function(TLWorkspace workspace)? deleteAllCheckedToDosInWorkspace,
    TResult? Function(TLWorkspace workspace)? updateWorkspace,
    TResult? Function(int oldIndex, int newIndex)? reorderWorkspace,
    TResult? Function(List<TLWorkspace> workspaces)?
        deleteAllCheckedToDosInToday,
  }) {
    return updateWorkspace?.call(workspace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult Function(String workspaceId)? deleteWorkspace,
    TResult Function(TLWorkspace workspace)? deleteAllCheckedToDosInWorkspace,
    TResult Function(TLWorkspace workspace)? updateWorkspace,
    TResult Function(int oldIndex, int newIndex)? reorderWorkspace,
    TResult Function(List<TLWorkspace> workspaces)?
        deleteAllCheckedToDosInToday,
    required TResult orElse(),
  }) {
    if (updateWorkspace != null) {
      return updateWorkspace(workspace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddWorkspace value) addWorkspace,
    required TResult Function(DeleteWorkspace value) deleteWorkspace,
    required TResult Function(DeleteAllCheckedToDosInWorkspace value)
        deleteAllCheckedToDosInWorkspace,
    required TResult Function(UpdateWorkspace value) updateWorkspace,
    required TResult Function(ReorderWorkspace value) reorderWorkspace,
    required TResult Function(DeleteAllCheckedToDosInToday value)
        deleteAllCheckedToDosInToday,
  }) {
    return updateWorkspace(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddWorkspace value)? addWorkspace,
    TResult? Function(DeleteWorkspace value)? deleteWorkspace,
    TResult? Function(DeleteAllCheckedToDosInWorkspace value)?
        deleteAllCheckedToDosInWorkspace,
    TResult? Function(UpdateWorkspace value)? updateWorkspace,
    TResult? Function(ReorderWorkspace value)? reorderWorkspace,
    TResult? Function(DeleteAllCheckedToDosInToday value)?
        deleteAllCheckedToDosInToday,
  }) {
    return updateWorkspace?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddWorkspace value)? addWorkspace,
    TResult Function(DeleteWorkspace value)? deleteWorkspace,
    TResult Function(DeleteAllCheckedToDosInWorkspace value)?
        deleteAllCheckedToDosInWorkspace,
    TResult Function(UpdateWorkspace value)? updateWorkspace,
    TResult Function(ReorderWorkspace value)? reorderWorkspace,
    TResult Function(DeleteAllCheckedToDosInToday value)?
        deleteAllCheckedToDosInToday,
    required TResult orElse(),
  }) {
    if (updateWorkspace != null) {
      return updateWorkspace(this);
    }
    return orElse();
  }
}

abstract class UpdateWorkspace implements WorkspaceAction {
  const factory UpdateWorkspace(final TLWorkspace workspace) =
      _$UpdateWorkspaceImpl;

  TLWorkspace get workspace;

  /// Create a copy of WorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateWorkspaceImplCopyWith<_$UpdateWorkspaceImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
    extends _$WorkspaceActionCopyWithImpl<$Res, _$ReorderWorkspaceImpl>
    implements _$$ReorderWorkspaceImplCopyWith<$Res> {
  __$$ReorderWorkspaceImplCopyWithImpl(_$ReorderWorkspaceImpl _value,
      $Res Function(_$ReorderWorkspaceImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkspaceAction
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
    return 'WorkspaceAction.reorderWorkspace(oldIndex: $oldIndex, newIndex: $newIndex)';
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

  /// Create a copy of WorkspaceAction
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
    required TResult Function(String workspaceId) deleteWorkspace,
    required TResult Function(TLWorkspace workspace)
        deleteAllCheckedToDosInWorkspace,
    required TResult Function(TLWorkspace workspace) updateWorkspace,
    required TResult Function(int oldIndex, int newIndex) reorderWorkspace,
    required TResult Function(List<TLWorkspace> workspaces)
        deleteAllCheckedToDosInToday,
  }) {
    return reorderWorkspace(oldIndex, newIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult? Function(String workspaceId)? deleteWorkspace,
    TResult? Function(TLWorkspace workspace)? deleteAllCheckedToDosInWorkspace,
    TResult? Function(TLWorkspace workspace)? updateWorkspace,
    TResult? Function(int oldIndex, int newIndex)? reorderWorkspace,
    TResult? Function(List<TLWorkspace> workspaces)?
        deleteAllCheckedToDosInToday,
  }) {
    return reorderWorkspace?.call(oldIndex, newIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult Function(String workspaceId)? deleteWorkspace,
    TResult Function(TLWorkspace workspace)? deleteAllCheckedToDosInWorkspace,
    TResult Function(TLWorkspace workspace)? updateWorkspace,
    TResult Function(int oldIndex, int newIndex)? reorderWorkspace,
    TResult Function(List<TLWorkspace> workspaces)?
        deleteAllCheckedToDosInToday,
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
    required TResult Function(DeleteWorkspace value) deleteWorkspace,
    required TResult Function(DeleteAllCheckedToDosInWorkspace value)
        deleteAllCheckedToDosInWorkspace,
    required TResult Function(UpdateWorkspace value) updateWorkspace,
    required TResult Function(ReorderWorkspace value) reorderWorkspace,
    required TResult Function(DeleteAllCheckedToDosInToday value)
        deleteAllCheckedToDosInToday,
  }) {
    return reorderWorkspace(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddWorkspace value)? addWorkspace,
    TResult? Function(DeleteWorkspace value)? deleteWorkspace,
    TResult? Function(DeleteAllCheckedToDosInWorkspace value)?
        deleteAllCheckedToDosInWorkspace,
    TResult? Function(UpdateWorkspace value)? updateWorkspace,
    TResult? Function(ReorderWorkspace value)? reorderWorkspace,
    TResult? Function(DeleteAllCheckedToDosInToday value)?
        deleteAllCheckedToDosInToday,
  }) {
    return reorderWorkspace?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddWorkspace value)? addWorkspace,
    TResult Function(DeleteWorkspace value)? deleteWorkspace,
    TResult Function(DeleteAllCheckedToDosInWorkspace value)?
        deleteAllCheckedToDosInWorkspace,
    TResult Function(UpdateWorkspace value)? updateWorkspace,
    TResult Function(ReorderWorkspace value)? reorderWorkspace,
    TResult Function(DeleteAllCheckedToDosInToday value)?
        deleteAllCheckedToDosInToday,
    required TResult orElse(),
  }) {
    if (reorderWorkspace != null) {
      return reorderWorkspace(this);
    }
    return orElse();
  }
}

abstract class ReorderWorkspace implements WorkspaceAction {
  const factory ReorderWorkspace(
      {required final int oldIndex,
      required final int newIndex}) = _$ReorderWorkspaceImpl;

  int get oldIndex;
  int get newIndex;

  /// Create a copy of WorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReorderWorkspaceImplCopyWith<_$ReorderWorkspaceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteAllCheckedToDosInTodayImplCopyWith<$Res> {
  factory _$$DeleteAllCheckedToDosInTodayImplCopyWith(
          _$DeleteAllCheckedToDosInTodayImpl value,
          $Res Function(_$DeleteAllCheckedToDosInTodayImpl) then) =
      __$$DeleteAllCheckedToDosInTodayImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<TLWorkspace> workspaces});
}

/// @nodoc
class __$$DeleteAllCheckedToDosInTodayImplCopyWithImpl<$Res>
    extends _$WorkspaceActionCopyWithImpl<$Res,
        _$DeleteAllCheckedToDosInTodayImpl>
    implements _$$DeleteAllCheckedToDosInTodayImplCopyWith<$Res> {
  __$$DeleteAllCheckedToDosInTodayImplCopyWithImpl(
      _$DeleteAllCheckedToDosInTodayImpl _value,
      $Res Function(_$DeleteAllCheckedToDosInTodayImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workspaces = null,
  }) {
    return _then(_$DeleteAllCheckedToDosInTodayImpl(
      null == workspaces
          ? _value._workspaces
          : workspaces // ignore: cast_nullable_to_non_nullable
              as List<TLWorkspace>,
    ));
  }
}

/// @nodoc

class _$DeleteAllCheckedToDosInTodayImpl
    implements DeleteAllCheckedToDosInToday {
  const _$DeleteAllCheckedToDosInTodayImpl(final List<TLWorkspace> workspaces)
      : _workspaces = workspaces;

  final List<TLWorkspace> _workspaces;
  @override
  List<TLWorkspace> get workspaces {
    if (_workspaces is EqualUnmodifiableListView) return _workspaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workspaces);
  }

  @override
  String toString() {
    return 'WorkspaceAction.deleteAllCheckedToDosInToday(workspaces: $workspaces)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteAllCheckedToDosInTodayImpl &&
            const DeepCollectionEquality()
                .equals(other._workspaces, _workspaces));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_workspaces));

  /// Create a copy of WorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteAllCheckedToDosInTodayImplCopyWith<
          _$DeleteAllCheckedToDosInTodayImpl>
      get copyWith => __$$DeleteAllCheckedToDosInTodayImplCopyWithImpl<
          _$DeleteAllCheckedToDosInTodayImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TLWorkspace newWorkspace) addWorkspace,
    required TResult Function(String workspaceId) deleteWorkspace,
    required TResult Function(TLWorkspace workspace)
        deleteAllCheckedToDosInWorkspace,
    required TResult Function(TLWorkspace workspace) updateWorkspace,
    required TResult Function(int oldIndex, int newIndex) reorderWorkspace,
    required TResult Function(List<TLWorkspace> workspaces)
        deleteAllCheckedToDosInToday,
  }) {
    return deleteAllCheckedToDosInToday(workspaces);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult? Function(String workspaceId)? deleteWorkspace,
    TResult? Function(TLWorkspace workspace)? deleteAllCheckedToDosInWorkspace,
    TResult? Function(TLWorkspace workspace)? updateWorkspace,
    TResult? Function(int oldIndex, int newIndex)? reorderWorkspace,
    TResult? Function(List<TLWorkspace> workspaces)?
        deleteAllCheckedToDosInToday,
  }) {
    return deleteAllCheckedToDosInToday?.call(workspaces);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace newWorkspace)? addWorkspace,
    TResult Function(String workspaceId)? deleteWorkspace,
    TResult Function(TLWorkspace workspace)? deleteAllCheckedToDosInWorkspace,
    TResult Function(TLWorkspace workspace)? updateWorkspace,
    TResult Function(int oldIndex, int newIndex)? reorderWorkspace,
    TResult Function(List<TLWorkspace> workspaces)?
        deleteAllCheckedToDosInToday,
    required TResult orElse(),
  }) {
    if (deleteAllCheckedToDosInToday != null) {
      return deleteAllCheckedToDosInToday(workspaces);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddWorkspace value) addWorkspace,
    required TResult Function(DeleteWorkspace value) deleteWorkspace,
    required TResult Function(DeleteAllCheckedToDosInWorkspace value)
        deleteAllCheckedToDosInWorkspace,
    required TResult Function(UpdateWorkspace value) updateWorkspace,
    required TResult Function(ReorderWorkspace value) reorderWorkspace,
    required TResult Function(DeleteAllCheckedToDosInToday value)
        deleteAllCheckedToDosInToday,
  }) {
    return deleteAllCheckedToDosInToday(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddWorkspace value)? addWorkspace,
    TResult? Function(DeleteWorkspace value)? deleteWorkspace,
    TResult? Function(DeleteAllCheckedToDosInWorkspace value)?
        deleteAllCheckedToDosInWorkspace,
    TResult? Function(UpdateWorkspace value)? updateWorkspace,
    TResult? Function(ReorderWorkspace value)? reorderWorkspace,
    TResult? Function(DeleteAllCheckedToDosInToday value)?
        deleteAllCheckedToDosInToday,
  }) {
    return deleteAllCheckedToDosInToday?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddWorkspace value)? addWorkspace,
    TResult Function(DeleteWorkspace value)? deleteWorkspace,
    TResult Function(DeleteAllCheckedToDosInWorkspace value)?
        deleteAllCheckedToDosInWorkspace,
    TResult Function(UpdateWorkspace value)? updateWorkspace,
    TResult Function(ReorderWorkspace value)? reorderWorkspace,
    TResult Function(DeleteAllCheckedToDosInToday value)?
        deleteAllCheckedToDosInToday,
    required TResult orElse(),
  }) {
    if (deleteAllCheckedToDosInToday != null) {
      return deleteAllCheckedToDosInToday(this);
    }
    return orElse();
  }
}

abstract class DeleteAllCheckedToDosInToday implements WorkspaceAction {
  const factory DeleteAllCheckedToDosInToday(
      final List<TLWorkspace> workspaces) = _$DeleteAllCheckedToDosInTodayImpl;

  List<TLWorkspace> get workspaces;

  /// Create a copy of WorkspaceAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteAllCheckedToDosInTodayImplCopyWith<
          _$DeleteAllCheckedToDosInTodayImpl>
      get copyWith => throw _privateConstructorUsedError;
}
