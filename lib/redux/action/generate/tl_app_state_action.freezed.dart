// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../tl_app_state_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TLAppStateAction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? newID) changeCurrentWorkspaceID,
    required TResult Function(List<TLWorkspace> tlWorkspaces) saveWorkspaceList,
    required TResult Function(List<TLWorkspace> corrWorkspaceList)
        deleteAllCheckedToDosInTodayInWorkspaceList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? newID)? changeCurrentWorkspaceID,
    TResult? Function(List<TLWorkspace> tlWorkspaces)? saveWorkspaceList,
    TResult? Function(List<TLWorkspace> corrWorkspaceList)?
        deleteAllCheckedToDosInTodayInWorkspaceList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? newID)? changeCurrentWorkspaceID,
    TResult Function(List<TLWorkspace> tlWorkspaces)? saveWorkspaceList,
    TResult Function(List<TLWorkspace> corrWorkspaceList)?
        deleteAllCheckedToDosInTodayInWorkspaceList,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangeCurrentWorkspaceID value)
        changeCurrentWorkspaceID,
    required TResult Function(SaveWorkspaceList value) saveWorkspaceList,
    required TResult Function(DeleteAllCheckedToDosInTodayInWorkspaceList value)
        deleteAllCheckedToDosInTodayInWorkspaceList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangeCurrentWorkspaceID value)? changeCurrentWorkspaceID,
    TResult? Function(SaveWorkspaceList value)? saveWorkspaceList,
    TResult? Function(DeleteAllCheckedToDosInTodayInWorkspaceList value)?
        deleteAllCheckedToDosInTodayInWorkspaceList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangeCurrentWorkspaceID value)? changeCurrentWorkspaceID,
    TResult Function(SaveWorkspaceList value)? saveWorkspaceList,
    TResult Function(DeleteAllCheckedToDosInTodayInWorkspaceList value)?
        deleteAllCheckedToDosInTodayInWorkspaceList,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TLAppStateActionCopyWith<$Res> {
  factory $TLAppStateActionCopyWith(
          TLAppStateAction value, $Res Function(TLAppStateAction) then) =
      _$TLAppStateActionCopyWithImpl<$Res, TLAppStateAction>;
}

/// @nodoc
class _$TLAppStateActionCopyWithImpl<$Res, $Val extends TLAppStateAction>
    implements $TLAppStateActionCopyWith<$Res> {
  _$TLAppStateActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TLAppStateAction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ChangeCurrentWorkspaceIDImplCopyWith<$Res> {
  factory _$$ChangeCurrentWorkspaceIDImplCopyWith(
          _$ChangeCurrentWorkspaceIDImpl value,
          $Res Function(_$ChangeCurrentWorkspaceIDImpl) then) =
      __$$ChangeCurrentWorkspaceIDImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? newID});
}

