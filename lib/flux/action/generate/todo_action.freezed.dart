// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../todo_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TodoAction {
  TLWorkspace get workspace => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TLWorkspace workspace, TLToDo todo) addTodo,
    required TResult Function(TLWorkspace workspace, TLToDo todo) updateTodo,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      bool ifInToday,
    )
    deleteTodo,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      bool ifInToday,
    )
    toggleTodoCheck,
    required TResult Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )
    reorderTodos,
    required TResult Function(TLWorkspace workspace, bool ifInToday)
    deleteAllCheckedTodos,
    required TResult Function(TLWorkspace workspace, TLToDo todo, TLStep step)
    toggleStepCheck,
    required TResult Function(TLWorkspace workspace, TLToDo todo)
    toggleTodoTodayWhenever,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )
    reorderSteps,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace workspace, TLToDo todo)? addTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo)? updateTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    deleteTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    toggleTodoCheck,
    TResult? Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )?
    reorderTodos,
    TResult? Function(TLWorkspace workspace, bool ifInToday)?
    deleteAllCheckedTodos,
    TResult? Function(TLWorkspace workspace, TLToDo todo, TLStep step)?
    toggleStepCheck,
    TResult? Function(TLWorkspace workspace, TLToDo todo)?
    toggleTodoTodayWhenever,
    TResult? Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )?
    reorderSteps,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace workspace, TLToDo todo)? addTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo)? updateTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    deleteTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    toggleTodoCheck,
    TResult Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )?
    reorderTodos,
    TResult Function(TLWorkspace workspace, bool ifInToday)?
    deleteAllCheckedTodos,
    TResult Function(TLWorkspace workspace, TLToDo todo, TLStep step)?
    toggleStepCheck,
    TResult Function(TLWorkspace workspace, TLToDo todo)?
    toggleTodoTodayWhenever,
    TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )?
    reorderSteps,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddTodo value) addTodo,
    required TResult Function(_UpdateTodo value) updateTodo,
    required TResult Function(_DeleteTodo value) deleteTodo,
    required TResult Function(_ToggleTodoCheck value) toggleTodoCheck,
    required TResult Function(_ReorderTodos value) reorderTodos,
    required TResult Function(_DeleteAllCheckedTodos value)
    deleteAllCheckedTodos,
    required TResult Function(_ToggleStepCheck value) toggleStepCheck,
    required TResult Function(_ToggleTodoTodayWhenever value)
    toggleTodoTodayWhenever,
    required TResult Function(_ReorderSteps value) reorderSteps,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddTodo value)? addTodo,
    TResult? Function(_UpdateTodo value)? updateTodo,
    TResult? Function(_DeleteTodo value)? deleteTodo,
    TResult? Function(_ToggleTodoCheck value)? toggleTodoCheck,
    TResult? Function(_ReorderTodos value)? reorderTodos,
    TResult? Function(_DeleteAllCheckedTodos value)? deleteAllCheckedTodos,
    TResult? Function(_ToggleStepCheck value)? toggleStepCheck,
    TResult? Function(_ToggleTodoTodayWhenever value)? toggleTodoTodayWhenever,
    TResult? Function(_ReorderSteps value)? reorderSteps,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddTodo value)? addTodo,
    TResult Function(_UpdateTodo value)? updateTodo,
    TResult Function(_DeleteTodo value)? deleteTodo,
    TResult Function(_ToggleTodoCheck value)? toggleTodoCheck,
    TResult Function(_ReorderTodos value)? reorderTodos,
    TResult Function(_DeleteAllCheckedTodos value)? deleteAllCheckedTodos,
    TResult Function(_ToggleStepCheck value)? toggleStepCheck,
    TResult Function(_ToggleTodoTodayWhenever value)? toggleTodoTodayWhenever,
    TResult Function(_ReorderSteps value)? reorderSteps,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodoActionCopyWith<TodoAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoActionCopyWith<$Res> {
  factory $TodoActionCopyWith(
    TodoAction value,
    $Res Function(TodoAction) then,
  ) = _$TodoActionCopyWithImpl<$Res, TodoAction>;
  @useResult
  $Res call({TLWorkspace workspace});

  $TLWorkspaceCopyWith<$Res> get workspace;
}

/// @nodoc
class _$TodoActionCopyWithImpl<$Res, $Val extends TodoAction>
    implements $TodoActionCopyWith<$Res> {
  _$TodoActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? workspace = null}) {
    return _then(
      _value.copyWith(
            workspace:
                null == workspace
                    ? _value.workspace
                    : workspace // ignore: cast_nullable_to_non_nullable
                        as TLWorkspace,
          )
          as $Val,
    );
  }

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLWorkspaceCopyWith<$Res> get workspace {
    return $TLWorkspaceCopyWith<$Res>(_value.workspace, (value) {
      return _then(_value.copyWith(workspace: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AddTodoImplCopyWith<$Res>
    implements $TodoActionCopyWith<$Res> {
  factory _$$AddTodoImplCopyWith(
    _$AddTodoImpl value,
    $Res Function(_$AddTodoImpl) then,
  ) = __$$AddTodoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TLWorkspace workspace, TLToDo todo});

  @override
  $TLWorkspaceCopyWith<$Res> get workspace;
  $TLToDoCopyWith<$Res> get todo;
}

/// @nodoc
class __$$AddTodoImplCopyWithImpl<$Res>
    extends _$TodoActionCopyWithImpl<$Res, _$AddTodoImpl>
    implements _$$AddTodoImplCopyWith<$Res> {
  __$$AddTodoImplCopyWithImpl(
    _$AddTodoImpl _value,
    $Res Function(_$AddTodoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? workspace = null, Object? todo = null}) {
    return _then(
      _$AddTodoImpl(
        workspace:
            null == workspace
                ? _value.workspace
                : workspace // ignore: cast_nullable_to_non_nullable
                    as TLWorkspace,
        todo:
            null == todo
                ? _value.todo
                : todo // ignore: cast_nullable_to_non_nullable
                    as TLToDo,
      ),
    );
  }

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLToDoCopyWith<$Res> get todo {
    return $TLToDoCopyWith<$Res>(_value.todo, (value) {
      return _then(_value.copyWith(todo: value));
    });
  }
}

/// @nodoc

class _$AddTodoImpl implements _AddTodo {
  const _$AddTodoImpl({required this.workspace, required this.todo});

  @override
  final TLWorkspace workspace;
  @override
  final TLToDo todo;

  @override
  String toString() {
    return 'TodoAction.addTodo(workspace: $workspace, todo: $todo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddTodoImpl &&
            (identical(other.workspace, workspace) ||
                other.workspace == workspace) &&
            (identical(other.todo, todo) || other.todo == todo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, workspace, todo);

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddTodoImplCopyWith<_$AddTodoImpl> get copyWith =>
      __$$AddTodoImplCopyWithImpl<_$AddTodoImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TLWorkspace workspace, TLToDo todo) addTodo,
    required TResult Function(TLWorkspace workspace, TLToDo todo) updateTodo,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      bool ifInToday,
    )
    deleteTodo,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      bool ifInToday,
    )
    toggleTodoCheck,
    required TResult Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )
    reorderTodos,
    required TResult Function(TLWorkspace workspace, bool ifInToday)
    deleteAllCheckedTodos,
    required TResult Function(TLWorkspace workspace, TLToDo todo, TLStep step)
    toggleStepCheck,
    required TResult Function(TLWorkspace workspace, TLToDo todo)
    toggleTodoTodayWhenever,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )
    reorderSteps,
  }) {
    return addTodo(workspace, todo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace workspace, TLToDo todo)? addTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo)? updateTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    deleteTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    toggleTodoCheck,
    TResult? Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )?
    reorderTodos,
    TResult? Function(TLWorkspace workspace, bool ifInToday)?
    deleteAllCheckedTodos,
    TResult? Function(TLWorkspace workspace, TLToDo todo, TLStep step)?
    toggleStepCheck,
    TResult? Function(TLWorkspace workspace, TLToDo todo)?
    toggleTodoTodayWhenever,
    TResult? Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )?
    reorderSteps,
  }) {
    return addTodo?.call(workspace, todo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace workspace, TLToDo todo)? addTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo)? updateTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    deleteTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    toggleTodoCheck,
    TResult Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )?
    reorderTodos,
    TResult Function(TLWorkspace workspace, bool ifInToday)?
    deleteAllCheckedTodos,
    TResult Function(TLWorkspace workspace, TLToDo todo, TLStep step)?
    toggleStepCheck,
    TResult Function(TLWorkspace workspace, TLToDo todo)?
    toggleTodoTodayWhenever,
    TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )?
    reorderSteps,
    required TResult orElse(),
  }) {
    if (addTodo != null) {
      return addTodo(workspace, todo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddTodo value) addTodo,
    required TResult Function(_UpdateTodo value) updateTodo,
    required TResult Function(_DeleteTodo value) deleteTodo,
    required TResult Function(_ToggleTodoCheck value) toggleTodoCheck,
    required TResult Function(_ReorderTodos value) reorderTodos,
    required TResult Function(_DeleteAllCheckedTodos value)
    deleteAllCheckedTodos,
    required TResult Function(_ToggleStepCheck value) toggleStepCheck,
    required TResult Function(_ToggleTodoTodayWhenever value)
    toggleTodoTodayWhenever,
    required TResult Function(_ReorderSteps value) reorderSteps,
  }) {
    return addTodo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddTodo value)? addTodo,
    TResult? Function(_UpdateTodo value)? updateTodo,
    TResult? Function(_DeleteTodo value)? deleteTodo,
    TResult? Function(_ToggleTodoCheck value)? toggleTodoCheck,
    TResult? Function(_ReorderTodos value)? reorderTodos,
    TResult? Function(_DeleteAllCheckedTodos value)? deleteAllCheckedTodos,
    TResult? Function(_ToggleStepCheck value)? toggleStepCheck,
    TResult? Function(_ToggleTodoTodayWhenever value)? toggleTodoTodayWhenever,
    TResult? Function(_ReorderSteps value)? reorderSteps,
  }) {
    return addTodo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddTodo value)? addTodo,
    TResult Function(_UpdateTodo value)? updateTodo,
    TResult Function(_DeleteTodo value)? deleteTodo,
    TResult Function(_ToggleTodoCheck value)? toggleTodoCheck,
    TResult Function(_ReorderTodos value)? reorderTodos,
    TResult Function(_DeleteAllCheckedTodos value)? deleteAllCheckedTodos,
    TResult Function(_ToggleStepCheck value)? toggleStepCheck,
    TResult Function(_ToggleTodoTodayWhenever value)? toggleTodoTodayWhenever,
    TResult Function(_ReorderSteps value)? reorderSteps,
    required TResult orElse(),
  }) {
    if (addTodo != null) {
      return addTodo(this);
    }
    return orElse();
  }
}

