// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../todo/tl_todos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TLToDos _$TLToDosFromJson(Map<String, dynamic> json) {
  return _TLToDos.fromJson(json);
}

/// @nodoc
mixin _$TLToDos {
  List<TLToDo> get toDosInToday => throw _privateConstructorUsedError;
  List<TLToDo> get toDosInWhenever => throw _privateConstructorUsedError;

  /// Serializes this TLToDos to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TLToDos
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TLToDosCopyWith<TLToDos> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TLToDosCopyWith<$Res> {
  factory $TLToDosCopyWith(TLToDos value, $Res Function(TLToDos) then) =
      _$TLToDosCopyWithImpl<$Res, TLToDos>;
  @useResult
  $Res call({List<TLToDo> toDosInToday, List<TLToDo> toDosInWhenever});
}

/// @nodoc
class _$TLToDosCopyWithImpl<$Res, $Val extends TLToDos>
    implements $TLToDosCopyWith<$Res> {
  _$TLToDosCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TLToDos
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? toDosInToday = null,
    Object? toDosInWhenever = null,
  }) {
    return _then(_value.copyWith(
      toDosInToday: null == toDosInToday
          ? _value.toDosInToday
          : toDosInToday // ignore: cast_nullable_to_non_nullable
              as List<TLToDo>,
      toDosInWhenever: null == toDosInWhenever
          ? _value.toDosInWhenever
          : toDosInWhenever // ignore: cast_nullable_to_non_nullable
              as List<TLToDo>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TLToDosImplCopyWith<$Res> implements $TLToDosCopyWith<$Res> {
  factory _$$TLToDosImplCopyWith(
          _$TLToDosImpl value, $Res Function(_$TLToDosImpl) then) =
      __$$TLToDosImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TLToDo> toDosInToday, List<TLToDo> toDosInWhenever});
}

/// @nodoc
class __$$TLToDosImplCopyWithImpl<$Res>
    extends _$TLToDosCopyWithImpl<$Res, _$TLToDosImpl>
    implements _$$TLToDosImplCopyWith<$Res> {
  __$$TLToDosImplCopyWithImpl(
      _$TLToDosImpl _value, $Res Function(_$TLToDosImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLToDos
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? toDosInToday = null,
    Object? toDosInWhenever = null,
  }) {
    return _then(_$TLToDosImpl(
      toDosInToday: null == toDosInToday
          ? _value._toDosInToday
          : toDosInToday // ignore: cast_nullable_to_non_nullable
              as List<TLToDo>,
      toDosInWhenever: null == toDosInWhenever
          ? _value._toDosInWhenever
          : toDosInWhenever // ignore: cast_nullable_to_non_nullable
              as List<TLToDo>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TLToDosImpl implements _TLToDos {
  const _$TLToDosImpl(
      {final List<TLToDo> toDosInToday = const [],
      final List<TLToDo> toDosInWhenever = const []})
      : _toDosInToday = toDosInToday,
        _toDosInWhenever = toDosInWhenever;

  factory _$TLToDosImpl.fromJson(Map<String, dynamic> json) =>
      _$$TLToDosImplFromJson(json);

  final List<TLToDo> _toDosInToday;
  @override
  @JsonKey()
  List<TLToDo> get toDosInToday {
    if (_toDosInToday is EqualUnmodifiableListView) return _toDosInToday;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_toDosInToday);
  }

  final List<TLToDo> _toDosInWhenever;
  @override
  @JsonKey()
  List<TLToDo> get toDosInWhenever {
    if (_toDosInWhenever is EqualUnmodifiableListView) return _toDosInWhenever;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_toDosInWhenever);
  }

  @override
  String toString() {
    return 'TLToDos(toDosInToday: $toDosInToday, toDosInWhenever: $toDosInWhenever)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TLToDosImpl &&
            const DeepCollectionEquality()
                .equals(other._toDosInToday, _toDosInToday) &&
            const DeepCollectionEquality()
                .equals(other._toDosInWhenever, _toDosInWhenever));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_toDosInToday),
      const DeepCollectionEquality().hash(_toDosInWhenever));

  /// Create a copy of TLToDos
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TLToDosImplCopyWith<_$TLToDosImpl> get copyWith =>
      __$$TLToDosImplCopyWithImpl<_$TLToDosImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TLToDosImplToJson(
      this,
    );
  }
}

abstract class _TLToDos implements TLToDos {
  const factory _TLToDos(
      {final List<TLToDo> toDosInToday,
      final List<TLToDo> toDosInWhenever}) = _$TLToDosImpl;

  factory _TLToDos.fromJson(Map<String, dynamic> json) = _$TLToDosImpl.fromJson;

  @override
  List<TLToDo> get toDosInToday;
  @override
  List<TLToDo> get toDosInWhenever;

  /// Create a copy of TLToDos
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TLToDosImplCopyWith<_$TLToDosImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