/// @nodoc
class __$$ChangeCurrentWorkspaceIDImplCopyWithImpl<$Res>
    extends _$TLAppStateActionCopyWithImpl<$Res, _$ChangeCurrentWorkspaceIDImpl>
    implements _$$ChangeCurrentWorkspaceIDImplCopyWith<$Res> {
  __$$ChangeCurrentWorkspaceIDImplCopyWithImpl(
      _$ChangeCurrentWorkspaceIDImpl _value,
      $Res Function(_$ChangeCurrentWorkspaceIDImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLAppStateAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newID = freezed,
  }) {
    return _then(_$ChangeCurrentWorkspaceIDImpl(
      freezed == newID
          ? _value.newID
          : newID // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ChangeCurrentWorkspaceIDImpl implements ChangeCurrentWorkspaceID {
  const _$ChangeCurrentWorkspaceIDImpl(this.newID);

  @override
  final String? newID;

  @override
  String toString() {
    return 'TLAppStateAction.changeCurrentWorkspaceID(newID: $newID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeCurrentWorkspaceIDImpl &&
            (identical(other.newID, newID) || other.newID == newID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newID);

  /// Create a copy of TLAppStateAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeCurrentWorkspaceIDImplCopyWith<_$ChangeCurrentWorkspaceIDImpl>
      get copyWith => __$$ChangeCurrentWorkspaceIDImplCopyWithImpl<
          _$ChangeCurrentWorkspaceIDImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? newID) changeCurrentWorkspaceID,
    required TResult Function(List<TLWorkspace> tlWorkspaces) saveWorkspaceList,
    required TResult Function(List<TLWorkspace> corrWorkspaceList)
        deleteAllCheckedToDosInTodayInWorkspaceList,
  }) {
    return changeCurrentWorkspaceID(newID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? newID)? changeCurrentWorkspaceID,
    TResult? Function(List<TLWorkspace> tlWorkspaces)? saveWorkspaceList,
    TResult? Function(List<TLWorkspace> corrWorkspaceList)?
        deleteAllCheckedToDosInTodayInWorkspaceList,
  }) {
    return changeCurrentWorkspaceID?.call(newID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? newID)? changeCurrentWorkspaceID,
    TResult Function(List<TLWorkspace> tlWorkspaces)? saveWorkspaceList,
    TResult Function(List<TLWorkspace> corrWorkspaceList)?
        deleteAllCheckedToDosInTodayInWorkspaceList,
    required TResult orElse(),
  }) {
    if (changeCurrentWorkspaceID != null) {
      return changeCurrentWorkspaceID(newID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangeCurrentWorkspaceID value)
        changeCurrentWorkspaceID,
    required TResult Function(SaveWorkspaceList value) saveWorkspaceList,
    required TResult Function(DeleteAllCheckedToDosInTodayInWorkspaceList value)
        deleteAllCheckedToDosInTodayInWorkspaceList,
  }) {
    return changeCurrentWorkspaceID(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangeCurrentWorkspaceID value)? changeCurrentWorkspaceID,
    TResult? Function(SaveWorkspaceList value)? saveWorkspaceList,
    TResult? Function(DeleteAllCheckedToDosInTodayInWorkspaceList value)?
        deleteAllCheckedToDosInTodayInWorkspaceList,
  }) {
    return changeCurrentWorkspaceID?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangeCurrentWorkspaceID value)? changeCurrentWorkspaceID,
    TResult Function(SaveWorkspaceList value)? saveWorkspaceList,
    TResult Function(DeleteAllCheckedToDosInTodayInWorkspaceList value)?
        deleteAllCheckedToDosInTodayInWorkspaceList,
    required TResult orElse(),
  }) {
    if (changeCurrentWorkspaceID != null) {
      return changeCurrentWorkspaceID(this);
    }
    return orElse();
  }
}

abstract class ChangeCurrentWorkspaceID implements TLAppStateAction {
  const factory ChangeCurrentWorkspaceID(final String? newID) =
      _$ChangeCurrentWorkspaceIDImpl;

  String? get newID;

  /// Create a copy of TLAppStateAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangeCurrentWorkspaceIDImplCopyWith<_$ChangeCurrentWorkspaceIDImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SaveWorkspaceListImplCopyWith<$Res> {
  factory _$$SaveWorkspaceListImplCopyWith(_$SaveWorkspaceListImpl value,
          $Res Function(_$SaveWorkspaceListImpl) then) =
      __$$SaveWorkspaceListImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<TLWorkspace> tlWorkspaces});
}

/// @nodoc
class __$$SaveWorkspaceListImplCopyWithImpl<$Res>
    extends _$TLAppStateActionCopyWithImpl<$Res, _$SaveWorkspaceListImpl>
    implements _$$SaveWorkspaceListImplCopyWith<$Res> {
  __$$SaveWorkspaceListImplCopyWithImpl(_$SaveWorkspaceListImpl _value,
      $Res Function(_$SaveWorkspaceListImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLAppStateAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tlWorkspaces = null,
  }) {
    return _then(_$SaveWorkspaceListImpl(
      null == tlWorkspaces
          ? _value._tlWorkspaces
          : tlWorkspaces // ignore: cast_nullable_to_non_nullable
              as List<TLWorkspace>,
    ));
  }
}

/// @nodoc

class _$SaveWorkspaceListImpl implements SaveWorkspaceList {
  const _$SaveWorkspaceListImpl(final List<TLWorkspace> tlWorkspaces)
      : _tlWorkspaces = tlWorkspaces;

