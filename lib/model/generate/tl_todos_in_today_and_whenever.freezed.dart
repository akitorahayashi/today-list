// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../todo/tl_todos_in_today_and_whenever.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TLToDosInTodayAndWhenever _$TLToDosInTodayAndWheneverFromJson(
    Map<String, dynamic> json) {
  return _TLToDosInTodayAndWhenever.fromJson(json);
}

/// @nodoc
mixin _$TLToDosInTodayAndWhenever {
  String get workspaceID => throw _privateConstructorUsedError;
  List<TLToDo> get toDosInToday => throw _privateConstructorUsedError;
  List<TLToDo> get toDosInWhenever => throw _privateConstructorUsedError;

  /// Serializes this TLToDosInTodayAndWhenever to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TLToDosInTodayAndWhenever
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TLToDosInTodayAndWheneverCopyWith<TLToDosInTodayAndWhenever> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TLToDosInTodayAndWheneverCopyWith<$Res> {
  factory $TLToDosInTodayAndWheneverCopyWith(TLToDosInTodayAndWhenever value,
          $Res Function(TLToDosInTodayAndWhenever) then) =
      _$TLToDosInTodayAndWheneverCopyWithImpl<$Res, TLToDosInTodayAndWhenever>;
  @useResult
  $Res call(
      {String workspaceID,
      List<TLToDo> toDosInToday,
      List<TLToDo> toDosInWhenever});
}

/// @nodoc
class _$TLToDosInTodayAndWheneverCopyWithImpl<$Res,
        $Val extends TLToDosInTodayAndWhenever>
    implements $TLToDosInTodayAndWheneverCopyWith<$Res> {
  _$TLToDosInTodayAndWheneverCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TLToDosInTodayAndWhenever
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workspaceID = null,
    Object? toDosInToday = null,
    Object? toDosInWhenever = null,
  }) {
    return _then(_value.copyWith(
      workspaceID: null == workspaceID
          ? _value.workspaceID
          : workspaceID // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$$TLToDosInTodayAndWheneverImplCopyWith<$Res>
    implements $TLToDosInTodayAndWheneverCopyWith<$Res> {
  factory _$$TLToDosInTodayAndWheneverImplCopyWith(
          _$TLToDosInTodayAndWheneverImpl value,
          $Res Function(_$TLToDosInTodayAndWheneverImpl) then) =
      __$$TLToDosInTodayAndWheneverImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String workspaceID,
      List<TLToDo> toDosInToday,
      List<TLToDo> toDosInWhenever});
}

/// @nodoc
class __$$TLToDosInTodayAndWheneverImplCopyWithImpl<$Res>
    extends _$TLToDosInTodayAndWheneverCopyWithImpl<$Res,
        _$TLToDosInTodayAndWheneverImpl>
    implements _$$TLToDosInTodayAndWheneverImplCopyWith<$Res> {
  __$$TLToDosInTodayAndWheneverImplCopyWithImpl(
      _$TLToDosInTodayAndWheneverImpl _value,
      $Res Function(_$TLToDosInTodayAndWheneverImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLToDosInTodayAndWhenever
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workspaceID = null,
    Object? toDosInToday = null,
    Object? toDosInWhenever = null,
  }) {
    return _then(_$TLToDosInTodayAndWheneverImpl(
      workspaceID: null == workspaceID
          ? _value.workspaceID
          : workspaceID // ignore: cast_nullable_to_non_nullable
              as String,
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
class _$TLToDosInTodayAndWheneverImpl extends _TLToDosInTodayAndWhenever {
  const _$TLToDosInTodayAndWheneverImpl(
      {required this.workspaceID,
      final List<TLToDo> toDosInToday = const [],
      final List<TLToDo> toDosInWhenever = const []})
      : _toDosInToday = toDosInToday,
        _toDosInWhenever = toDosInWhenever,
        super._();

  factory _$TLToDosInTodayAndWheneverImpl.fromJson(Map<String, dynamic> json) =>
      _$$TLToDosInTodayAndWheneverImplFromJson(json);

  @override
  final String workspaceID;
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
    return 'TLToDosInTodayAndWhenever(workspaceID: $workspaceID, toDosInToday: $toDosInToday, toDosInWhenever: $toDosInWhenever)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TLToDosInTodayAndWheneverImpl &&
            (identical(other.workspaceID, workspaceID) ||
                other.workspaceID == workspaceID) &&
            const DeepCollectionEquality()
                .equals(other._toDosInToday, _toDosInToday) &&
            const DeepCollectionEquality()
                .equals(other._toDosInWhenever, _toDosInWhenever));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      workspaceID,
      const DeepCollectionEquality().hash(_toDosInToday),
      const DeepCollectionEquality().hash(_toDosInWhenever));

  /// Create a copy of TLToDosInTodayAndWhenever
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TLToDosInTodayAndWheneverImplCopyWith<_$TLToDosInTodayAndWheneverImpl>
      get copyWith => __$$TLToDosInTodayAndWheneverImplCopyWithImpl<
          _$TLToDosInTodayAndWheneverImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TLToDosInTodayAndWheneverImplToJson(
      this,
    );
  }
}

abstract class _TLToDosInTodayAndWhenever extends TLToDosInTodayAndWhenever {
  const factory _TLToDosInTodayAndWhenever(
      {required final String workspaceID,
      final List<TLToDo> toDosInToday,
      final List<TLToDo> toDosInWhenever}) = _$TLToDosInTodayAndWheneverImpl;
  const _TLToDosInTodayAndWhenever._() : super._();

  factory _TLToDosInTodayAndWhenever.fromJson(Map<String, dynamic> json) =
      _$TLToDosInTodayAndWheneverImpl.fromJson;

  @override
  String get workspaceID;
  @override
  List<TLToDo> get toDosInToday;
  @override
  List<TLToDo> get toDosInWhenever;

  /// Create a copy of TLToDosInTodayAndWhenever
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TLToDosInTodayAndWheneverImplCopyWith<_$TLToDosInTodayAndWheneverImpl>
      get copyWith => throw _privateConstructorUsedError;
}
