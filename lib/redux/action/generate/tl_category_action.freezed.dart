// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../tl_category_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TLCategoryAction {
  String get workspaceID => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String workspaceID, TLToDoCategory category)
        addCategory,
    required TResult Function(String workspaceID, TLToDoCategory newCategory)
        updateCategory,
    required TResult Function(String workspaceID, TLToDoCategory newCategory)
        removeCategory,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String workspaceID, TLToDoCategory category)? addCategory,
    TResult? Function(String workspaceID, TLToDoCategory newCategory)?
        updateCategory,
    TResult? Function(String workspaceID, TLToDoCategory newCategory)?
        removeCategory,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String workspaceID, TLToDoCategory category)? addCategory,
    TResult Function(String workspaceID, TLToDoCategory newCategory)?
        updateCategory,
    TResult Function(String workspaceID, TLToDoCategory newCategory)?
        removeCategory,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddCategory value) addCategory,
    required TResult Function(_UpdateCategory value) updateCategory,
    required TResult Function(_RemoveCategory value) removeCategory,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddCategory value)? addCategory,
    TResult? Function(_UpdateCategory value)? updateCategory,
    TResult? Function(_RemoveCategory value)? removeCategory,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddCategory value)? addCategory,
    TResult Function(_UpdateCategory value)? updateCategory,
    TResult Function(_RemoveCategory value)? removeCategory,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of TLCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TLCategoryActionCopyWith<TLCategoryAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TLCategoryActionCopyWith<$Res> {
  factory $TLCategoryActionCopyWith(
          TLCategoryAction value, $Res Function(TLCategoryAction) then) =
      _$TLCategoryActionCopyWithImpl<$Res, TLCategoryAction>;
  @useResult
  $Res call({String workspaceID});
}

/// @nodoc
class _$TLCategoryActionCopyWithImpl<$Res, $Val extends TLCategoryAction>
    implements $TLCategoryActionCopyWith<$Res> {
  _$TLCategoryActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TLCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workspaceID = null,
  }) {
    return _then(_value.copyWith(
      workspaceID: null == workspaceID
          ? _value.workspaceID
          : workspaceID // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddCategoryImplCopyWith<$Res>
    implements $TLCategoryActionCopyWith<$Res> {
  factory _$$AddCategoryImplCopyWith(
          _$AddCategoryImpl value, $Res Function(_$AddCategoryImpl) then) =
      __$$AddCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String workspaceID, TLToDoCategory category});

  $TLToDoCategoryCopyWith<$Res> get category;
}

/// @nodoc
class __$$AddCategoryImplCopyWithImpl<$Res>
    extends _$TLCategoryActionCopyWithImpl<$Res, _$AddCategoryImpl>
    implements _$$AddCategoryImplCopyWith<$Res> {
  __$$AddCategoryImplCopyWithImpl(
      _$AddCategoryImpl _value, $Res Function(_$AddCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workspaceID = null,
    Object? category = null,
  }) {
    return _then(_$AddCategoryImpl(
      workspaceID: null == workspaceID
          ? _value.workspaceID
          : workspaceID // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as TLToDoCategory,
    ));
  }

  /// Create a copy of TLCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLToDoCategoryCopyWith<$Res> get category {
    return $TLToDoCategoryCopyWith<$Res>(_value.category, (value) {
      return _then(_value.copyWith(category: value));
    });
  }
}

/// @nodoc

class _$AddCategoryImpl implements _AddCategory {
  const _$AddCategoryImpl({required this.workspaceID, required this.category});

  @override
  final String workspaceID;
  @override
  final TLToDoCategory category;

  @override
  String toString() {
    return 'TLCategoryAction.addCategory(workspaceID: $workspaceID, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddCategoryImpl &&
            (identical(other.workspaceID, workspaceID) ||
                other.workspaceID == workspaceID) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, workspaceID, category);

  /// Create a copy of TLCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddCategoryImplCopyWith<_$AddCategoryImpl> get copyWith =>
      __$$AddCategoryImplCopyWithImpl<_$AddCategoryImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String workspaceID, TLToDoCategory category)
        addCategory,
    required TResult Function(String workspaceID, TLToDoCategory newCategory)
        updateCategory,
    required TResult Function(String workspaceID, TLToDoCategory newCategory)
        removeCategory,
  }) {
    return addCategory(workspaceID, category);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String workspaceID, TLToDoCategory category)? addCategory,
    TResult? Function(String workspaceID, TLToDoCategory newCategory)?
        updateCategory,
    TResult? Function(String workspaceID, TLToDoCategory newCategory)?
        removeCategory,
  }) {
    return addCategory?.call(workspaceID, category);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String workspaceID, TLToDoCategory category)? addCategory,
    TResult Function(String workspaceID, TLToDoCategory newCategory)?
        updateCategory,
    TResult Function(String workspaceID, TLToDoCategory newCategory)?
        removeCategory,
    required TResult orElse(),
  }) {
    if (addCategory != null) {
      return addCategory(workspaceID, category);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddCategory value) addCategory,
    required TResult Function(_UpdateCategory value) updateCategory,
    required TResult Function(_RemoveCategory value) removeCategory,
  }) {
    return addCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddCategory value)? addCategory,
    TResult? Function(_UpdateCategory value)? updateCategory,
    TResult? Function(_RemoveCategory value)? removeCategory,
  }) {
    return addCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddCategory value)? addCategory,
    TResult Function(_UpdateCategory value)? updateCategory,
    TResult Function(_RemoveCategory value)? removeCategory,
    required TResult orElse(),
  }) {
    if (addCategory != null) {
      return addCategory(this);
    }
    return orElse();
  }
}