abstract class _AddTodo implements TodoAction {
  const factory _AddTodo({
    required final TLWorkspace workspace,
    required final TLToDo todo,
  }) = _$AddTodoImpl;

  @override
  TLWorkspace get workspace;
  TLToDo get todo;

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddTodoImplCopyWith<_$AddTodoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateTodoImplCopyWith<$Res>
    implements $TodoActionCopyWith<$Res> {
  factory _$$UpdateTodoImplCopyWith(
    _$UpdateTodoImpl value,
    $Res Function(_$UpdateTodoImpl) then,
  ) = __$$UpdateTodoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TLWorkspace workspace, TLToDo todo});

  @override
  $TLWorkspaceCopyWith<$Res> get workspace;
  $TLToDoCopyWith<$Res> get todo;
}

/// @nodoc
class __$$UpdateTodoImplCopyWithImpl<$Res>
    extends _$TodoActionCopyWithImpl<$Res, _$UpdateTodoImpl>
    implements _$$UpdateTodoImplCopyWith<$Res> {
  __$$UpdateTodoImplCopyWithImpl(
    _$UpdateTodoImpl _value,
    $Res Function(_$UpdateTodoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? workspace = null, Object? todo = null}) {
    return _then(
      _$UpdateTodoImpl(
        workspace:
            null == workspace
                ? _value.workspace
                : workspace // ignore: cast_nullable_to_non_nullable
                    as TLWorkspace,
        todo:
            null == todo
                ? _value.todo
                : todo // ignore: cast_nullable_to_non_nullable
                    as TLToDo,
      ),
    );
  }

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLToDoCopyWith<$Res> get todo {
    return $TLToDoCopyWith<$Res>(_value.todo, (value) {
      return _then(_value.copyWith(todo: value));
    });
  }
}

/// @nodoc

class _$UpdateTodoImpl implements _UpdateTodo {
  const _$UpdateTodoImpl({required this.workspace, required this.todo});

  @override
  final TLWorkspace workspace;
  @override
  final TLToDo todo;

  @override
  String toString() {
    return 'TodoAction.updateTodo(workspace: $workspace, todo: $todo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateTodoImpl &&
            (identical(other.workspace, workspace) ||
                other.workspace == workspace) &&
            (identical(other.todo, todo) || other.todo == todo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, workspace, todo);

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateTodoImplCopyWith<_$UpdateTodoImpl> get copyWith =>
      __$$UpdateTodoImplCopyWithImpl<_$UpdateTodoImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TLWorkspace workspace, TLToDo todo) addTodo,
    required TResult Function(TLWorkspace workspace, TLToDo todo) updateTodo,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      bool ifInToday,
    )
    deleteTodo,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      bool ifInToday,
    )
    toggleTodoCheck,
    required TResult Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )
    reorderTodos,
    required TResult Function(TLWorkspace workspace, bool ifInToday)
    deleteAllCheckedTodos,
    required TResult Function(TLWorkspace workspace, TLToDo todo, TLStep step)
    toggleStepCheck,
    required TResult Function(TLWorkspace workspace, TLToDo todo)
    toggleTodoTodayWhenever,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )
    reorderSteps,
  }) {
    return updateTodo(workspace, todo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace workspace, TLToDo todo)? addTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo)? updateTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    deleteTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    toggleTodoCheck,
    TResult? Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )?
    reorderTodos,
    TResult? Function(TLWorkspace workspace, bool ifInToday)?
    deleteAllCheckedTodos,
    TResult? Function(TLWorkspace workspace, TLToDo todo, TLStep step)?
    toggleStepCheck,
    TResult? Function(TLWorkspace workspace, TLToDo todo)?
    toggleTodoTodayWhenever,
    TResult? Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )?
    reorderSteps,
  }) {
    return updateTodo?.call(workspace, todo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace workspace, TLToDo todo)? addTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo)? updateTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    deleteTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    toggleTodoCheck,
    TResult Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )?
    reorderTodos,
    TResult Function(TLWorkspace workspace, bool ifInToday)?
    deleteAllCheckedTodos,
    TResult Function(TLWorkspace workspace, TLToDo todo, TLStep step)?
    toggleStepCheck,
    TResult Function(TLWorkspace workspace, TLToDo todo)?
    toggleTodoTodayWhenever,
    TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )?
    reorderSteps,
    required TResult orElse(),
  }) {
    if (updateTodo != null) {
      return updateTodo(workspace, todo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddTodo value) addTodo,
    required TResult Function(_UpdateTodo value) updateTodo,
    required TResult Function(_DeleteTodo value) deleteTodo,
    required TResult Function(_ToggleTodoCheck value) toggleTodoCheck,
    required TResult Function(_ReorderTodos value) reorderTodos,
    required TResult Function(_DeleteAllCheckedTodos value)
    deleteAllCheckedTodos,
    required TResult Function(_ToggleStepCheck value) toggleStepCheck,
    required TResult Function(_ToggleTodoTodayWhenever value)
    toggleTodoTodayWhenever,
    required TResult Function(_ReorderSteps value) reorderSteps,
  }) {
    return updateTodo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddTodo value)? addTodo,
    TResult? Function(_UpdateTodo value)? updateTodo,
    TResult? Function(_DeleteTodo value)? deleteTodo,
    TResult? Function(_ToggleTodoCheck value)? toggleTodoCheck,
    TResult? Function(_ReorderTodos value)? reorderTodos,
    TResult? Function(_DeleteAllCheckedTodos value)? deleteAllCheckedTodos,
    TResult? Function(_ToggleStepCheck value)? toggleStepCheck,
    TResult? Function(_ToggleTodoTodayWhenever value)? toggleTodoTodayWhenever,
    TResult? Function(_ReorderSteps value)? reorderSteps,
  }) {
    return updateTodo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddTodo value)? addTodo,
    TResult Function(_UpdateTodo value)? updateTodo,
    TResult Function(_DeleteTodo value)? deleteTodo,
    TResult Function(_ToggleTodoCheck value)? toggleTodoCheck,
    TResult Function(_ReorderTodos value)? reorderTodos,
    TResult Function(_DeleteAllCheckedTodos value)? deleteAllCheckedTodos,
    TResult Function(_ToggleStepCheck value)? toggleStepCheck,
    TResult Function(_ToggleTodoTodayWhenever value)? toggleTodoTodayWhenever,
    TResult Function(_ReorderSteps value)? reorderSteps,
    required TResult orElse(),
  }) {
    if (updateTodo != null) {
      return updateTodo(this);
    }
    return orElse();
  }
}

abstract class _UpdateTodo implements TodoAction {
  const factory _UpdateTodo({
    required final TLWorkspace workspace,
    required final TLToDo todo,
  }) = _$UpdateTodoImpl;

