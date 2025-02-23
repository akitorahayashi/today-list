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
    required TResult Function(TLWorkspace updatedWorkspace) saveCorrWorkspace,
    required TResult Function(List<TLWorkspace> updatedWorkspaceList)
        saveWorkspaceList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace updatedWorkspace)? saveCorrWorkspace,
    TResult? Function(List<TLWorkspace> updatedWorkspaceList)?
        saveWorkspaceList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace updatedWorkspace)? saveCorrWorkspace,
    TResult Function(List<TLWorkspace> updatedWorkspaceList)? saveWorkspaceList,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpdateCurrentWorkspace value) saveCorrWorkspace,
    required TResult Function(UpdateWorkspaceList value) saveWorkspaceList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpdateCurrentWorkspace value)? saveCorrWorkspace,
    TResult? Function(UpdateWorkspaceList value)? saveWorkspaceList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpdateCurrentWorkspace value)? saveCorrWorkspace,
    TResult Function(UpdateWorkspaceList value)? saveWorkspaceList,
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
    extends _$TLAppStateActionCopyWithImpl<$Res, _$UpdateCurrentWorkspaceImpl>
    implements _$$UpdateCurrentWorkspaceImplCopyWith<$Res> {
  __$$UpdateCurrentWorkspaceImplCopyWithImpl(
      _$UpdateCurrentWorkspaceImpl _value,
      $Res Function(_$UpdateCurrentWorkspaceImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLAppStateAction
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

  /// Create a copy of TLAppStateAction
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
    return 'TLAppStateAction.saveCorrWorkspace(updatedWorkspace: $updatedWorkspace)';
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

  /// Create a copy of TLAppStateAction
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
    required TResult Function(TLWorkspace updatedWorkspace) saveCorrWorkspace,
    required TResult Function(List<TLWorkspace> updatedWorkspaceList)
        saveWorkspaceList,
  }) {
    return saveCorrWorkspace(updatedWorkspace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace updatedWorkspace)? saveCorrWorkspace,
    TResult? Function(List<TLWorkspace> updatedWorkspaceList)?
        saveWorkspaceList,
  }) {
    return saveCorrWorkspace?.call(updatedWorkspace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace updatedWorkspace)? saveCorrWorkspace,
    TResult Function(List<TLWorkspace> updatedWorkspaceList)? saveWorkspaceList,
    required TResult orElse(),
  }) {
    if (saveCorrWorkspace != null) {
      return saveCorrWorkspace(updatedWorkspace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpdateCurrentWorkspace value) saveCorrWorkspace,
    required TResult Function(UpdateWorkspaceList value) saveWorkspaceList,
  }) {
    return saveCorrWorkspace(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpdateCurrentWorkspace value)? saveCorrWorkspace,
    TResult? Function(UpdateWorkspaceList value)? saveWorkspaceList,
  }) {
    return saveCorrWorkspace?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpdateCurrentWorkspace value)? saveCorrWorkspace,
    TResult Function(UpdateWorkspaceList value)? saveWorkspaceList,
    required TResult orElse(),
  }) {
    if (saveCorrWorkspace != null) {
      return saveCorrWorkspace(this);
    }
    return orElse();
  }
}

abstract class UpdateCurrentWorkspace implements TLAppStateAction {
  const factory UpdateCurrentWorkspace(final TLWorkspace updatedWorkspace) =
      _$UpdateCurrentWorkspaceImpl;

  TLWorkspace get updatedWorkspace;

  /// Create a copy of TLAppStateAction
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
    extends _$TLAppStateActionCopyWithImpl<$Res, _$UpdateWorkspaceListImpl>
    implements _$$UpdateWorkspaceListImplCopyWith<$Res> {
  __$$UpdateWorkspaceListImplCopyWithImpl(_$UpdateWorkspaceListImpl _value,
      $Res Function(_$UpdateWorkspaceListImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLAppStateAction
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
    return 'TLAppStateAction.saveWorkspaceList(updatedWorkspaceList: $updatedWorkspaceList)';
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

  /// Create a copy of TLAppStateAction
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
    required TResult Function(TLWorkspace updatedWorkspace) saveCorrWorkspace,
    required TResult Function(List<TLWorkspace> updatedWorkspaceList)
        saveWorkspaceList,
  }) {
    return saveWorkspaceList(updatedWorkspaceList);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TLWorkspace updatedWorkspace)? saveCorrWorkspace,
    TResult? Function(List<TLWorkspace> updatedWorkspaceList)?
        saveWorkspaceList,
  }) {
    return saveWorkspaceList?.call(updatedWorkspaceList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TLWorkspace updatedWorkspace)? saveCorrWorkspace,
    TResult Function(List<TLWorkspace> updatedWorkspaceList)? saveWorkspaceList,
    required TResult orElse(),
  }) {
    if (saveWorkspaceList != null) {
      return saveWorkspaceList(updatedWorkspaceList);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpdateCurrentWorkspace value) saveCorrWorkspace,
    required TResult Function(UpdateWorkspaceList value) saveWorkspaceList,
  }) {
    return saveWorkspaceList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpdateCurrentWorkspace value)? saveCorrWorkspace,
    TResult? Function(UpdateWorkspaceList value)? saveWorkspaceList,
  }) {
    return saveWorkspaceList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpdateCurrentWorkspace value)? saveCorrWorkspace,
    TResult Function(UpdateWorkspaceList value)? saveWorkspaceList,
    required TResult orElse(),
  }) {
    if (saveWorkspaceList != null) {
      return saveWorkspaceList(this);
    }
    return orElse();
  }
}

abstract class UpdateWorkspaceList implements TLAppStateAction {
  const factory UpdateWorkspaceList(
      final List<TLWorkspace> updatedWorkspaceList) = _$UpdateWorkspaceListImpl;

  List<TLWorkspace> get updatedWorkspaceList;

  /// Create a copy of TLAppStateAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateWorkspaceListImplCopyWith<_$UpdateWorkspaceListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