abstract class _AddCategory implements TLCategoryAction {
  const factory _AddCategory(
      {required final String workspaceID,
      required final TLToDoCategory category}) = _$AddCategoryImpl;

  @override
  String get workspaceID;
  TLToDoCategory get category;

  /// Create a copy of TLCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddCategoryImplCopyWith<_$AddCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateCategoryImplCopyWith<$Res>
    implements $TLCategoryActionCopyWith<$Res> {
  factory _$$UpdateCategoryImplCopyWith(_$UpdateCategoryImpl value,
          $Res Function(_$UpdateCategoryImpl) then) =
      __$$UpdateCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String workspaceID, TLToDoCategory newCategory});

  $TLToDoCategoryCopyWith<$Res> get newCategory;
}

/// @nodoc
class __$$UpdateCategoryImplCopyWithImpl<$Res>
    extends _$TLCategoryActionCopyWithImpl<$Res, _$UpdateCategoryImpl>
    implements _$$UpdateCategoryImplCopyWith<$Res> {
  __$$UpdateCategoryImplCopyWithImpl(
      _$UpdateCategoryImpl _value, $Res Function(_$UpdateCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workspaceID = null,
    Object? newCategory = null,
  }) {
    return _then(_$UpdateCategoryImpl(
      workspaceID: null == workspaceID
          ? _value.workspaceID
          : workspaceID // ignore: cast_nullable_to_non_nullable
              as String,
      newCategory: null == newCategory
          ? _value.newCategory
          : newCategory // ignore: cast_nullable_to_non_nullable
              as TLToDoCategory,
    ));
  }

  /// Create a copy of TLCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLToDoCategoryCopyWith<$Res> get newCategory {
    return $TLToDoCategoryCopyWith<$Res>(_value.newCategory, (value) {
      return _then(_value.copyWith(newCategory: value));
    });
  }
}

/// @nodoc

class _$UpdateCategoryImpl implements _UpdateCategory {
  const _$UpdateCategoryImpl(
      {required this.workspaceID, required this.newCategory});

  @override
  final String workspaceID;
  @override
  final TLToDoCategory newCategory;

  @override
  String toString() {
    return 'TLCategoryAction.updateCategory(workspaceID: $workspaceID, newCategory: $newCategory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateCategoryImpl &&
            (identical(other.workspaceID, workspaceID) ||
                other.workspaceID == workspaceID) &&
            (identical(other.newCategory, newCategory) ||
                other.newCategory == newCategory));
  }

  @override
  int get hashCode => Object.hash(runtimeType, workspaceID, newCategory);

  /// Create a copy of TLCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateCategoryImplCopyWith<_$UpdateCategoryImpl> get copyWith =>
      __$$UpdateCategoryImplCopyWithImpl<_$UpdateCategoryImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String workspaceID, TLToDoCategory category)
        addCategory,
    required TResult Function(String workspaceID, TLToDoCategory newCategory)
        updateCategory,
    required TResult Function(String workspaceID, TLToDoCategory newCategory)
        removeCategory,
  }) {
    return updateCategory(workspaceID, newCategory);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String workspaceID, TLToDoCategory category)? addCategory,
    TResult? Function(String workspaceID, TLToDoCategory newCategory)?
        updateCategory,
    TResult? Function(String workspaceID, TLToDoCategory newCategory)?
        removeCategory,
  }) {
    return updateCategory?.call(workspaceID, newCategory);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String workspaceID, TLToDoCategory category)? addCategory,
    TResult Function(String workspaceID, TLToDoCategory newCategory)?
        updateCategory,
    TResult Function(String workspaceID, TLToDoCategory newCategory)?
        removeCategory,
    required TResult orElse(),
  }) {
    if (updateCategory != null) {
      return updateCategory(workspaceID, newCategory);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddCategory value) addCategory,
    required TResult Function(_UpdateCategory value) updateCategory,
    required TResult Function(_RemoveCategory value) removeCategory,
  }) {
    return updateCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddCategory value)? addCategory,
    TResult? Function(_UpdateCategory value)? updateCategory,
    TResult? Function(_RemoveCategory value)? removeCategory,
  }) {
    return updateCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddCategory value)? addCategory,
    TResult Function(_UpdateCategory value)? updateCategory,
    TResult Function(_RemoveCategory value)? removeCategory,
    required TResult orElse(),
  }) {
    if (updateCategory != null) {
      return updateCategory(this);
    }
    return orElse();
  }
}

