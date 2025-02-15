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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TLWorkspace _$TLWorkspaceFromJson(Map<String, dynamic> json) {
  return _TLWorkspace.fromJson(json);
}

/// @nodoc
mixin _$TLWorkspace {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<TLToDoCategory> get bigCategories => throw _privateConstructorUsedError;
  Map<String, List<TLToDoCategory>> get smallCategories =>
      throw _privateConstructorUsedError;
  Map<String, TLToDosInTodayAndWhenever> get categoryIDToToDos =>
      throw _privateConstructorUsedError;

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
          TLWorkspace value, $Res Function(TLWorkspace) then) =
      _$TLWorkspaceCopyWithImpl<$Res, TLWorkspace>;
  @useResult
  $Res call(
      {String id,
      String name,
      List<TLToDoCategory> bigCategories,
      Map<String, List<TLToDoCategory>> smallCategories,
      Map<String, TLToDosInTodayAndWhenever> categoryIDToToDos});
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
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? bigCategories = null,
    Object? smallCategories = null,
    Object? categoryIDToToDos = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      bigCategories: null == bigCategories
          ? _value.bigCategories
          : bigCategories // ignore: cast_nullable_to_non_nullable
              as List<TLToDoCategory>,
      smallCategories: null == smallCategories
          ? _value.smallCategories
          : smallCategories // ignore: cast_nullable_to_non_nullable
              as Map<String, List<TLToDoCategory>>,
      categoryIDToToDos: null == categoryIDToToDos
          ? _value.categoryIDToToDos
          : categoryIDToToDos // ignore: cast_nullable_to_non_nullable
              as Map<String, TLToDosInTodayAndWhenever>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TLWorkspaceImplCopyWith<$Res>
    implements $TLWorkspaceCopyWith<$Res> {
  factory _$$TLWorkspaceImplCopyWith(
          _$TLWorkspaceImpl value, $Res Function(_$TLWorkspaceImpl) then) =
      __$$TLWorkspaceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      List<TLToDoCategory> bigCategories,
      Map<String, List<TLToDoCategory>> smallCategories,
      Map<String, TLToDosInTodayAndWhenever> categoryIDToToDos});
}

/// @nodoc
class __$$TLWorkspaceImplCopyWithImpl<$Res>
    extends _$TLWorkspaceCopyWithImpl<$Res, _$TLWorkspaceImpl>
    implements _$$TLWorkspaceImplCopyWith<$Res> {
  __$$TLWorkspaceImplCopyWithImpl(
      _$TLWorkspaceImpl _value, $Res Function(_$TLWorkspaceImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLWorkspace
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? bigCategories = null,
    Object? smallCategories = null,
    Object? categoryIDToToDos = null,
  }) {
    return _then(_$TLWorkspaceImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      bigCategories: null == bigCategories
          ? _value._bigCategories
          : bigCategories // ignore: cast_nullable_to_non_nullable
              as List<TLToDoCategory>,
      smallCategories: null == smallCategories
          ? _value._smallCategories
          : smallCategories // ignore: cast_nullable_to_non_nullable
              as Map<String, List<TLToDoCategory>>,
      categoryIDToToDos: null == categoryIDToToDos
          ? _value._categoryIDToToDos
          : categoryIDToToDos // ignore: cast_nullable_to_non_nullable
              as Map<String, TLToDosInTodayAndWhenever>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TLWorkspaceImpl implements _TLWorkspace {
  _$TLWorkspaceImpl(
      {required this.id,
      required this.name,
      required final List<TLToDoCategory> bigCategories,
      required final Map<String, List<TLToDoCategory>> smallCategories,
      required final Map<String, TLToDosInTodayAndWhenever> categoryIDToToDos})
      : _bigCategories = bigCategories,
        _smallCategories = smallCategories,
        _categoryIDToToDos = categoryIDToToDos;

  factory _$TLWorkspaceImpl.fromJson(Map<String, dynamic> json) =>
      _$$TLWorkspaceImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  final List<TLToDoCategory> _bigCategories;
  @override
  List<TLToDoCategory> get bigCategories {
    if (_bigCategories is EqualUnmodifiableListView) return _bigCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bigCategories);
  }

  final Map<String, List<TLToDoCategory>> _smallCategories;
  @override
  Map<String, List<TLToDoCategory>> get smallCategories {
    if (_smallCategories is EqualUnmodifiableMapView) return _smallCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_smallCategories);
  }

  final Map<String, TLToDosInTodayAndWhenever> _categoryIDToToDos;
  @override
  Map<String, TLToDosInTodayAndWhenever> get categoryIDToToDos {
    if (_categoryIDToToDos is EqualUnmodifiableMapView)
      return _categoryIDToToDos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_categoryIDToToDos);
  }

  @override
  String toString() {
    return 'TLWorkspace(id: $id, name: $name, bigCategories: $bigCategories, smallCategories: $smallCategories, categoryIDToToDos: $categoryIDToToDos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TLWorkspaceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._bigCategories, _bigCategories) &&
            const DeepCollectionEquality()
                .equals(other._smallCategories, _smallCategories) &&
            const DeepCollectionEquality()
                .equals(other._categoryIDToToDos, _categoryIDToToDos));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(_bigCategories),
      const DeepCollectionEquality().hash(_smallCategories),
      const DeepCollectionEquality().hash(_categoryIDToToDos));

  /// Create a copy of TLWorkspace
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TLWorkspaceImplCopyWith<_$TLWorkspaceImpl> get copyWith =>
      __$$TLWorkspaceImplCopyWithImpl<_$TLWorkspaceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TLWorkspaceImplToJson(
      this,
    );
  }
}

abstract class _TLWorkspace implements TLWorkspace {
  factory _TLWorkspace(
      {required final String id,
      required final String name,
      required final List<TLToDoCategory> bigCategories,
      required final Map<String, List<TLToDoCategory>> smallCategories,
      required final Map<String, TLToDosInTodayAndWhenever>
          categoryIDToToDos}) = _$TLWorkspaceImpl;

  factory _TLWorkspace.fromJson(Map<String, dynamic> json) =
      _$TLWorkspaceImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  List<TLToDoCategory> get bigCategories;
  @override
  Map<String, List<TLToDoCategory>> get smallCategories;
  @override
  Map<String, TLToDosInTodayAndWhenever> get categoryIDToToDos;

  /// Create a copy of TLWorkspace
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TLWorkspaceImplCopyWith<_$TLWorkspaceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