  @override
  TLWorkspace get workspace;
  TLToDo get todo;

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateTodoImplCopyWith<_$UpdateTodoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteTodoImplCopyWith<$Res>
    implements $TodoActionCopyWith<$Res> {
  factory _$$DeleteTodoImplCopyWith(
    _$DeleteTodoImpl value,
    $Res Function(_$DeleteTodoImpl) then,
  ) = __$$DeleteTodoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TLWorkspace workspace, TLToDo todo, bool ifInToday});

  @override
  $TLWorkspaceCopyWith<$Res> get workspace;
  $TLToDoCopyWith<$Res> get todo;
}

/// @nodoc
class __$$DeleteTodoImplCopyWithImpl<$Res>
    extends _$TodoActionCopyWithImpl<$Res, _$DeleteTodoImpl>
    implements _$$DeleteTodoImplCopyWith<$Res> {
  __$$DeleteTodoImplCopyWithImpl(
    _$DeleteTodoImpl _value,
    $Res Function(_$DeleteTodoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workspace = null,
    Object? todo = null,
    Object? ifInToday = null,
  }) {
    return _then(
      _$DeleteTodoImpl(
        workspace:
            null == workspace
                ? _value.workspace
                : workspace // ignore: cast_nullable_to_non_nullable
                    as TLWorkspace,
        todo:
            null == todo
                ? _value.todo
                : todo // ignore: cast_nullable_to_non_nullable
                    as TLToDo,
        ifInToday:
            null == ifInToday
                ? _value.ifInToday
                : ifInToday // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLToDoCopyWith<$Res> get todo {
    return $TLToDoCopyWith<$Res>(_value.todo, (value) {
      return _then(_value.copyWith(todo: value));
    });
  }
}

/// @nodoc

class _$DeleteTodoImpl implements _DeleteTodo {
  const _$DeleteTodoImpl({
    required this.workspace,
    required this.todo,
    required this.ifInToday,
  });

  @override
  final TLWorkspace workspace;
  @override
  final TLToDo todo;
  @override
  final bool ifInToday;

  @override
  String toString() {
    return 'TodoAction.deleteTodo(workspace: $workspace, todo: $todo, ifInToday: $ifInToday)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteTodoImpl &&
            (identical(other.workspace, workspace) ||
                other.workspace == workspace) &&
            (identical(other.todo, todo) || other.todo == todo) &&
            (identical(other.ifInToday, ifInToday) ||
                other.ifInToday == ifInToday));
  }

  @override
  int get hashCode => Object.hash(runtimeType, workspace, todo, ifInToday);

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteTodoImplCopyWith<_$DeleteTodoImpl> get copyWith =>
      __$$DeleteTodoImplCopyWithImpl<_$DeleteTodoImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TLWorkspace workspace, TLToDo todo) addTodo,
    required TResult Function(TLWorkspace workspace, TLToDo todo) updateTodo,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      bool ifInToday,
    )
    deleteTodo,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      bool ifInToday,
    )
    toggleTodoCheck,
    required TResult Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )
    reorderTodos,
    required TResult Function(TLWorkspace workspace, bool ifInToday)
    deleteAllCheckedTodos,
    required TResult Function(TLWorkspace workspace, TLToDo todo, TLStep step)
    toggleStepCheck,
    required TResult Function(TLWorkspace workspace, TLToDo todo)
    toggleTodoTodayWhenever,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )
    reorderSteps,
  }) {
    return deleteTodo(workspace, todo, ifInToday);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace workspace, TLToDo todo)? addTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo)? updateTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    deleteTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    toggleTodoCheck,
    TResult? Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )?
    reorderTodos,
    TResult? Function(TLWorkspace workspace, bool ifInToday)?
    deleteAllCheckedTodos,
    TResult? Function(TLWorkspace workspace, TLToDo todo, TLStep step)?
    toggleStepCheck,
    TResult? Function(TLWorkspace workspace, TLToDo todo)?
    toggleTodoTodayWhenever,
    TResult? Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )?
    reorderSteps,
  }) {
    return deleteTodo?.call(workspace, todo, ifInToday);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace workspace, TLToDo todo)? addTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo)? updateTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    deleteTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    toggleTodoCheck,
    TResult Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )?
    reorderTodos,
    TResult Function(TLWorkspace workspace, bool ifInToday)?
    deleteAllCheckedTodos,
    TResult Function(TLWorkspace workspace, TLToDo todo, TLStep step)?
    toggleStepCheck,
    TResult Function(TLWorkspace workspace, TLToDo todo)?
    toggleTodoTodayWhenever,
    TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )?
    reorderSteps,
    required TResult orElse(),
  }) {
    if (deleteTodo != null) {
      return deleteTodo(workspace, todo, ifInToday);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddTodo value) addTodo,
    required TResult Function(_UpdateTodo value) updateTodo,
    required TResult Function(_DeleteTodo value) deleteTodo,
    required TResult Function(_ToggleTodoCheck value) toggleTodoCheck,
    required TResult Function(_ReorderTodos value) reorderTodos,
    required TResult Function(_DeleteAllCheckedTodos value)
    deleteAllCheckedTodos,
    required TResult Function(_ToggleStepCheck value) toggleStepCheck,
    required TResult Function(_ToggleTodoTodayWhenever value)
    toggleTodoTodayWhenever,
    required TResult Function(_ReorderSteps value) reorderSteps,
  }) {
    return deleteTodo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddTodo value)? addTodo,
    TResult? Function(_UpdateTodo value)? updateTodo,
    TResult? Function(_DeleteTodo value)? deleteTodo,
    TResult? Function(_ToggleTodoCheck value)? toggleTodoCheck,
    TResult? Function(_ReorderTodos value)? reorderTodos,
    TResult? Function(_DeleteAllCheckedTodos value)? deleteAllCheckedTodos,
    TResult? Function(_ToggleStepCheck value)? toggleStepCheck,
    TResult? Function(_ToggleTodoTodayWhenever value)? toggleTodoTodayWhenever,
    TResult? Function(_ReorderSteps value)? reorderSteps,
  }) {
    return deleteTodo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddTodo value)? addTodo,
    TResult Function(_UpdateTodo value)? updateTodo,
    TResult Function(_DeleteTodo value)? deleteTodo,
    TResult Function(_ToggleTodoCheck value)? toggleTodoCheck,
    TResult Function(_ReorderTodos value)? reorderTodos,
    TResult Function(_DeleteAllCheckedTodos value)? deleteAllCheckedTodos,
    TResult Function(_ToggleStepCheck value)? toggleStepCheck,
    TResult Function(_ToggleTodoTodayWhenever value)? toggleTodoTodayWhenever,
    TResult Function(_ReorderSteps value)? reorderSteps,
    required TResult orElse(),
  }) {
    if (deleteTodo != null) {
      return deleteTodo(this);
    }
    return orElse();
  }
}

abstract class _DeleteTodo implements TodoAction {
  const factory _DeleteTodo({
    required final TLWorkspace workspace,
    required final TLToDo todo,
    required final bool ifInToday,
  }) = _$DeleteTodoImpl;

  @override
  TLWorkspace get workspace;
  TLToDo get todo;
  bool get ifInToday;

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteTodoImplCopyWith<_$DeleteTodoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToggleTodoCheckImplCopyWith<$Res>
    implements $TodoActionCopyWith<$Res> {
  factory _$$ToggleTodoCheckImplCopyWith(
    _$ToggleTodoCheckImpl value,
    $Res Function(_$ToggleTodoCheckImpl) then,
  ) = __$$ToggleTodoCheckImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TLWorkspace workspace, TLToDo todo, bool ifInToday});

  @override
  $TLWorkspaceCopyWith<$Res> get workspace;
  $TLToDoCopyWith<$Res> get todo;
}

