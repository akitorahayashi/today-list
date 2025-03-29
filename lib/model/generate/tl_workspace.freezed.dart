// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../todo/tl_workspace.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TLWorkspace _$TLWorkspaceFromJson(Map<String, dynamic> json) {
  return _TLWorkspace.fromJson(json);
}

/// @nodoc
mixin _$TLWorkspace {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  TLToDosInTodayAndWhenever get toDos => throw _privateConstructorUsedError;

  /// Serializes this TLWorkspace to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TLWorkspace
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TLWorkspaceCopyWith<TLWorkspace> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TLWorkspaceCopyWith<$Res> {
  factory $TLWorkspaceCopyWith(
    TLWorkspace value,
    $Res Function(TLWorkspace) then,
  ) = _$TLWorkspaceCopyWithImpl<$Res, TLWorkspace>;
  @useResult
  $Res call({String id, String name, TLToDosInTodayAndWhenever toDos});

  $TLToDosInTodayAndWheneverCopyWith<$Res> get toDos;
}

/// @nodoc
class _$TLWorkspaceCopyWithImpl<$Res, $Val extends TLWorkspace>
    implements $TLWorkspaceCopyWith<$Res> {
  _$TLWorkspaceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TLWorkspace
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? toDos = null}) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            toDos:
                null == toDos
                    ? _value.toDos
                    : toDos // ignore: cast_nullable_to_non_nullable
                        as TLToDosInTodayAndWhenever,
          )
          as $Val,
    );
  }

  /// Create a copy of TLWorkspace
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLToDosInTodayAndWheneverCopyWith<$Res> get toDos {
    return $TLToDosInTodayAndWheneverCopyWith<$Res>(_value.toDos, (value) {
      return _then(_value.copyWith(toDos: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TLWorkspaceImplCopyWith<$Res>
    implements $TLWorkspaceCopyWith<$Res> {
  factory _$$TLWorkspaceImplCopyWith(
    _$TLWorkspaceImpl value,
    $Res Function(_$TLWorkspaceImpl) then,
  ) = __$$TLWorkspaceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, TLToDosInTodayAndWhenever toDos});

  @override
  $TLToDosInTodayAndWheneverCopyWith<$Res> get toDos;
}

/// @nodoc
class __$$TLWorkspaceImplCopyWithImpl<$Res>
    extends _$TLWorkspaceCopyWithImpl<$Res, _$TLWorkspaceImpl>
    implements _$$TLWorkspaceImplCopyWith<$Res> {
  __$$TLWorkspaceImplCopyWithImpl(
    _$TLWorkspaceImpl _value,
    $Res Function(_$TLWorkspaceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TLWorkspace
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? toDos = null}) {
    return _then(
      _$TLWorkspaceImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        toDos:
            null == toDos
                ? _value.toDos
                : toDos // ignore: cast_nullable_to_non_nullable
                    as TLToDosInTodayAndWhenever,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TLWorkspaceImpl extends _TLWorkspace {
  _$TLWorkspaceImpl({required this.id, required this.name, required this.toDos})
    : super._();

  factory _$TLWorkspaceImpl.fromJson(Map<String, dynamic> json) =>
      _$$TLWorkspaceImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final TLToDosInTodayAndWhenever toDos;

  @override
  String toString() {
    return 'TLWorkspace(id: $id, name: $name, toDos: $toDos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TLWorkspaceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.toDos, toDos) || other.toDos == toDos));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, toDos);

  /// Create a copy of TLWorkspace
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TLWorkspaceImplCopyWith<_$TLWorkspaceImpl> get copyWith =>
      __$$TLWorkspaceImplCopyWithImpl<_$TLWorkspaceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TLWorkspaceImplToJson(this);
  }
}

abstract class _TLWorkspace extends TLWorkspace {
  factory _TLWorkspace({
    required final String id,
    required final String name,
    required final TLToDosInTodayAndWhenever toDos,
  }) = _$TLWorkspaceImpl;
  _TLWorkspace._() : super._();

  factory _TLWorkspace.fromJson(Map<String, dynamic> json) =
      _$TLWorkspaceImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  TLToDosInTodayAndWhenever get toDos;

  /// Create a copy of TLWorkspace
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TLWorkspaceImplCopyWith<_$TLWorkspaceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