  final List<TLWorkspace> _tlWorkspaces;
  @override
  List<TLWorkspace> get tlWorkspaces {
    if (_tlWorkspaces is EqualUnmodifiableListView) return _tlWorkspaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tlWorkspaces);
  }

  @override
  String toString() {
    return 'TLAppStateAction.saveWorkspaceList(tlWorkspaces: $tlWorkspaces)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveWorkspaceListImpl &&
            const DeepCollectionEquality()
                .equals(other._tlWorkspaces, _tlWorkspaces));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_tlWorkspaces));

  /// Create a copy of TLAppStateAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaveWorkspaceListImplCopyWith<_$SaveWorkspaceListImpl> get copyWith =>
      __$$SaveWorkspaceListImplCopyWithImpl<_$SaveWorkspaceListImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? newID) changeCurrentWorkspaceID,
    required TResult Function(List<TLWorkspace> tlWorkspaces) saveWorkspaceList,
    required TResult Function(List<TLWorkspace> corrWorkspaceList)
        deleteAllCheckedToDosInTodayInWorkspaceList,
  }) {
    return saveWorkspaceList(tlWorkspaces);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? newID)? changeCurrentWorkspaceID,
    TResult? Function(List<TLWorkspace> tlWorkspaces)? saveWorkspaceList,
    TResult? Function(List<TLWorkspace> corrWorkspaceList)?
        deleteAllCheckedToDosInTodayInWorkspaceList,
  }) {
    return saveWorkspaceList?.call(tlWorkspaces);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? newID)? changeCurrentWorkspaceID,
    TResult Function(List<TLWorkspace> tlWorkspaces)? saveWorkspaceList,
    TResult Function(List<TLWorkspace> corrWorkspaceList)?
        deleteAllCheckedToDosInTodayInWorkspaceList,
    required TResult orElse(),
  }) {
    if (saveWorkspaceList != null) {
      return saveWorkspaceList(tlWorkspaces);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangeCurrentWorkspaceID value)
        changeCurrentWorkspaceID,
    required TResult Function(SaveWorkspaceList value) saveWorkspaceList,
    required TResult Function(DeleteAllCheckedToDosInTodayInWorkspaceList value)
        deleteAllCheckedToDosInTodayInWorkspaceList,
  }) {
    return saveWorkspaceList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangeCurrentWorkspaceID value)? changeCurrentWorkspaceID,
    TResult? Function(SaveWorkspaceList value)? saveWorkspaceList,
    TResult? Function(DeleteAllCheckedToDosInTodayInWorkspaceList value)?
        deleteAllCheckedToDosInTodayInWorkspaceList,
  }) {
    return saveWorkspaceList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangeCurrentWorkspaceID value)? changeCurrentWorkspaceID,
    TResult Function(SaveWorkspaceList value)? saveWorkspaceList,
    TResult Function(DeleteAllCheckedToDosInTodayInWorkspaceList value)?
        deleteAllCheckedToDosInTodayInWorkspaceList,
    required TResult orElse(),
  }) {
    if (saveWorkspaceList != null) {
      return saveWorkspaceList(this);
    }
    return orElse();
  }
}

abstract class SaveWorkspaceList implements TLAppStateAction {
  const factory SaveWorkspaceList(final List<TLWorkspace> tlWorkspaces) =
      _$SaveWorkspaceListImpl;

  List<TLWorkspace> get tlWorkspaces;

  /// Create a copy of TLAppStateAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaveWorkspaceListImplCopyWith<_$SaveWorkspaceListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteAllCheckedToDosInTodayInWorkspaceListImplCopyWith<
    $Res> {
  factory _$$DeleteAllCheckedToDosInTodayInWorkspaceListImplCopyWith(
          _$DeleteAllCheckedToDosInTodayInWorkspaceListImpl value,
          $Res Function(_$DeleteAllCheckedToDosInTodayInWorkspaceListImpl)
              then) =
      __$$DeleteAllCheckedToDosInTodayInWorkspaceListImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<TLWorkspace> corrWorkspaceList});
}

/// @nodoc
class __$$DeleteAllCheckedToDosInTodayInWorkspaceListImplCopyWithImpl<$Res>
    extends _$TLAppStateActionCopyWithImpl<$Res,
        _$DeleteAllCheckedToDosInTodayInWorkspaceListImpl>
    implements
        _$$DeleteAllCheckedToDosInTodayInWorkspaceListImplCopyWith<$Res> {
  __$$DeleteAllCheckedToDosInTodayInWorkspaceListImplCopyWithImpl(
      _$DeleteAllCheckedToDosInTodayInWorkspaceListImpl _value,
      $Res Function(_$DeleteAllCheckedToDosInTodayInWorkspaceListImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLAppStateAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? corrWorkspaceList = null,
  }) {
    return _then(_$DeleteAllCheckedToDosInTodayInWorkspaceListImpl(
      null == corrWorkspaceList
          ? _value._corrWorkspaceList
          : corrWorkspaceList // ignore: cast_nullable_to_non_nullable
              as List<TLWorkspace>,
    ));
  }
}

/// @nodoc