/// @nodoc
class __$$ToggleTodoCheckImplCopyWithImpl<$Res>
    extends _$TodoActionCopyWithImpl<$Res, _$ToggleTodoCheckImpl>
    implements _$$ToggleTodoCheckImplCopyWith<$Res> {
  __$$ToggleTodoCheckImplCopyWithImpl(
    _$ToggleTodoCheckImpl _value,
    $Res Function(_$ToggleTodoCheckImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workspace = null,
    Object? todo = null,
    Object? ifInToday = null,
  }) {
    return _then(
      _$ToggleTodoCheckImpl(
        workspace:
            null == workspace
                ? _value.workspace
                : workspace // ignore: cast_nullable_to_non_nullable
                    as TLWorkspace,
        todo:
            null == todo
                ? _value.todo
                : todo // ignore: cast_nullable_to_non_nullable
                    as TLToDo,
        ifInToday:
            null == ifInToday
                ? _value.ifInToday
                : ifInToday // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLToDoCopyWith<$Res> get todo {
    return $TLToDoCopyWith<$Res>(_value.todo, (value) {
      return _then(_value.copyWith(todo: value));
    });
  }
}

/// @nodoc

class _$ToggleTodoCheckImpl implements _ToggleTodoCheck {
  const _$ToggleTodoCheckImpl({
    required this.workspace,
    required this.todo,
    required this.ifInToday,
  });

  @override
  final TLWorkspace workspace;
  @override
  final TLToDo todo;
  @override
  final bool ifInToday;

  @override
  String toString() {
    return 'TodoAction.toggleTodoCheck(workspace: $workspace, todo: $todo, ifInToday: $ifInToday)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToggleTodoCheckImpl &&
            (identical(other.workspace, workspace) ||
                other.workspace == workspace) &&
            (identical(other.todo, todo) || other.todo == todo) &&
            (identical(other.ifInToday, ifInToday) ||
                other.ifInToday == ifInToday));
  }

  @override
  int get hashCode => Object.hash(runtimeType, workspace, todo, ifInToday);

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToggleTodoCheckImplCopyWith<_$ToggleTodoCheckImpl> get copyWith =>
      __$$ToggleTodoCheckImplCopyWithImpl<_$ToggleTodoCheckImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TLWorkspace workspace, TLToDo todo) addTodo,
    required TResult Function(TLWorkspace workspace, TLToDo todo) updateTodo,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      bool ifInToday,
    )
    deleteTodo,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      bool ifInToday,
    )
    toggleTodoCheck,
    required TResult Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )
    reorderTodos,
    required TResult Function(TLWorkspace workspace, bool ifInToday)
    deleteAllCheckedTodos,
    required TResult Function(TLWorkspace workspace, TLToDo todo, TLStep step)
    toggleStepCheck,
    required TResult Function(TLWorkspace workspace, TLToDo todo)
    toggleTodoTodayWhenever,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )
    reorderSteps,
  }) {
    return toggleTodoCheck(workspace, todo, ifInToday);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace workspace, TLToDo todo)? addTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo)? updateTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    deleteTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    toggleTodoCheck,
    TResult? Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )?
    reorderTodos,
    TResult? Function(TLWorkspace workspace, bool ifInToday)?
    deleteAllCheckedTodos,
    TResult? Function(TLWorkspace workspace, TLToDo todo, TLStep step)?
    toggleStepCheck,
    TResult? Function(TLWorkspace workspace, TLToDo todo)?
    toggleTodoTodayWhenever,
    TResult? Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )?
    reorderSteps,
  }) {
    return toggleTodoCheck?.call(workspace, todo, ifInToday);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace workspace, TLToDo todo)? addTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo)? updateTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    deleteTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    toggleTodoCheck,
    TResult Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )?
    reorderTodos,
    TResult Function(TLWorkspace workspace, bool ifInToday)?
    deleteAllCheckedTodos,
    TResult Function(TLWorkspace workspace, TLToDo todo, TLStep step)?
    toggleStepCheck,
    TResult Function(TLWorkspace workspace, TLToDo todo)?
    toggleTodoTodayWhenever,
    TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )?
    reorderSteps,
    required TResult orElse(),
  }) {
    if (toggleTodoCheck != null) {
      return toggleTodoCheck(workspace, todo, ifInToday);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddTodo value) addTodo,
    required TResult Function(_UpdateTodo value) updateTodo,
    required TResult Function(_DeleteTodo value) deleteTodo,
    required TResult Function(_ToggleTodoCheck value) toggleTodoCheck,
    required TResult Function(_ReorderTodos value) reorderTodos,
    required TResult Function(_DeleteAllCheckedTodos value)
    deleteAllCheckedTodos,
    required TResult Function(_ToggleStepCheck value) toggleStepCheck,
    required TResult Function(_ToggleTodoTodayWhenever value)
    toggleTodoTodayWhenever,
    required TResult Function(_ReorderSteps value) reorderSteps,
  }) {
    return toggleTodoCheck(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddTodo value)? addTodo,
    TResult? Function(_UpdateTodo value)? updateTodo,
    TResult? Function(_DeleteTodo value)? deleteTodo,
    TResult? Function(_ToggleTodoCheck value)? toggleTodoCheck,
    TResult? Function(_ReorderTodos value)? reorderTodos,
    TResult? Function(_DeleteAllCheckedTodos value)? deleteAllCheckedTodos,
    TResult? Function(_ToggleStepCheck value)? toggleStepCheck,
    TResult? Function(_ToggleTodoTodayWhenever value)? toggleTodoTodayWhenever,
    TResult? Function(_ReorderSteps value)? reorderSteps,
  }) {
    return toggleTodoCheck?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddTodo value)? addTodo,
    TResult Function(_UpdateTodo value)? updateTodo,
    TResult Function(_DeleteTodo value)? deleteTodo,
    TResult Function(_ToggleTodoCheck value)? toggleTodoCheck,
    TResult Function(_ReorderTodos value)? reorderTodos,
    TResult Function(_DeleteAllCheckedTodos value)? deleteAllCheckedTodos,
    TResult Function(_ToggleStepCheck value)? toggleStepCheck,
    TResult Function(_ToggleTodoTodayWhenever value)? toggleTodoTodayWhenever,
    TResult Function(_ReorderSteps value)? reorderSteps,
    required TResult orElse(),
  }) {
    if (toggleTodoCheck != null) {
      return toggleTodoCheck(this);
    }
    return orElse();
  }
}

abstract class _ToggleTodoCheck implements TodoAction {
  const factory _ToggleTodoCheck({
    required final TLWorkspace workspace,
    required final TLToDo todo,
    required final bool ifInToday,
  }) = _$ToggleTodoCheckImpl;

  @override
  TLWorkspace get workspace;
  TLToDo get todo;
  bool get ifInToday;

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToggleTodoCheckImplCopyWith<_$ToggleTodoCheckImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReorderTodosImplCopyWith<$Res>
    implements $TodoActionCopyWith<$Res> {
  factory _$$ReorderTodosImplCopyWith(
    _$ReorderTodosImpl value,
    $Res Function(_$ReorderTodosImpl) then,
  ) = __$$ReorderTodosImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    TLWorkspace workspace,
    List<TLToDo> todos,
    int oldIndex,
    int newIndex,
    String category,
    bool ifInToday,
  });

  @override
  $TLWorkspaceCopyWith<$Res> get workspace;
}

