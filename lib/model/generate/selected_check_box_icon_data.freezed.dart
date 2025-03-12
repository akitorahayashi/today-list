// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../settings_data/selected_check_box_icon_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SelectedCheckBoxIconData _$SelectedCheckBoxIconDataFromJson(
  Map<String, dynamic> json,
) {
  return _SelectedCheckBoxIconData.fromJson(json);
}

/// @nodoc
mixin _$SelectedCheckBoxIconData {
  String get iconCategory => throw _privateConstructorUsedError;
  String get iconName => throw _privateConstructorUsedError;

  /// Serializes this SelectedCheckBoxIconData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SelectedCheckBoxIconData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SelectedCheckBoxIconDataCopyWith<SelectedCheckBoxIconData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectedCheckBoxIconDataCopyWith<$Res> {
  factory $SelectedCheckBoxIconDataCopyWith(
    SelectedCheckBoxIconData value,
    $Res Function(SelectedCheckBoxIconData) then,
  ) = _$SelectedCheckBoxIconDataCopyWithImpl<$Res, SelectedCheckBoxIconData>;
  @useResult
  $Res call({String iconCategory, String iconName});
}

/// @nodoc
class _$SelectedCheckBoxIconDataCopyWithImpl<
  $Res,
  $Val extends SelectedCheckBoxIconData
>
    implements $SelectedCheckBoxIconDataCopyWith<$Res> {
  _$SelectedCheckBoxIconDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelectedCheckBoxIconData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? iconCategory = null, Object? iconName = null}) {
    return _then(
      _value.copyWith(
            iconCategory:
                null == iconCategory
                    ? _value.iconCategory
                    : iconCategory // ignore: cast_nullable_to_non_nullable
                        as String,
            iconName:
                null == iconName
                    ? _value.iconName
                    : iconName // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SelectedCheckBoxIconDataImplCopyWith<$Res>
    implements $SelectedCheckBoxIconDataCopyWith<$Res> {
  factory _$$SelectedCheckBoxIconDataImplCopyWith(
    _$SelectedCheckBoxIconDataImpl value,
    $Res Function(_$SelectedCheckBoxIconDataImpl) then,
  ) = __$$SelectedCheckBoxIconDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String iconCategory, String iconName});
}

/// @nodoc
class __$$SelectedCheckBoxIconDataImplCopyWithImpl<$Res>
    extends
        _$SelectedCheckBoxIconDataCopyWithImpl<
          $Res,
          _$SelectedCheckBoxIconDataImpl
        >
    implements _$$SelectedCheckBoxIconDataImplCopyWith<$Res> {
  __$$SelectedCheckBoxIconDataImplCopyWithImpl(
    _$SelectedCheckBoxIconDataImpl _value,
    $Res Function(_$SelectedCheckBoxIconDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SelectedCheckBoxIconData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? iconCategory = null, Object? iconName = null}) {
    return _then(
      _$SelectedCheckBoxIconDataImpl(
        iconCategory:
            null == iconCategory
                ? _value.iconCategory
                : iconCategory // ignore: cast_nullable_to_non_nullable
                    as String,
        iconName:
            null == iconName
                ? _value.iconName
                : iconName // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SelectedCheckBoxIconDataImpl implements _SelectedCheckBoxIconData {
  const _$SelectedCheckBoxIconDataImpl({
    required this.iconCategory,
    required this.iconName,
  });

  factory _$SelectedCheckBoxIconDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$SelectedCheckBoxIconDataImplFromJson(json);

  @override
  final String iconCategory;
  @override
  final String iconName;

  @override
  String toString() {
    return 'SelectedCheckBoxIconData(iconCategory: $iconCategory, iconName: $iconName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectedCheckBoxIconDataImpl &&
            (identical(other.iconCategory, iconCategory) ||
                other.iconCategory == iconCategory) &&
            (identical(other.iconName, iconName) ||
                other.iconName == iconName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, iconCategory, iconName);

  /// Create a copy of SelectedCheckBoxIconData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectedCheckBoxIconDataImplCopyWith<_$SelectedCheckBoxIconDataImpl>
  get copyWith => __$$SelectedCheckBoxIconDataImplCopyWithImpl<
    _$SelectedCheckBoxIconDataImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SelectedCheckBoxIconDataImplToJson(this);
  }
}

abstract class _SelectedCheckBoxIconData implements SelectedCheckBoxIconData {
  const factory _SelectedCheckBoxIconData({
    required final String iconCategory,
    required final String iconName,
  }) = _$SelectedCheckBoxIconDataImpl;

  factory _SelectedCheckBoxIconData.fromJson(Map<String, dynamic> json) =
      _$SelectedCheckBoxIconDataImpl.fromJson;

  @override
  String get iconCategory;
  @override
  String get iconName;

  /// Create a copy of SelectedCheckBoxIconData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectedCheckBoxIconDataImplCopyWith<_$SelectedCheckBoxIconDataImpl>
  get copyWith => throw _privateConstructorUsedError;
}
