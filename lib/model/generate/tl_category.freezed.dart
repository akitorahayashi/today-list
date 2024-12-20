// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../todo/tl_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TLCategory _$TLCategoryFromJson(Map<String, dynamic> json) {
  return _TLCategory.fromJson(json);
}

/// @nodoc
mixin _$TLCategory {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  /// Serializes this TLCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TLCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TLCategoryCopyWith<TLCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TLCategoryCopyWith<$Res> {
  factory $TLCategoryCopyWith(
          TLCategory value, $Res Function(TLCategory) then) =
      _$TLCategoryCopyWithImpl<$Res, TLCategory>;
  @useResult
  $Res call({String id, String title});
}

/// @nodoc
class _$TLCategoryCopyWithImpl<$Res, $Val extends TLCategory>
    implements $TLCategoryCopyWith<$Res> {
  _$TLCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TLCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TLCategoryImplCopyWith<$Res>
    implements $TLCategoryCopyWith<$Res> {
  factory _$$TLCategoryImplCopyWith(
          _$TLCategoryImpl value, $Res Function(_$TLCategoryImpl) then) =
      __$$TLCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title});
}

/// @nodoc
class __$$TLCategoryImplCopyWithImpl<$Res>
    extends _$TLCategoryCopyWithImpl<$Res, _$TLCategoryImpl>
    implements _$$TLCategoryImplCopyWith<$Res> {
  __$$TLCategoryImplCopyWithImpl(
      _$TLCategoryImpl _value, $Res Function(_$TLCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_$TLCategoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TLCategoryImpl implements _TLCategory {
  const _$TLCategoryImpl({required this.id, required this.title});

  factory _$TLCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TLCategoryImplFromJson(json);

  @override
  final String id;
  @override
  final String title;

  @override
  String toString() {
    return 'TLCategory(id: $id, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TLCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title);

  /// Create a copy of TLCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TLCategoryImplCopyWith<_$TLCategoryImpl> get copyWith =>
      __$$TLCategoryImplCopyWithImpl<_$TLCategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TLCategoryImplToJson(
      this,
    );
  }
}

abstract class _TLCategory implements TLCategory {
  const factory _TLCategory(
      {required final String id,
      required final String title}) = _$TLCategoryImpl;

  factory _TLCategory.fromJson(Map<String, dynamic> json) =
      _$TLCategoryImpl.fromJson;

  @override
  String get id;
  @override
  String get title;

  /// Create a copy of TLCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TLCategoryImplCopyWith<_$TLCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