/// @nodoc
class __$$ReorderTodosImplCopyWithImpl<$Res>
    extends _$TodoActionCopyWithImpl<$Res, _$ReorderTodosImpl>
    implements _$$ReorderTodosImplCopyWith<$Res> {
  __$$ReorderTodosImplCopyWithImpl(
    _$ReorderTodosImpl _value,
    $Res Function(_$ReorderTodosImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workspace = null,
    Object? todos = null,
    Object? oldIndex = null,
    Object? newIndex = null,
    Object? category = null,
    Object? ifInToday = null,
  }) {
    return _then(
      _$ReorderTodosImpl(
        workspace:
            null == workspace
                ? _value.workspace
                : workspace // ignore: cast_nullable_to_non_nullable
                    as TLWorkspace,
        todos:
            null == todos
                ? _value._todos
                : todos // ignore: cast_nullable_to_non_nullable
                    as List<TLToDo>,
        oldIndex:
            null == oldIndex
                ? _value.oldIndex
                : oldIndex // ignore: cast_nullable_to_non_nullable
                    as int,
        newIndex:
            null == newIndex
                ? _value.newIndex
                : newIndex // ignore: cast_nullable_to_non_nullable
                    as int,
        category:
            null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                    as String,
        ifInToday:
            null == ifInToday
                ? _value.ifInToday
                : ifInToday // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$ReorderTodosImpl implements _ReorderTodos {
  const _$ReorderTodosImpl({
    required this.workspace,
    required final List<TLToDo> todos,
    required this.oldIndex,
    required this.newIndex,
    required this.category,
    required this.ifInToday,
  }) : _todos = todos;

  @override
  final TLWorkspace workspace;
  final List<TLToDo> _todos;
  @override
  List<TLToDo> get todos {
    if (_todos is EqualUnmodifiableListView) return _todos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todos);
  }

  @override
  final int oldIndex;
  @override
  final int newIndex;
  @override
  final String category;
  @override
  final bool ifInToday;

  @override
  String toString() {
    return 'TodoAction.reorderTodos(workspace: $workspace, todos: $todos, oldIndex: $oldIndex, newIndex: $newIndex, category: $category, ifInToday: $ifInToday)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReorderTodosImpl &&
            (identical(other.workspace, workspace) ||
                other.workspace == workspace) &&
            const DeepCollectionEquality().equals(other._todos, _todos) &&
            (identical(other.oldIndex, oldIndex) ||
                other.oldIndex == oldIndex) &&
            (identical(other.newIndex, newIndex) ||
                other.newIndex == newIndex) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.ifInToday, ifInToday) ||
                other.ifInToday == ifInToday));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    workspace,
    const DeepCollectionEquality().hash(_todos),
    oldIndex,
    newIndex,
    category,
    ifInToday,
  );

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReorderTodosImplCopyWith<_$ReorderTodosImpl> get copyWith =>
      __$$ReorderTodosImplCopyWithImpl<_$ReorderTodosImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TLWorkspace workspace, TLToDo todo) addTodo,
    required TResult Function(TLWorkspace workspace, TLToDo todo) updateTodo,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      bool ifInToday,
    )
    deleteTodo,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      bool ifInToday,
    )
    toggleTodoCheck,
    required TResult Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )
    reorderTodos,
    required TResult Function(TLWorkspace workspace, bool ifInToday)
    deleteAllCheckedTodos,
    required TResult Function(TLWorkspace workspace, TLToDo todo, TLStep step)
    toggleStepCheck,
    required TResult Function(TLWorkspace workspace, TLToDo todo)
    toggleTodoTodayWhenever,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )
    reorderSteps,
  }) {
    return reorderTodos(
      workspace,
      todos,
      oldIndex,
      newIndex,
      category,
      ifInToday,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace workspace, TLToDo todo)? addTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo)? updateTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    deleteTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    toggleTodoCheck,
    TResult? Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )?
    reorderTodos,
    TResult? Function(TLWorkspace workspace, bool ifInToday)?
    deleteAllCheckedTodos,
    TResult? Function(TLWorkspace workspace, TLToDo todo, TLStep step)?
    toggleStepCheck,
    TResult? Function(TLWorkspace workspace, TLToDo todo)?
    toggleTodoTodayWhenever,
    TResult? Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )?
    reorderSteps,
  }) {
    return reorderTodos?.call(
      workspace,
      todos,
      oldIndex,
      newIndex,
      category,
      ifInToday,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace workspace, TLToDo todo)? addTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo)? updateTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    deleteTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    toggleTodoCheck,
    TResult Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )?
    reorderTodos,
    TResult Function(TLWorkspace workspace, bool ifInToday)?
    deleteAllCheckedTodos,
    TResult Function(TLWorkspace workspace, TLToDo todo, TLStep step)?
    toggleStepCheck,
    TResult Function(TLWorkspace workspace, TLToDo todo)?
    toggleTodoTodayWhenever,
    TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )?
    reorderSteps,
    required TResult orElse(),
  }) {
    if (reorderTodos != null) {
      return reorderTodos(
        workspace,
        todos,
        oldIndex,
        newIndex,
        category,
        ifInToday,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddTodo value) addTodo,
    required TResult Function(_UpdateTodo value) updateTodo,
    required TResult Function(_DeleteTodo value) deleteTodo,
    required TResult Function(_ToggleTodoCheck value) toggleTodoCheck,
    required TResult Function(_ReorderTodos value) reorderTodos,
    required TResult Function(_DeleteAllCheckedTodos value)
    deleteAllCheckedTodos,
    required TResult Function(_ToggleStepCheck value) toggleStepCheck,
    required TResult Function(_ToggleTodoTodayWhenever value)
    toggleTodoTodayWhenever,
    required TResult Function(_ReorderSteps value) reorderSteps,
  }) {
    return reorderTodos(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddTodo value)? addTodo,
    TResult? Function(_UpdateTodo value)? updateTodo,
    TResult? Function(_DeleteTodo value)? deleteTodo,
    TResult? Function(_ToggleTodoCheck value)? toggleTodoCheck,
    TResult? Function(_ReorderTodos value)? reorderTodos,
    TResult? Function(_DeleteAllCheckedTodos value)? deleteAllCheckedTodos,
    TResult? Function(_ToggleStepCheck value)? toggleStepCheck,
    TResult? Function(_ToggleTodoTodayWhenever value)? toggleTodoTodayWhenever,
    TResult? Function(_ReorderSteps value)? reorderSteps,
  }) {
    return reorderTodos?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddTodo value)? addTodo,
    TResult Function(_UpdateTodo value)? updateTodo,
    TResult Function(_DeleteTodo value)? deleteTodo,
    TResult Function(_ToggleTodoCheck value)? toggleTodoCheck,
    TResult Function(_ReorderTodos value)? reorderTodos,
    TResult Function(_DeleteAllCheckedTodos value)? deleteAllCheckedTodos,
    TResult Function(_ToggleStepCheck value)? toggleStepCheck,
    TResult Function(_ToggleTodoTodayWhenever value)? toggleTodoTodayWhenever,
    TResult Function(_ReorderSteps value)? reorderSteps,
    required TResult orElse(),
  }) {
    if (reorderTodos != null) {
      return reorderTodos(this);
    }
    return orElse();
  }
}

abstract class _ReorderTodos implements TodoAction {
  const factory _ReorderTodos({
    required final TLWorkspace workspace,
    required final List<TLToDo> todos,
    required final int oldIndex,
    required final int newIndex,
    required final String category,
    required final bool ifInToday,
  }) = _$ReorderTodosImpl;

  @override
  TLWorkspace get workspace;
  List<TLToDo> get todos;
  int get oldIndex;
  int get newIndex;
  String get category;
  bool get ifInToday;

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReorderTodosImplCopyWith<_$ReorderTodosImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteAllCheckedTodosImplCopyWith<$Res>
    implements $TodoActionCopyWith<$Res> {
  factory _$$DeleteAllCheckedTodosImplCopyWith(
    _$DeleteAllCheckedTodosImpl value,
    $Res Function(_$DeleteAllCheckedTodosImpl) then,
  ) = __$$DeleteAllCheckedTodosImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TLWorkspace workspace, bool ifInToday});

  @override
  $TLWorkspaceCopyWith<$Res> get workspace;
}