abstract class _UpdateCategory implements TLCategoryAction {
  const factory _UpdateCategory(
      {required final String workspaceID,
      required final TLToDoCategory newCategory}) = _$UpdateCategoryImpl;

  @override
  String get workspaceID;
  TLToDoCategory get newCategory;

  /// Create a copy of TLCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateCategoryImplCopyWith<_$UpdateCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveCategoryImplCopyWith<$Res>
    implements $TLCategoryActionCopyWith<$Res> {
  factory _$$RemoveCategoryImplCopyWith(_$RemoveCategoryImpl value,
          $Res Function(_$RemoveCategoryImpl) then) =
      __$$RemoveCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String workspaceID, TLToDoCategory newCategory});

  $TLToDoCategoryCopyWith<$Res> get newCategory;
}

/// @nodoc
class __$$RemoveCategoryImplCopyWithImpl<$Res>
    extends _$TLCategoryActionCopyWithImpl<$Res, _$RemoveCategoryImpl>
    implements _$$RemoveCategoryImplCopyWith<$Res> {
  __$$RemoveCategoryImplCopyWithImpl(
      _$RemoveCategoryImpl _value, $Res Function(_$RemoveCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workspaceID = null,
    Object? newCategory = null,
  }) {
    return _then(_$RemoveCategoryImpl(
      workspaceID: null == workspaceID
          ? _value.workspaceID
          : workspaceID // ignore: cast_nullable_to_non_nullable
              as String,
      newCategory: null == newCategory
          ? _value.newCategory
          : newCategory // ignore: cast_nullable_to_non_nullable
              as TLToDoCategory,
    ));
  }

  /// Create a copy of TLCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLToDoCategoryCopyWith<$Res> get newCategory {
    return $TLToDoCategoryCopyWith<$Res>(_value.newCategory, (value) {
      return _then(_value.copyWith(newCategory: value));
    });
  }
}

/// @nodoc

class _$RemoveCategoryImpl implements _RemoveCategory {
  const _$RemoveCategoryImpl(
      {required this.workspaceID, required this.newCategory});

  @override
  final String workspaceID;
  @override
  final TLToDoCategory newCategory;

  @override
  String toString() {
    return 'TLCategoryAction.removeCategory(workspaceID: $workspaceID, newCategory: $newCategory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveCategoryImpl &&
            (identical(other.workspaceID, workspaceID) ||
                other.workspaceID == workspaceID) &&
            (identical(other.newCategory, newCategory) ||
                other.newCategory == newCategory));
  }

  @override
  int get hashCode => Object.hash(runtimeType, workspaceID, newCategory);

  /// Create a copy of TLCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveCategoryImplCopyWith<_$RemoveCategoryImpl> get copyWith =>
      __$$RemoveCategoryImplCopyWithImpl<_$RemoveCategoryImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String workspaceID, TLToDoCategory category)
        addCategory,
    required TResult Function(String workspaceID, TLToDoCategory newCategory)
        updateCategory,
    required TResult Function(String workspaceID, TLToDoCategory newCategory)
        removeCategory,
  }) {
    return removeCategory(workspaceID, newCategory);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String workspaceID, TLToDoCategory category)? addCategory,
    TResult? Function(String workspaceID, TLToDoCategory newCategory)?
        updateCategory,
    TResult? Function(String workspaceID, TLToDoCategory newCategory)?
        removeCategory,
  }) {
    return removeCategory?.call(workspaceID, newCategory);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String workspaceID, TLToDoCategory category)? addCategory,
    TResult Function(String workspaceID, TLToDoCategory newCategory)?
        updateCategory,
    TResult Function(String workspaceID, TLToDoCategory newCategory)?
        removeCategory,
    required TResult orElse(),
  }) {
    if (removeCategory != null) {
      return removeCategory(workspaceID, newCategory);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddCategory value) addCategory,
    required TResult Function(_UpdateCategory value) updateCategory,
    required TResult Function(_RemoveCategory value) removeCategory,
  }) {
    return removeCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddCategory value)? addCategory,
    TResult? Function(_UpdateCategory value)? updateCategory,
    TResult? Function(_RemoveCategory value)? removeCategory,
  }) {
    return removeCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddCategory value)? addCategory,
    TResult Function(_UpdateCategory value)? updateCategory,
    TResult Function(_RemoveCategory value)? removeCategory,
    required TResult orElse(),
  }) {
    if (removeCategory != null) {
      return removeCategory(this);
    }
    return orElse();
  }
}

abstract class _RemoveCategory implements TLCategoryAction {
  const factory _RemoveCategory(
      {required final String workspaceID,
      required final TLToDoCategory newCategory}) = _$RemoveCategoryImpl;

  @override
  String get workspaceID;
  TLToDoCategory get newCategory;

  /// Create a copy of TLCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveCategoryImplCopyWith<_$RemoveCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
