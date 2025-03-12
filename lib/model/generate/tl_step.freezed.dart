// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../todo/tl_step.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TLStep _$TLStepFromJson(Map<String, dynamic> json) {
  return _TLStep.fromJson(json);
}

/// @nodoc
mixin _$TLStep {
  String get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  bool get isChecked => throw _privateConstructorUsedError;

  /// Serializes this TLStep to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TLStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TLStepCopyWith<TLStep> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TLStepCopyWith<$Res> {
  factory $TLStepCopyWith(TLStep value, $Res Function(TLStep) then) =
      _$TLStepCopyWithImpl<$Res, TLStep>;
  @useResult
  $Res call({String id, String content, bool isChecked});
}

/// @nodoc
class _$TLStepCopyWithImpl<$Res, $Val extends TLStep>
    implements $TLStepCopyWith<$Res> {
  _$TLStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TLStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? isChecked = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            content:
                null == content
                    ? _value.content
                    : content // ignore: cast_nullable_to_non_nullable
                        as String,
            isChecked:
                null == isChecked
                    ? _value.isChecked
                    : isChecked // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TLStepImplCopyWith<$Res> implements $TLStepCopyWith<$Res> {
  factory _$$TLStepImplCopyWith(
    _$TLStepImpl value,
    $Res Function(_$TLStepImpl) then,
  ) = __$$TLStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String content, bool isChecked});
}

/// @nodoc
class __$$TLStepImplCopyWithImpl<$Res>
    extends _$TLStepCopyWithImpl<$Res, _$TLStepImpl>
    implements _$$TLStepImplCopyWith<$Res> {
  __$$TLStepImplCopyWithImpl(
    _$TLStepImpl _value,
    $Res Function(_$TLStepImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TLStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? isChecked = null,
  }) {
    return _then(
      _$TLStepImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        content:
            null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                    as String,
        isChecked:
            null == isChecked
                ? _value.isChecked
                : isChecked // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TLStepImpl implements _TLStep {
  const _$TLStepImpl({
    required this.id,
    required this.content,
    this.isChecked = false,
  });

  factory _$TLStepImpl.fromJson(Map<String, dynamic> json) =>
      _$$TLStepImplFromJson(json);

  @override
  final String id;
  @override
  final String content;
  @override
  @JsonKey()
  final bool isChecked;

  @override
  String toString() {
    return 'TLStep(id: $id, content: $content, isChecked: $isChecked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TLStepImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.isChecked, isChecked) ||
                other.isChecked == isChecked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, content, isChecked);

  /// Create a copy of TLStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TLStepImplCopyWith<_$TLStepImpl> get copyWith =>
      __$$TLStepImplCopyWithImpl<_$TLStepImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TLStepImplToJson(this);
  }
}

abstract class _TLStep implements TLStep {
  const factory _TLStep({
    required final String id,
    required final String content,
    final bool isChecked,
  }) = _$TLStepImpl;

  factory _TLStep.fromJson(Map<String, dynamic> json) = _$TLStepImpl.fromJson;

  @override
  String get id;
  @override
  String get content;
  @override
  bool get isChecked;

  /// Create a copy of TLStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TLStepImplCopyWith<_$TLStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