/// @nodoc
class __$$DeleteAllCheckedTodosImplCopyWithImpl<$Res>
    extends _$TodoActionCopyWithImpl<$Res, _$DeleteAllCheckedTodosImpl>
    implements _$$DeleteAllCheckedTodosImplCopyWith<$Res> {
  __$$DeleteAllCheckedTodosImplCopyWithImpl(
    _$DeleteAllCheckedTodosImpl _value,
    $Res Function(_$DeleteAllCheckedTodosImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? workspace = null, Object? ifInToday = null}) {
    return _then(
      _$DeleteAllCheckedTodosImpl(
        workspace:
            null == workspace
                ? _value.workspace
                : workspace // ignore: cast_nullable_to_non_nullable
                    as TLWorkspace,
        ifInToday:
            null == ifInToday
                ? _value.ifInToday
                : ifInToday // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$DeleteAllCheckedTodosImpl implements _DeleteAllCheckedTodos {
  const _$DeleteAllCheckedTodosImpl({
    required this.workspace,
    required this.ifInToday,
  });

  @override
  final TLWorkspace workspace;
  @override
  final bool ifInToday;

  @override
  String toString() {
    return 'TodoAction.deleteAllCheckedTodos(workspace: $workspace, ifInToday: $ifInToday)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteAllCheckedTodosImpl &&
            (identical(other.workspace, workspace) ||
                other.workspace == workspace) &&
            (identical(other.ifInToday, ifInToday) ||
                other.ifInToday == ifInToday));
  }

  @override
  int get hashCode => Object.hash(runtimeType, workspace, ifInToday);

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteAllCheckedTodosImplCopyWith<_$DeleteAllCheckedTodosImpl>
  get copyWith =>
      __$$DeleteAllCheckedTodosImplCopyWithImpl<_$DeleteAllCheckedTodosImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TLWorkspace workspace, TLToDo todo) addTodo,
    required TResult Function(TLWorkspace workspace, TLToDo todo) updateTodo,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      bool ifInToday,
    )
    deleteTodo,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      bool ifInToday,
    )
    toggleTodoCheck,
    required TResult Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )
    reorderTodos,
    required TResult Function(TLWorkspace workspace, bool ifInToday)
    deleteAllCheckedTodos,
    required TResult Function(TLWorkspace workspace, TLToDo todo, TLStep step)
    toggleStepCheck,
    required TResult Function(TLWorkspace workspace, TLToDo todo)
    toggleTodoTodayWhenever,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )
    reorderSteps,
  }) {
    return deleteAllCheckedTodos(workspace, ifInToday);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace workspace, TLToDo todo)? addTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo)? updateTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    deleteTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    toggleTodoCheck,
    TResult? Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )?
    reorderTodos,
    TResult? Function(TLWorkspace workspace, bool ifInToday)?
    deleteAllCheckedTodos,
    TResult? Function(TLWorkspace workspace, TLToDo todo, TLStep step)?
    toggleStepCheck,
    TResult? Function(TLWorkspace workspace, TLToDo todo)?
    toggleTodoTodayWhenever,
    TResult? Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )?
    reorderSteps,
  }) {
    return deleteAllCheckedTodos?.call(workspace, ifInToday);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace workspace, TLToDo todo)? addTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo)? updateTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    deleteTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    toggleTodoCheck,
    TResult Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )?
    reorderTodos,
    TResult Function(TLWorkspace workspace, bool ifInToday)?
    deleteAllCheckedTodos,
    TResult Function(TLWorkspace workspace, TLToDo todo, TLStep step)?
    toggleStepCheck,
    TResult Function(TLWorkspace workspace, TLToDo todo)?
    toggleTodoTodayWhenever,
    TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )?
    reorderSteps,
    required TResult orElse(),
  }) {
    if (deleteAllCheckedTodos != null) {
      return deleteAllCheckedTodos(workspace, ifInToday);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddTodo value) addTodo,
    required TResult Function(_UpdateTodo value) updateTodo,
    required TResult Function(_DeleteTodo value) deleteTodo,
    required TResult Function(_ToggleTodoCheck value) toggleTodoCheck,
    required TResult Function(_ReorderTodos value) reorderTodos,
    required TResult Function(_DeleteAllCheckedTodos value)
    deleteAllCheckedTodos,
    required TResult Function(_ToggleStepCheck value) toggleStepCheck,
    required TResult Function(_ToggleTodoTodayWhenever value)
    toggleTodoTodayWhenever,
    required TResult Function(_ReorderSteps value) reorderSteps,
  }) {
    return deleteAllCheckedTodos(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddTodo value)? addTodo,
    TResult? Function(_UpdateTodo value)? updateTodo,
    TResult? Function(_DeleteTodo value)? deleteTodo,
    TResult? Function(_ToggleTodoCheck value)? toggleTodoCheck,
    TResult? Function(_ReorderTodos value)? reorderTodos,
    TResult? Function(_DeleteAllCheckedTodos value)? deleteAllCheckedTodos,
    TResult? Function(_ToggleStepCheck value)? toggleStepCheck,
    TResult? Function(_ToggleTodoTodayWhenever value)? toggleTodoTodayWhenever,
    TResult? Function(_ReorderSteps value)? reorderSteps,
  }) {
    return deleteAllCheckedTodos?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddTodo value)? addTodo,
    TResult Function(_UpdateTodo value)? updateTodo,
    TResult Function(_DeleteTodo value)? deleteTodo,
    TResult Function(_ToggleTodoCheck value)? toggleTodoCheck,
    TResult Function(_ReorderTodos value)? reorderTodos,
    TResult Function(_DeleteAllCheckedTodos value)? deleteAllCheckedTodos,
    TResult Function(_ToggleStepCheck value)? toggleStepCheck,
    TResult Function(_ToggleTodoTodayWhenever value)? toggleTodoTodayWhenever,
    TResult Function(_ReorderSteps value)? reorderSteps,
    required TResult orElse(),
  }) {
    if (deleteAllCheckedTodos != null) {
      return deleteAllCheckedTodos(this);
    }
    return orElse();
  }
}

abstract class _DeleteAllCheckedTodos implements TodoAction {
  const factory _DeleteAllCheckedTodos({
    required final TLWorkspace workspace,
    required final bool ifInToday,
  }) = _$DeleteAllCheckedTodosImpl;

  @override
  TLWorkspace get workspace;
  bool get ifInToday;

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteAllCheckedTodosImplCopyWith<_$DeleteAllCheckedTodosImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToggleStepCheckImplCopyWith<$Res>
    implements $TodoActionCopyWith<$Res> {
  factory _$$ToggleStepCheckImplCopyWith(
    _$ToggleStepCheckImpl value,
    $Res Function(_$ToggleStepCheckImpl) then,
  ) = __$$ToggleStepCheckImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TLWorkspace workspace, TLToDo todo, TLStep step});

  @override
  $TLWorkspaceCopyWith<$Res> get workspace;
  $TLToDoCopyWith<$Res> get todo;
  $TLStepCopyWith<$Res> get step;
}

/// @nodoc
class __$$ToggleStepCheckImplCopyWithImpl<$Res>
    extends _$TodoActionCopyWithImpl<$Res, _$ToggleStepCheckImpl>
    implements _$$ToggleStepCheckImplCopyWith<$Res> {
  __$$ToggleStepCheckImplCopyWithImpl(
    _$ToggleStepCheckImpl _value,
    $Res Function(_$ToggleStepCheckImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workspace = null,
    Object? todo = null,
    Object? step = null,
  }) {
    return _then(
      _$ToggleStepCheckImpl(
        workspace:
            null == workspace
                ? _value.workspace
                : workspace // ignore: cast_nullable_to_non_nullable
                    as TLWorkspace,
        todo:
            null == todo
                ? _value.todo
                : todo // ignore: cast_nullable_to_non_nullable
                    as TLToDo,
        step:
            null == step
                ? _value.step
                : step // ignore: cast_nullable_to_non_nullable
                    as TLStep,
      ),
    );
  }

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLToDoCopyWith<$Res> get todo {
    return $TLToDoCopyWith<$Res>(_value.todo, (value) {
      return _then(_value.copyWith(todo: value));
    });
  }

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLStepCopyWith<$Res> get step {
    return $TLStepCopyWith<$Res>(_value.step, (value) {
      return _then(_value.copyWith(step: value));
    });
  }
}

/// @nodoc

class _$ToggleStepCheckImpl implements _ToggleStepCheck {
  const _$ToggleStepCheckImpl({
    required this.workspace,
    required this.todo,
    required this.step,
  });

  @override
  final TLWorkspace workspace;
  @override
  final TLToDo todo;
  @override
  final TLStep step;

  @override
  String toString() {
    return 'TodoAction.toggleStepCheck(workspace: $workspace, todo: $todo, step: $step)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToggleStepCheckImpl &&
            (identical(other.workspace, workspace) ||
                other.workspace == workspace) &&
            (identical(other.todo, todo) || other.todo == todo) &&
            (identical(other.step, step) || other.step == step));
  }

  @override
  int get hashCode => Object.hash(runtimeType, workspace, todo, step);

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToggleStepCheckImplCopyWith<_$ToggleStepCheckImpl> get copyWith =>
      __$$ToggleStepCheckImplCopyWithImpl<_$ToggleStepCheckImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TLWorkspace workspace, TLToDo todo) addTodo,
    required TResult Function(TLWorkspace workspace, TLToDo todo) updateTodo,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      bool ifInToday,
    )
    deleteTodo,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      bool ifInToday,
    )
    toggleTodoCheck,
    required TResult Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )
    reorderTodos,
    required TResult Function(TLWorkspace workspace, bool ifInToday)
    deleteAllCheckedTodos,
    required TResult Function(TLWorkspace workspace, TLToDo todo, TLStep step)
    toggleStepCheck,
    required TResult Function(TLWorkspace workspace, TLToDo todo)
    toggleTodoTodayWhenever,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )
    reorderSteps,
  }) {
    return toggleStepCheck(workspace, todo, step);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace workspace, TLToDo todo)? addTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo)? updateTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    deleteTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    toggleTodoCheck,
    TResult? Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )?
    reorderTodos,
    TResult? Function(TLWorkspace workspace, bool ifInToday)?
    deleteAllCheckedTodos,
    TResult? Function(TLWorkspace workspace, TLToDo todo, TLStep step)?
    toggleStepCheck,
    TResult? Function(TLWorkspace workspace, TLToDo todo)?
    toggleTodoTodayWhenever,
    TResult? Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )?
    reorderSteps,
  }) {
    return toggleStepCheck?.call(workspace, todo, step);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace workspace, TLToDo todo)? addTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo)? updateTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    deleteTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    toggleTodoCheck,
    TResult Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )?
    reorderTodos,
    TResult Function(TLWorkspace workspace, bool ifInToday)?
    deleteAllCheckedTodos,
    TResult Function(TLWorkspace workspace, TLToDo todo, TLStep step)?
    toggleStepCheck,
    TResult Function(TLWorkspace workspace, TLToDo todo)?
    toggleTodoTodayWhenever,
    TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )?
    reorderSteps,
    required TResult orElse(),
  }) {
    if (toggleStepCheck != null) {
      return toggleStepCheck(workspace, todo, step);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddTodo value) addTodo,
    required TResult Function(_UpdateTodo value) updateTodo,
    required TResult Function(_DeleteTodo value) deleteTodo,
    required TResult Function(_ToggleTodoCheck value) toggleTodoCheck,
    required TResult Function(_ReorderTodos value) reorderTodos,
    required TResult Function(_DeleteAllCheckedTodos value)
    deleteAllCheckedTodos,
    required TResult Function(_ToggleStepCheck value) toggleStepCheck,
    required TResult Function(_ToggleTodoTodayWhenever value)
    toggleTodoTodayWhenever,
    required TResult Function(_ReorderSteps value) reorderSteps,
  }) {
    return toggleStepCheck(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddTodo value)? addTodo,
    TResult? Function(_UpdateTodo value)? updateTodo,
    TResult? Function(_DeleteTodo value)? deleteTodo,
    TResult? Function(_ToggleTodoCheck value)? toggleTodoCheck,
    TResult? Function(_ReorderTodos value)? reorderTodos,
    TResult? Function(_DeleteAllCheckedTodos value)? deleteAllCheckedTodos,
    TResult? Function(_ToggleStepCheck value)? toggleStepCheck,
    TResult? Function(_ToggleTodoTodayWhenever value)? toggleTodoTodayWhenever,
    TResult? Function(_ReorderSteps value)? reorderSteps,
  }) {
    return toggleStepCheck?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddTodo value)? addTodo,
    TResult Function(_UpdateTodo value)? updateTodo,
    TResult Function(_DeleteTodo value)? deleteTodo,
    TResult Function(_ToggleTodoCheck value)? toggleTodoCheck,
    TResult Function(_ReorderTodos value)? reorderTodos,
    TResult Function(_DeleteAllCheckedTodos value)? deleteAllCheckedTodos,
    TResult Function(_ToggleStepCheck value)? toggleStepCheck,
    TResult Function(_ToggleTodoTodayWhenever value)? toggleTodoTodayWhenever,
    TResult Function(_ReorderSteps value)? reorderSteps,
    required TResult orElse(),
  }) {
    if (toggleStepCheck != null) {
      return toggleStepCheck(this);
    }
    return orElse();
  }
}