class _$DeleteAllCheckedToDosInTodayInWorkspaceListImpl
    implements DeleteAllCheckedToDosInTodayInWorkspaceList {
  const _$DeleteAllCheckedToDosInTodayInWorkspaceListImpl(
      final List<TLWorkspace> corrWorkspaceList)
      : _corrWorkspaceList = corrWorkspaceList;

  final List<TLWorkspace> _corrWorkspaceList;
  @override
  List<TLWorkspace> get corrWorkspaceList {
    if (_corrWorkspaceList is EqualUnmodifiableListView)
      return _corrWorkspaceList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_corrWorkspaceList);
  }

  @override
  String toString() {
    return 'TLAppStateAction.deleteAllCheckedToDosInTodayInWorkspaceList(corrWorkspaceList: $corrWorkspaceList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteAllCheckedToDosInTodayInWorkspaceListImpl &&
            const DeepCollectionEquality()
                .equals(other._corrWorkspaceList, _corrWorkspaceList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_corrWorkspaceList));

  /// Create a copy of TLAppStateAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteAllCheckedToDosInTodayInWorkspaceListImplCopyWith<
          _$DeleteAllCheckedToDosInTodayInWorkspaceListImpl>
      get copyWith =>
          __$$DeleteAllCheckedToDosInTodayInWorkspaceListImplCopyWithImpl<
                  _$DeleteAllCheckedToDosInTodayInWorkspaceListImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? newID) changeCurrentWorkspaceID,
    required TResult Function(List<TLWorkspace> tlWorkspaces) saveWorkspaceList,
    required TResult Function(List<TLWorkspace> corrWorkspaceList)
        deleteAllCheckedToDosInTodayInWorkspaceList,
  }) {
    return deleteAllCheckedToDosInTodayInWorkspaceList(corrWorkspaceList);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? newID)? changeCurrentWorkspaceID,
    TResult? Function(List<TLWorkspace> tlWorkspaces)? saveWorkspaceList,
    TResult? Function(List<TLWorkspace> corrWorkspaceList)?
        deleteAllCheckedToDosInTodayInWorkspaceList,
  }) {
    return deleteAllCheckedToDosInTodayInWorkspaceList?.call(corrWorkspaceList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? newID)? changeCurrentWorkspaceID,
    TResult Function(List<TLWorkspace> tlWorkspaces)? saveWorkspaceList,
    TResult Function(List<TLWorkspace> corrWorkspaceList)?
        deleteAllCheckedToDosInTodayInWorkspaceList,
    required TResult orElse(),
  }) {
    if (deleteAllCheckedToDosInTodayInWorkspaceList != null) {
      return deleteAllCheckedToDosInTodayInWorkspaceList(corrWorkspaceList);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangeCurrentWorkspaceID value)
        changeCurrentWorkspaceID,
    required TResult Function(SaveWorkspaceList value) saveWorkspaceList,
    required TResult Function(DeleteAllCheckedToDosInTodayInWorkspaceList value)
        deleteAllCheckedToDosInTodayInWorkspaceList,
  }) {
    return deleteAllCheckedToDosInTodayInWorkspaceList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangeCurrentWorkspaceID value)? changeCurrentWorkspaceID,
    TResult? Function(SaveWorkspaceList value)? saveWorkspaceList,
    TResult? Function(DeleteAllCheckedToDosInTodayInWorkspaceList value)?
        deleteAllCheckedToDosInTodayInWorkspaceList,
  }) {
    return deleteAllCheckedToDosInTodayInWorkspaceList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangeCurrentWorkspaceID value)? changeCurrentWorkspaceID,
    TResult Function(SaveWorkspaceList value)? saveWorkspaceList,
    TResult Function(DeleteAllCheckedToDosInTodayInWorkspaceList value)?
        deleteAllCheckedToDosInTodayInWorkspaceList,
    required TResult orElse(),
  }) {
    if (deleteAllCheckedToDosInTodayInWorkspaceList != null) {
      return deleteAllCheckedToDosInTodayInWorkspaceList(this);
    }
    return orElse();
  }
}

abstract class DeleteAllCheckedToDosInTodayInWorkspaceList
    implements TLAppStateAction {
  const factory DeleteAllCheckedToDosInTodayInWorkspaceList(
          final List<TLWorkspace> corrWorkspaceList) =
      _$DeleteAllCheckedToDosInTodayInWorkspaceListImpl;

  List<TLWorkspace> get corrWorkspaceList;

  /// Create a copy of TLAppStateAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteAllCheckedToDosInTodayInWorkspaceListImplCopyWith<
          _$DeleteAllCheckedToDosInTodayInWorkspaceListImpl>
      get copyWith => throw _privateConstructorUsedError;
}
