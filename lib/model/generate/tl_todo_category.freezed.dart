// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../todo/tl_todo_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TLToDoCategory _$TLToDoCategoryFromJson(Map<String, dynamic> json) {
  return _TLToDoCategory.fromJson(json);
}

/// @nodoc
mixin _$TLToDoCategory {
  String get id => throw _privateConstructorUsedError;
  String? get parentBigCategoryID => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this TLToDoCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TLToDoCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TLToDoCategoryCopyWith<TLToDoCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TLToDoCategoryCopyWith<$Res> {
  factory $TLToDoCategoryCopyWith(
          TLToDoCategory value, $Res Function(TLToDoCategory) then) =
      _$TLToDoCategoryCopyWithImpl<$Res, TLToDoCategory>;
  @useResult
  $Res call({String id, String? parentBigCategoryID, String name});
}

/// @nodoc
class _$TLToDoCategoryCopyWithImpl<$Res, $Val extends TLToDoCategory>
    implements $TLToDoCategoryCopyWith<$Res> {
  _$TLToDoCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TLToDoCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? parentBigCategoryID = freezed,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      parentBigCategoryID: freezed == parentBigCategoryID
          ? _value.parentBigCategoryID
          : parentBigCategoryID // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TLToDoCategoryImplCopyWith<$Res>
    implements $TLToDoCategoryCopyWith<$Res> {
  factory _$$TLToDoCategoryImplCopyWith(_$TLToDoCategoryImpl value,
          $Res Function(_$TLToDoCategoryImpl) then) =
      __$$TLToDoCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String? parentBigCategoryID, String name});
}

/// @nodoc
class __$$TLToDoCategoryImplCopyWithImpl<$Res>
    extends _$TLToDoCategoryCopyWithImpl<$Res, _$TLToDoCategoryImpl>
    implements _$$TLToDoCategoryImplCopyWith<$Res> {
  __$$TLToDoCategoryImplCopyWithImpl(
      _$TLToDoCategoryImpl _value, $Res Function(_$TLToDoCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLToDoCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? parentBigCategoryID = freezed,
    Object? name = null,
  }) {
    return _then(_$TLToDoCategoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      parentBigCategoryID: freezed == parentBigCategoryID
          ? _value.parentBigCategoryID
          : parentBigCategoryID // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TLToDoCategoryImpl implements _TLToDoCategory {
  const _$TLToDoCategoryImpl(
      {required this.id,
      required this.parentBigCategoryID,
      required this.name});

  factory _$TLToDoCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TLToDoCategoryImplFromJson(json);

  @override
  final String id;
  @override
  final String? parentBigCategoryID;
  @override
  final String name;

  @override
  String toString() {
    return 'TLToDoCategory(id: $id, parentBigCategoryID: $parentBigCategoryID, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TLToDoCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.parentBigCategoryID, parentBigCategoryID) ||
                other.parentBigCategoryID == parentBigCategoryID) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, parentBigCategoryID, name);

  /// Create a copy of TLToDoCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TLToDoCategoryImplCopyWith<_$TLToDoCategoryImpl> get copyWith =>
      __$$TLToDoCategoryImplCopyWithImpl<_$TLToDoCategoryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TLToDoCategoryImplToJson(
      this,
    );
  }
}

abstract class _TLToDoCategory implements TLToDoCategory {
  const factory _TLToDoCategory(
      {required final String id,
      required final String? parentBigCategoryID,
      required final String name}) = _$TLToDoCategoryImpl;

  factory _TLToDoCategory.fromJson(Map<String, dynamic> json) =
      _$TLToDoCategoryImpl.fromJson;

  @override
  String get id;
  @override
  String? get parentBigCategoryID;
  @override
  String get name;

  /// Create a copy of TLToDoCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TLToDoCategoryImplCopyWith<_$TLToDoCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