abstract class _ToggleStepCheck implements TodoAction {
  const factory _ToggleStepCheck({
    required final TLWorkspace workspace,
    required final TLToDo todo,
    required final TLStep step,
  }) = _$ToggleStepCheckImpl;

  @override
  TLWorkspace get workspace;
  TLToDo get todo;
  TLStep get step;

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToggleStepCheckImplCopyWith<_$ToggleStepCheckImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToggleTodoTodayWheneverImplCopyWith<$Res>
    implements $TodoActionCopyWith<$Res> {
  factory _$$ToggleTodoTodayWheneverImplCopyWith(
    _$ToggleTodoTodayWheneverImpl value,
    $Res Function(_$ToggleTodoTodayWheneverImpl) then,
  ) = __$$ToggleTodoTodayWheneverImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TLWorkspace workspace, TLToDo todo});

  @override
  $TLWorkspaceCopyWith<$Res> get workspace;
  $TLToDoCopyWith<$Res> get todo;
}

/// @nodoc
class __$$ToggleTodoTodayWheneverImplCopyWithImpl<$Res>
    extends _$TodoActionCopyWithImpl<$Res, _$ToggleTodoTodayWheneverImpl>
    implements _$$ToggleTodoTodayWheneverImplCopyWith<$Res> {
  __$$ToggleTodoTodayWheneverImplCopyWithImpl(
    _$ToggleTodoTodayWheneverImpl _value,
    $Res Function(_$ToggleTodoTodayWheneverImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? workspace = null, Object? todo = null}) {
    return _then(
      _$ToggleTodoTodayWheneverImpl(
        workspace:
            null == workspace
                ? _value.workspace
                : workspace // ignore: cast_nullable_to_non_nullable
                    as TLWorkspace,
        todo:
            null == todo
                ? _value.todo
                : todo // ignore: cast_nullable_to_non_nullable
                    as TLToDo,
      ),
    );
  }

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLToDoCopyWith<$Res> get todo {
    return $TLToDoCopyWith<$Res>(_value.todo, (value) {
      return _then(_value.copyWith(todo: value));
    });
  }
}

/// @nodoc

class _$ToggleTodoTodayWheneverImpl implements _ToggleTodoTodayWhenever {
  const _$ToggleTodoTodayWheneverImpl({
    required this.workspace,
    required this.todo,
  });

  @override
  final TLWorkspace workspace;
  @override
  final TLToDo todo;

  @override
  String toString() {
    return 'TodoAction.toggleTodoTodayWhenever(workspace: $workspace, todo: $todo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToggleTodoTodayWheneverImpl &&
            (identical(other.workspace, workspace) ||
                other.workspace == workspace) &&
            (identical(other.todo, todo) || other.todo == todo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, workspace, todo);

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToggleTodoTodayWheneverImplCopyWith<_$ToggleTodoTodayWheneverImpl>
  get copyWith => __$$ToggleTodoTodayWheneverImplCopyWithImpl<
    _$ToggleTodoTodayWheneverImpl
  >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TLWorkspace workspace, TLToDo todo) addTodo,
    required TResult Function(TLWorkspace workspace, TLToDo todo) updateTodo,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      bool ifInToday,
    )
    deleteTodo,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      bool ifInToday,
    )
    toggleTodoCheck,
    required TResult Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )
    reorderTodos,
    required TResult Function(TLWorkspace workspace, bool ifInToday)
    deleteAllCheckedTodos,
    required TResult Function(TLWorkspace workspace, TLToDo todo, TLStep step)
    toggleStepCheck,
    required TResult Function(TLWorkspace workspace, TLToDo todo)
    toggleTodoTodayWhenever,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )
    reorderSteps,
  }) {
    return toggleTodoTodayWhenever(workspace, todo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace workspace, TLToDo todo)? addTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo)? updateTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    deleteTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    toggleTodoCheck,
    TResult? Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )?
    reorderTodos,
    TResult? Function(TLWorkspace workspace, bool ifInToday)?
    deleteAllCheckedTodos,
    TResult? Function(TLWorkspace workspace, TLToDo todo, TLStep step)?
    toggleStepCheck,
    TResult? Function(TLWorkspace workspace, TLToDo todo)?
    toggleTodoTodayWhenever,
    TResult? Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )?
    reorderSteps,
  }) {
    return toggleTodoTodayWhenever?.call(workspace, todo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace workspace, TLToDo todo)? addTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo)? updateTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    deleteTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    toggleTodoCheck,
    TResult Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )?
    reorderTodos,
    TResult Function(TLWorkspace workspace, bool ifInToday)?
    deleteAllCheckedTodos,
    TResult Function(TLWorkspace workspace, TLToDo todo, TLStep step)?
    toggleStepCheck,
    TResult Function(TLWorkspace workspace, TLToDo todo)?
    toggleTodoTodayWhenever,
    TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )?
    reorderSteps,
    required TResult orElse(),
  }) {
    if (toggleTodoTodayWhenever != null) {
      return toggleTodoTodayWhenever(workspace, todo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddTodo value) addTodo,
    required TResult Function(_UpdateTodo value) updateTodo,
    required TResult Function(_DeleteTodo value) deleteTodo,
    required TResult Function(_ToggleTodoCheck value) toggleTodoCheck,
    required TResult Function(_ReorderTodos value) reorderTodos,
    required TResult Function(_DeleteAllCheckedTodos value)
    deleteAllCheckedTodos,
    required TResult Function(_ToggleStepCheck value) toggleStepCheck,
    required TResult Function(_ToggleTodoTodayWhenever value)
    toggleTodoTodayWhenever,
    required TResult Function(_ReorderSteps value) reorderSteps,
  }) {
    return toggleTodoTodayWhenever(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddTodo value)? addTodo,
    TResult? Function(_UpdateTodo value)? updateTodo,
    TResult? Function(_DeleteTodo value)? deleteTodo,
    TResult? Function(_ToggleTodoCheck value)? toggleTodoCheck,
    TResult? Function(_ReorderTodos value)? reorderTodos,
    TResult? Function(_DeleteAllCheckedTodos value)? deleteAllCheckedTodos,
    TResult? Function(_ToggleStepCheck value)? toggleStepCheck,
    TResult? Function(_ToggleTodoTodayWhenever value)? toggleTodoTodayWhenever,
    TResult? Function(_ReorderSteps value)? reorderSteps,
  }) {
    return toggleTodoTodayWhenever?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddTodo value)? addTodo,
    TResult Function(_UpdateTodo value)? updateTodo,
    TResult Function(_DeleteTodo value)? deleteTodo,
    TResult Function(_ToggleTodoCheck value)? toggleTodoCheck,
    TResult Function(_ReorderTodos value)? reorderTodos,
    TResult Function(_DeleteAllCheckedTodos value)? deleteAllCheckedTodos,
    TResult Function(_ToggleStepCheck value)? toggleStepCheck,
    TResult Function(_ToggleTodoTodayWhenever value)? toggleTodoTodayWhenever,
    TResult Function(_ReorderSteps value)? reorderSteps,
    required TResult orElse(),
  }) {
    if (toggleTodoTodayWhenever != null) {
      return toggleTodoTodayWhenever(this);
    }
    return orElse();
  }
}

