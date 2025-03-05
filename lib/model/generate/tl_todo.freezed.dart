// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../todo/tl_todo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TLToDo _$TLToDoFromJson(Map<String, dynamic> json) {
  return _TLToDo.fromJson(json);
}

/// @nodoc
mixin _$TLToDo {
  String get id => throw _privateConstructorUsedError;
  String get workspaceID => throw _privateConstructorUsedError;
  bool get isInToday => throw _privateConstructorUsedError;
  bool get isChecked => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  List<TLStep> get steps => throw _privateConstructorUsedError;

  /// Serializes this TLToDo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TLToDo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TLToDoCopyWith<TLToDo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TLToDoCopyWith<$Res> {
  factory $TLToDoCopyWith(TLToDo value, $Res Function(TLToDo) then) =
      _$TLToDoCopyWithImpl<$Res, TLToDo>;
  @useResult
  $Res call(
      {String id,
      String workspaceID,
      bool isInToday,
      bool isChecked,
      String content,
      List<TLStep> steps});
}

/// @nodoc
class _$TLToDoCopyWithImpl<$Res, $Val extends TLToDo>
    implements $TLToDoCopyWith<$Res> {
  _$TLToDoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TLToDo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? workspaceID = null,
    Object? isInToday = null,
    Object? isChecked = null,
    Object? content = null,
    Object? steps = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      workspaceID: null == workspaceID
          ? _value.workspaceID
          : workspaceID // ignore: cast_nullable_to_non_nullable
              as String,
      isInToday: null == isInToday
          ? _value.isInToday
          : isInToday // ignore: cast_nullable_to_non_nullable
              as bool,
      isChecked: null == isChecked
          ? _value.isChecked
          : isChecked // ignore: cast_nullable_to_non_nullable
              as bool,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<TLStep>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TLToDoImplCopyWith<$Res> implements $TLToDoCopyWith<$Res> {
  factory _$$TLToDoImplCopyWith(
          _$TLToDoImpl value, $Res Function(_$TLToDoImpl) then) =
      __$$TLToDoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String workspaceID,
      bool isInToday,
      bool isChecked,
      String content,
      List<TLStep> steps});
}

/// @nodoc
class __$$TLToDoImplCopyWithImpl<$Res>
    extends _$TLToDoCopyWithImpl<$Res, _$TLToDoImpl>
    implements _$$TLToDoImplCopyWith<$Res> {
  __$$TLToDoImplCopyWithImpl(
      _$TLToDoImpl _value, $Res Function(_$TLToDoImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLToDo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? workspaceID = null,
    Object? isInToday = null,
    Object? isChecked = null,
    Object? content = null,
    Object? steps = null,
  }) {
    return _then(_$TLToDoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      workspaceID: null == workspaceID
          ? _value.workspaceID
          : workspaceID // ignore: cast_nullable_to_non_nullable
              as String,
      isInToday: null == isInToday
          ? _value.isInToday
          : isInToday // ignore: cast_nullable_to_non_nullable
              as bool,
      isChecked: null == isChecked
          ? _value.isChecked
          : isChecked // ignore: cast_nullable_to_non_nullable
              as bool,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      steps: null == steps
          ? _value._steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<TLStep>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TLToDoImpl implements _TLToDo {
  const _$TLToDoImpl(
      {required this.id,
      required this.workspaceID,
      required this.isInToday,
      this.isChecked = false,
      required this.content,
      final List<TLStep> steps = const []})
      : _steps = steps;

  factory _$TLToDoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TLToDoImplFromJson(json);

  @override
  final String id;
  @override
  final String workspaceID;
  @override
  final bool isInToday;
  @override
  @JsonKey()
  final bool isChecked;
  @override
  final String content;
  final List<TLStep> _steps;
  @override
  @JsonKey()
  List<TLStep> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  @override
  String toString() {
    return 'TLToDo(id: $id, workspaceID: $workspaceID, isInToday: $isInToday, isChecked: $isChecked, content: $content, steps: $steps)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TLToDoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.workspaceID, workspaceID) ||
                other.workspaceID == workspaceID) &&
            (identical(other.isInToday, isInToday) ||
                other.isInToday == isInToday) &&
            (identical(other.isChecked, isChecked) ||
                other.isChecked == isChecked) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._steps, _steps));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, workspaceID, isInToday,
      isChecked, content, const DeepCollectionEquality().hash(_steps));

  /// Create a copy of TLToDo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TLToDoImplCopyWith<_$TLToDoImpl> get copyWith =>
      __$$TLToDoImplCopyWithImpl<_$TLToDoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TLToDoImplToJson(
      this,
    );
  }
}

abstract class _TLToDo implements TLToDo {
  const factory _TLToDo(
      {required final String id,
      required final String workspaceID,
      required final bool isInToday,
      final bool isChecked,
      required final String content,
      final List<TLStep> steps}) = _$TLToDoImpl;

  factory _TLToDo.fromJson(Map<String, dynamic> json) = _$TLToDoImpl.fromJson;

  @override
  String get id;
  @override
  String get workspaceID;
  @override
  bool get isInToday;
  @override
  bool get isChecked;
  @override
  String get content;
  @override
  List<TLStep> get steps;

  /// Create a copy of TLToDo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TLToDoImplCopyWith<_$TLToDoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
