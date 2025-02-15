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
  String get workspaceID => throw _privateConstructorUsedError;
  String get categoryID => throw _privateConstructorUsedError;
  bool get ifInToday => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String workspaceID, String categoryID, bool ifInToday, TLToDo todo)
        addToDo,
    required TResult Function(String workspaceID, String categoryID,
            bool ifInToday, int index, TLToDo newToDo)
        updateToDo,
    required TResult Function(
            String workspaceID, String categoryID, bool ifInToday, int index)
        removeToDo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String workspaceID, String categoryID, bool ifInToday, TLToDo todo)?
        addToDo,
    TResult? Function(String workspaceID, String categoryID, bool ifInToday,
            int index, TLToDo newToDo)?
        updateToDo,
    TResult? Function(
            String workspaceID, String categoryID, bool ifInToday, int index)?
        removeToDo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String workspaceID, String categoryID, bool ifInToday, TLToDo todo)?
        addToDo,
    TResult Function(String workspaceID, String categoryID, bool ifInToday,
            int index, TLToDo newToDo)?
        updateToDo,
    TResult Function(
            String workspaceID, String categoryID, bool ifInToday, int index)?
        removeToDo,
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
  $Res call({String workspaceID, String categoryID, bool ifInToday});
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
    Object? workspaceID = null,
    Object? categoryID = null,
    Object? ifInToday = null,
  }) {
    return _then(_value.copyWith(
      workspaceID: null == workspaceID
          ? _value.workspaceID
          : workspaceID // ignore: cast_nullable_to_non_nullable
              as String,
      categoryID: null == categoryID
          ? _value.categoryID
          : categoryID // ignore: cast_nullable_to_non_nullable
              as String,
      ifInToday: null == ifInToday
          ? _value.ifInToday
          : ifInToday // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
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
  $Res call(
      {String workspaceID, String categoryID, bool ifInToday, TLToDo todo});

  $TLToDoCopyWith<$Res> get todo;
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
    Object? workspaceID = null,
    Object? categoryID = null,
    Object? ifInToday = null,
    Object? todo = null,
  }) {
    return _then(_$AddToDoImpl(
      workspaceID: null == workspaceID
          ? _value.workspaceID
          : workspaceID // ignore: cast_nullable_to_non_nullable
              as String,
      categoryID: null == categoryID
          ? _value.categoryID
          : categoryID // ignore: cast_nullable_to_non_nullable
              as String,
      ifInToday: null == ifInToday
          ? _value.ifInToday
          : ifInToday // ignore: cast_nullable_to_non_nullable
              as bool,
      todo: null == todo
          ? _value.todo
          : todo // ignore: cast_nullable_to_non_nullable
              as TLToDo,
    ));
  }

  /// Create a copy of TLToDoAction
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

class _$AddToDoImpl implements _AddToDo {
  const _$AddToDoImpl(
      {required this.workspaceID,
      required this.categoryID,
      required this.ifInToday,
      required this.todo});

  @override
  final String workspaceID;
  @override
  final String categoryID;
  @override
  final bool ifInToday;
  @override
  final TLToDo todo;

  @override
  String toString() {
    return 'TLToDoAction.addToDo(workspaceID: $workspaceID, categoryID: $categoryID, ifInToday: $ifInToday, todo: $todo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddToDoImpl &&
            (identical(other.workspaceID, workspaceID) ||
                other.workspaceID == workspaceID) &&
            (identical(other.categoryID, categoryID) ||
                other.categoryID == categoryID) &&
            (identical(other.ifInToday, ifInToday) ||
                other.ifInToday == ifInToday) &&
            (identical(other.todo, todo) || other.todo == todo));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, workspaceID, categoryID, ifInToday, todo);

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
    required TResult Function(
            String workspaceID, String categoryID, bool ifInToday, TLToDo todo)
        addToDo,
    required TResult Function(String workspaceID, String categoryID,
            bool ifInToday, int index, TLToDo newToDo)
        updateToDo,
    required TResult Function(
            String workspaceID, String categoryID, bool ifInToday, int index)
        removeToDo,
  }) {
    return addToDo(workspaceID, categoryID, ifInToday, todo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String workspaceID, String categoryID, bool ifInToday, TLToDo todo)?
        addToDo,
    TResult? Function(String workspaceID, String categoryID, bool ifInToday,
            int index, TLToDo newToDo)?
        updateToDo,
    TResult? Function(
            String workspaceID, String categoryID, bool ifInToday, int index)?
        removeToDo,
  }) {
    return addToDo?.call(workspaceID, categoryID, ifInToday, todo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String workspaceID, String categoryID, bool ifInToday, TLToDo todo)?
        addToDo,
    TResult Function(String workspaceID, String categoryID, bool ifInToday,
            int index, TLToDo newToDo)?
        updateToDo,
    TResult Function(
            String workspaceID, String categoryID, bool ifInToday, int index)?
        removeToDo,
    required TResult orElse(),
  }) {
    if (addToDo != null) {
      return addToDo(workspaceID, categoryID, ifInToday, todo);
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
  const factory _AddToDo(
      {required final String workspaceID,
      required final String categoryID,
      required final bool ifInToday,
      required final TLToDo todo}) = _$AddToDoImpl;

  @override
  String get workspaceID;
  @override
  String get categoryID;
  @override
  bool get ifInToday;
  TLToDo get todo;

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
  $Res call(
      {String workspaceID,
      String categoryID,
      bool ifInToday,
      int index,
      TLToDo newToDo});

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
    Object? workspaceID = null,
    Object? categoryID = null,
    Object? ifInToday = null,
    Object? index = null,
    Object? newToDo = null,
  }) {
    return _then(_$UpdateToDoImpl(
      workspaceID: null == workspaceID
          ? _value.workspaceID
          : workspaceID // ignore: cast_nullable_to_non_nullable
              as String,
      categoryID: null == categoryID
          ? _value.categoryID
          : categoryID // ignore: cast_nullable_to_non_nullable
              as String,
      ifInToday: null == ifInToday
          ? _value.ifInToday
          : ifInToday // ignore: cast_nullable_to_non_nullable
              as bool,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
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
  const _$UpdateToDoImpl(
      {required this.workspaceID,
      required this.categoryID,
      required this.ifInToday,
      required this.index,
      required this.newToDo});

  @override
  final String workspaceID;
  @override
  final String categoryID;
  @override
  final bool ifInToday;
  @override
  final int index;
  @override
  final TLToDo newToDo;

  @override
  String toString() {
    return 'TLToDoAction.updateToDo(workspaceID: $workspaceID, categoryID: $categoryID, ifInToday: $ifInToday, index: $index, newToDo: $newToDo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateToDoImpl &&
            (identical(other.workspaceID, workspaceID) ||
                other.workspaceID == workspaceID) &&
            (identical(other.categoryID, categoryID) ||
                other.categoryID == categoryID) &&
            (identical(other.ifInToday, ifInToday) ||
                other.ifInToday == ifInToday) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.newToDo, newToDo) || other.newToDo == newToDo));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, workspaceID, categoryID, ifInToday, index, newToDo);

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
    required TResult Function(
            String workspaceID, String categoryID, bool ifInToday, TLToDo todo)
        addToDo,
    required TResult Function(String workspaceID, String categoryID,
            bool ifInToday, int index, TLToDo newToDo)
        updateToDo,
    required TResult Function(
            String workspaceID, String categoryID, bool ifInToday, int index)
        removeToDo,
  }) {
    return updateToDo(workspaceID, categoryID, ifInToday, index, newToDo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String workspaceID, String categoryID, bool ifInToday, TLToDo todo)?
        addToDo,
    TResult? Function(String workspaceID, String categoryID, bool ifInToday,
            int index, TLToDo newToDo)?
        updateToDo,
    TResult? Function(
            String workspaceID, String categoryID, bool ifInToday, int index)?
        removeToDo,
  }) {
    return updateToDo?.call(workspaceID, categoryID, ifInToday, index, newToDo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String workspaceID, String categoryID, bool ifInToday, TLToDo todo)?
        addToDo,
    TResult Function(String workspaceID, String categoryID, bool ifInToday,
            int index, TLToDo newToDo)?
        updateToDo,
    TResult Function(
            String workspaceID, String categoryID, bool ifInToday, int index)?
        removeToDo,
    required TResult orElse(),
  }) {
    if (updateToDo != null) {
      return updateToDo(workspaceID, categoryID, ifInToday, index, newToDo);
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
  const factory _UpdateToDo(
      {required final String workspaceID,
      required final String categoryID,
      required final bool ifInToday,
      required final int index,
      required final TLToDo newToDo}) = _$UpdateToDoImpl;

  @override
  String get workspaceID;
  @override
  String get categoryID;
  @override
  bool get ifInToday;
  int get index;
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
  $Res call({String workspaceID, String categoryID, bool ifInToday, int index});
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
    Object? workspaceID = null,
    Object? categoryID = null,
    Object? ifInToday = null,
    Object? index = null,
  }) {
    return _then(_$RemoveToDoImpl(
      workspaceID: null == workspaceID
          ? _value.workspaceID
          : workspaceID // ignore: cast_nullable_to_non_nullable
              as String,
      categoryID: null == categoryID
          ? _value.categoryID
          : categoryID // ignore: cast_nullable_to_non_nullable
              as String,
      ifInToday: null == ifInToday
          ? _value.ifInToday
          : ifInToday // ignore: cast_nullable_to_non_nullable
              as bool,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$RemoveToDoImpl implements _RemoveToDo {
  const _$RemoveToDoImpl(
      {required this.workspaceID,
      required this.categoryID,
      required this.ifInToday,
      required this.index});

  @override
  final String workspaceID;
  @override
  final String categoryID;
  @override
  final bool ifInToday;
  @override
  final int index;

  @override
  String toString() {
    return 'TLToDoAction.removeToDo(workspaceID: $workspaceID, categoryID: $categoryID, ifInToday: $ifInToday, index: $index)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveToDoImpl &&
            (identical(other.workspaceID, workspaceID) ||
                other.workspaceID == workspaceID) &&
            (identical(other.categoryID, categoryID) ||
                other.categoryID == categoryID) &&
            (identical(other.ifInToday, ifInToday) ||
                other.ifInToday == ifInToday) &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, workspaceID, categoryID, ifInToday, index);

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
    required TResult Function(
            String workspaceID, String categoryID, bool ifInToday, TLToDo todo)
        addToDo,
    required TResult Function(String workspaceID, String categoryID,
            bool ifInToday, int index, TLToDo newToDo)
        updateToDo,
    required TResult Function(
            String workspaceID, String categoryID, bool ifInToday, int index)
        removeToDo,
  }) {
    return removeToDo(workspaceID, categoryID, ifInToday, index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String workspaceID, String categoryID, bool ifInToday, TLToDo todo)?
        addToDo,
    TResult? Function(String workspaceID, String categoryID, bool ifInToday,
            int index, TLToDo newToDo)?
        updateToDo,
    TResult? Function(
            String workspaceID, String categoryID, bool ifInToday, int index)?
        removeToDo,
  }) {
    return removeToDo?.call(workspaceID, categoryID, ifInToday, index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String workspaceID, String categoryID, bool ifInToday, TLToDo todo)?
        addToDo,
    TResult Function(String workspaceID, String categoryID, bool ifInToday,
            int index, TLToDo newToDo)?
        updateToDo,
    TResult Function(
            String workspaceID, String categoryID, bool ifInToday, int index)?
        removeToDo,
    required TResult orElse(),
  }) {
    if (removeToDo != null) {
      return removeToDo(workspaceID, categoryID, ifInToday, index);
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
  const factory _RemoveToDo(
      {required final String workspaceID,
      required final String categoryID,
      required final bool ifInToday,
      required final int index}) = _$RemoveToDoImpl;

  @override
  String get workspaceID;
  @override
  String get categoryID;
  @override
  bool get ifInToday;
  int get index;

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveToDoImplCopyWith<_$RemoveToDoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