abstract class _ToggleTodoTodayWhenever implements TodoAction {
  const factory _ToggleTodoTodayWhenever({
    required final TLWorkspace workspace,
    required final TLToDo todo,
  }) = _$ToggleTodoTodayWheneverImpl;

  @override
  TLWorkspace get workspace;
  TLToDo get todo;

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToggleTodoTodayWheneverImplCopyWith<_$ToggleTodoTodayWheneverImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReorderStepsImplCopyWith<$Res>
    implements $TodoActionCopyWith<$Res> {
  factory _$$ReorderStepsImplCopyWith(
    _$ReorderStepsImpl value,
    $Res Function(_$ReorderStepsImpl) then,
  ) = __$$ReorderStepsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TLWorkspace workspace, TLToDo todo, int oldIndex, int newIndex});

  @override
  $TLWorkspaceCopyWith<$Res> get workspace;
  $TLToDoCopyWith<$Res> get todo;
}

/// @nodoc
class __$$ReorderStepsImplCopyWithImpl<$Res>
    extends _$TodoActionCopyWithImpl<$Res, _$ReorderStepsImpl>
    implements _$$ReorderStepsImplCopyWith<$Res> {
  __$$ReorderStepsImplCopyWithImpl(
    _$ReorderStepsImpl _value,
    $Res Function(_$ReorderStepsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workspace = null,
    Object? todo = null,
    Object? oldIndex = null,
    Object? newIndex = null,
  }) {
    return _then(
      _$ReorderStepsImpl(
        workspace:
            null == workspace
                ? _value.workspace
                : workspace // ignore: cast_nullable_to_non_nullable
                    as TLWorkspace,
        todo:
            null == todo
                ? _value.todo
                : todo // ignore: cast_nullable_to_non_nullable
                    as TLToDo,
        oldIndex:
            null == oldIndex
                ? _value.oldIndex
                : oldIndex // ignore: cast_nullable_to_non_nullable
                    as int,
        newIndex:
            null == newIndex
                ? _value.newIndex
                : newIndex // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLToDoCopyWith<$Res> get todo {
    return $TLToDoCopyWith<$Res>(_value.todo, (value) {
      return _then(_value.copyWith(todo: value));
    });
  }
}

/// @nodoc

class _$ReorderStepsImpl implements _ReorderSteps {
  const _$ReorderStepsImpl({
    required this.workspace,
    required this.todo,
    required this.oldIndex,
    required this.newIndex,
  });

  @override
  final TLWorkspace workspace;
  @override
  final TLToDo todo;
  @override
  final int oldIndex;
  @override
  final int newIndex;

  @override
  String toString() {
    return 'TodoAction.reorderSteps(workspace: $workspace, todo: $todo, oldIndex: $oldIndex, newIndex: $newIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReorderStepsImpl &&
            (identical(other.workspace, workspace) ||
                other.workspace == workspace) &&
            (identical(other.todo, todo) || other.todo == todo) &&
            (identical(other.oldIndex, oldIndex) ||
                other.oldIndex == oldIndex) &&
            (identical(other.newIndex, newIndex) ||
                other.newIndex == newIndex));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, workspace, todo, oldIndex, newIndex);

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReorderStepsImplCopyWith<_$ReorderStepsImpl> get copyWith =>
      __$$ReorderStepsImplCopyWithImpl<_$ReorderStepsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TLWorkspace workspace, TLToDo todo) addTodo,
    required TResult Function(TLWorkspace workspace, TLToDo todo) updateTodo,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      bool ifInToday,
    )
    deleteTodo,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      bool ifInToday,
    )
    toggleTodoCheck,
    required TResult Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )
    reorderTodos,
    required TResult Function(TLWorkspace workspace, bool ifInToday)
    deleteAllCheckedTodos,
    required TResult Function(TLWorkspace workspace, TLToDo todo, TLStep step)
    toggleStepCheck,
    required TResult Function(TLWorkspace workspace, TLToDo todo)
    toggleTodoTodayWhenever,
    required TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )
    reorderSteps,
  }) {
    return reorderSteps(workspace, todo, oldIndex, newIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace workspace, TLToDo todo)? addTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo)? updateTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    deleteTodo,
    TResult? Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    toggleTodoCheck,
    TResult? Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )?
    reorderTodos,
    TResult? Function(TLWorkspace workspace, bool ifInToday)?
    deleteAllCheckedTodos,
    TResult? Function(TLWorkspace workspace, TLToDo todo, TLStep step)?
    toggleStepCheck,
    TResult? Function(TLWorkspace workspace, TLToDo todo)?
    toggleTodoTodayWhenever,
    TResult? Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )?
    reorderSteps,
  }) {
    return reorderSteps?.call(workspace, todo, oldIndex, newIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace workspace, TLToDo todo)? addTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo)? updateTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    deleteTodo,
    TResult Function(TLWorkspace workspace, TLToDo todo, bool ifInToday)?
    toggleTodoCheck,
    TResult Function(
      TLWorkspace workspace,
      List<TLToDo> todos,
      int oldIndex,
      int newIndex,
      String category,
      bool ifInToday,
    )?
    reorderTodos,
    TResult Function(TLWorkspace workspace, bool ifInToday)?
    deleteAllCheckedTodos,
    TResult Function(TLWorkspace workspace, TLToDo todo, TLStep step)?
    toggleStepCheck,
    TResult Function(TLWorkspace workspace, TLToDo todo)?
    toggleTodoTodayWhenever,
    TResult Function(
      TLWorkspace workspace,
      TLToDo todo,
      int oldIndex,
      int newIndex,
    )?
    reorderSteps,
    required TResult orElse(),
  }) {
    if (reorderSteps != null) {
      return reorderSteps(workspace, todo, oldIndex, newIndex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddTodo value) addTodo,
    required TResult Function(_UpdateTodo value) updateTodo,
    required TResult Function(_DeleteTodo value) deleteTodo,
    required TResult Function(_ToggleTodoCheck value) toggleTodoCheck,
    required TResult Function(_ReorderTodos value) reorderTodos,
    required TResult Function(_DeleteAllCheckedTodos value)
    deleteAllCheckedTodos,
    required TResult Function(_ToggleStepCheck value) toggleStepCheck,
    required TResult Function(_ToggleTodoTodayWhenever value)
    toggleTodoTodayWhenever,
    required TResult Function(_ReorderSteps value) reorderSteps,
  }) {
    return reorderSteps(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddTodo value)? addTodo,
    TResult? Function(_UpdateTodo value)? updateTodo,
    TResult? Function(_DeleteTodo value)? deleteTodo,
    TResult? Function(_ToggleTodoCheck value)? toggleTodoCheck,
    TResult? Function(_ReorderTodos value)? reorderTodos,
    TResult? Function(_DeleteAllCheckedTodos value)? deleteAllCheckedTodos,
    TResult? Function(_ToggleStepCheck value)? toggleStepCheck,
    TResult? Function(_ToggleTodoTodayWhenever value)? toggleTodoTodayWhenever,
    TResult? Function(_ReorderSteps value)? reorderSteps,
  }) {
    return reorderSteps?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddTodo value)? addTodo,
    TResult Function(_UpdateTodo value)? updateTodo,
    TResult Function(_DeleteTodo value)? deleteTodo,
    TResult Function(_ToggleTodoCheck value)? toggleTodoCheck,
    TResult Function(_ReorderTodos value)? reorderTodos,
    TResult Function(_DeleteAllCheckedTodos value)? deleteAllCheckedTodos,
    TResult Function(_ToggleStepCheck value)? toggleStepCheck,
    TResult Function(_ToggleTodoTodayWhenever value)? toggleTodoTodayWhenever,
    TResult Function(_ReorderSteps value)? reorderSteps,
    required TResult orElse(),
  }) {
    if (reorderSteps != null) {
      return reorderSteps(this);
    }
    return orElse();
  }
}

abstract class _ReorderSteps implements TodoAction {
  const factory _ReorderSteps({
    required final TLWorkspace workspace,
    required final TLToDo todo,
    required final int oldIndex,
    required final int newIndex,
  }) = _$ReorderStepsImpl;

  @override
  TLWorkspace get workspace;
  TLToDo get todo;
  int get oldIndex;
  int get newIndex;

  /// Create a copy of TodoAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReorderStepsImplCopyWith<_$ReorderStepsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
