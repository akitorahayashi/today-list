// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../tl_todo_category_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TLToDoCategoryAction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String workspaceID, TLToDoCategory newCategory)
        addCategory,
    required TResult Function(String workspaceID, TLToDoCategory newCategory)
        updateCategory,
    required TResult Function(
            TLWorkspace corrWorkspace, TLToDoCategory categoryToDelete)
        deleteCategory,
    required TResult Function(TLWorkspace corrWorkspace,
            TLToDoCategory bigCategory, int oldIndex, int newIndex)
        reorderSmallCategory,
    required TResult Function(
            TLWorkspace corrWorkspace, int oldIndex, int newIndex)
        reorderBigCategory,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String workspaceID, TLToDoCategory newCategory)?
        addCategory,
    TResult? Function(String workspaceID, TLToDoCategory newCategory)?
        updateCategory,
    TResult? Function(
            TLWorkspace corrWorkspace, TLToDoCategory categoryToDelete)?
        deleteCategory,
    TResult? Function(TLWorkspace corrWorkspace, TLToDoCategory bigCategory,
            int oldIndex, int newIndex)?
        reorderSmallCategory,
    TResult? Function(TLWorkspace corrWorkspace, int oldIndex, int newIndex)?
        reorderBigCategory,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String workspaceID, TLToDoCategory newCategory)?
        addCategory,
    TResult Function(String workspaceID, TLToDoCategory newCategory)?
        updateCategory,
    TResult Function(
            TLWorkspace corrWorkspace, TLToDoCategory categoryToDelete)?
        deleteCategory,
    TResult Function(TLWorkspace corrWorkspace, TLToDoCategory bigCategory,
            int oldIndex, int newIndex)?
        reorderSmallCategory,
    TResult Function(TLWorkspace corrWorkspace, int oldIndex, int newIndex)?
        reorderBigCategory,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddCategory value) addCategory,
    required TResult Function(_UpdateCategory value) updateCategory,
    required TResult Function(_RemoveCategory value) deleteCategory,
    required TResult Function(_ReorderSmallCategory value) reorderSmallCategory,
    required TResult Function(_ReorderBigCategory value) reorderBigCategory,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddCategory value)? addCategory,
    TResult? Function(_UpdateCategory value)? updateCategory,
    TResult? Function(_RemoveCategory value)? deleteCategory,
    TResult? Function(_ReorderSmallCategory value)? reorderSmallCategory,
    TResult? Function(_ReorderBigCategory value)? reorderBigCategory,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddCategory value)? addCategory,
    TResult Function(_UpdateCategory value)? updateCategory,
    TResult Function(_RemoveCategory value)? deleteCategory,
    TResult Function(_ReorderSmallCategory value)? reorderSmallCategory,
    TResult Function(_ReorderBigCategory value)? reorderBigCategory,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TLToDoCategoryActionCopyWith<$Res> {
  factory $TLToDoCategoryActionCopyWith(TLToDoCategoryAction value,
          $Res Function(TLToDoCategoryAction) then) =
      _$TLToDoCategoryActionCopyWithImpl<$Res, TLToDoCategoryAction>;
}

/// @nodoc
class _$TLToDoCategoryActionCopyWithImpl<$Res,
        $Val extends TLToDoCategoryAction>
    implements $TLToDoCategoryActionCopyWith<$Res> {
  _$TLToDoCategoryActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TLToDoCategoryAction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AddCategoryImplCopyWith<$Res> {
  factory _$$AddCategoryImplCopyWith(
          _$AddCategoryImpl value, $Res Function(_$AddCategoryImpl) then) =
      __$$AddCategoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String workspaceID, TLToDoCategory newCategory});

  $TLToDoCategoryCopyWith<$Res> get newCategory;
}

/// @nodoc
class __$$AddCategoryImplCopyWithImpl<$Res>
    extends _$TLToDoCategoryActionCopyWithImpl<$Res, _$AddCategoryImpl>
    implements _$$AddCategoryImplCopyWith<$Res> {
  __$$AddCategoryImplCopyWithImpl(
      _$AddCategoryImpl _value, $Res Function(_$AddCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLToDoCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workspaceID = null,
    Object? newCategory = null,
  }) {
    return _then(_$AddCategoryImpl(
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

  /// Create a copy of TLToDoCategoryAction
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

class _$AddCategoryImpl implements _AddCategory {
  const _$AddCategoryImpl(
      {required this.workspaceID, required this.newCategory});

  @override
  final String workspaceID;
  @override
  final TLToDoCategory newCategory;

  @override
  String toString() {
    return 'TLToDoCategoryAction.addCategory(workspaceID: $workspaceID, newCategory: $newCategory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddCategoryImpl &&
            (identical(other.workspaceID, workspaceID) ||
                other.workspaceID == workspaceID) &&
            (identical(other.newCategory, newCategory) ||
                other.newCategory == newCategory));
  }

  @override
  int get hashCode => Object.hash(runtimeType, workspaceID, newCategory);

  /// Create a copy of TLToDoCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddCategoryImplCopyWith<_$AddCategoryImpl> get copyWith =>
      __$$AddCategoryImplCopyWithImpl<_$AddCategoryImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String workspaceID, TLToDoCategory newCategory)
        addCategory,
    required TResult Function(String workspaceID, TLToDoCategory newCategory)
        updateCategory,
    required TResult Function(
            TLWorkspace corrWorkspace, TLToDoCategory categoryToDelete)
        deleteCategory,
    required TResult Function(TLWorkspace corrWorkspace,
            TLToDoCategory bigCategory, int oldIndex, int newIndex)
        reorderSmallCategory,
    required TResult Function(
            TLWorkspace corrWorkspace, int oldIndex, int newIndex)
        reorderBigCategory,
  }) {
    return addCategory(workspaceID, newCategory);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String workspaceID, TLToDoCategory newCategory)?
        addCategory,
    TResult? Function(String workspaceID, TLToDoCategory newCategory)?
        updateCategory,
    TResult? Function(
            TLWorkspace corrWorkspace, TLToDoCategory categoryToDelete)?
        deleteCategory,
    TResult? Function(TLWorkspace corrWorkspace, TLToDoCategory bigCategory,
            int oldIndex, int newIndex)?
        reorderSmallCategory,
    TResult? Function(TLWorkspace corrWorkspace, int oldIndex, int newIndex)?
        reorderBigCategory,
  }) {
    return addCategory?.call(workspaceID, newCategory);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String workspaceID, TLToDoCategory newCategory)?
        addCategory,
    TResult Function(String workspaceID, TLToDoCategory newCategory)?
        updateCategory,
    TResult Function(
            TLWorkspace corrWorkspace, TLToDoCategory categoryToDelete)?
        deleteCategory,
    TResult Function(TLWorkspace corrWorkspace, TLToDoCategory bigCategory,
            int oldIndex, int newIndex)?
        reorderSmallCategory,
    TResult Function(TLWorkspace corrWorkspace, int oldIndex, int newIndex)?
        reorderBigCategory,
    required TResult orElse(),
  }) {
    if (addCategory != null) {
      return addCategory(workspaceID, newCategory);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddCategory value) addCategory,
    required TResult Function(_UpdateCategory value) updateCategory,
    required TResult Function(_RemoveCategory value) deleteCategory,
    required TResult Function(_ReorderSmallCategory value) reorderSmallCategory,
    required TResult Function(_ReorderBigCategory value) reorderBigCategory,
  }) {
    return addCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddCategory value)? addCategory,
    TResult? Function(_UpdateCategory value)? updateCategory,
    TResult? Function(_RemoveCategory value)? deleteCategory,
    TResult? Function(_ReorderSmallCategory value)? reorderSmallCategory,
    TResult? Function(_ReorderBigCategory value)? reorderBigCategory,
  }) {
    return addCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddCategory value)? addCategory,
    TResult Function(_UpdateCategory value)? updateCategory,
    TResult Function(_RemoveCategory value)? deleteCategory,
    TResult Function(_ReorderSmallCategory value)? reorderSmallCategory,
    TResult Function(_ReorderBigCategory value)? reorderBigCategory,
    required TResult orElse(),
  }) {
    if (addCategory != null) {
      return addCategory(this);
    }
    return orElse();
  }
}

abstract class _AddCategory implements TLToDoCategoryAction {
  const factory _AddCategory(
      {required final String workspaceID,
      required final TLToDoCategory newCategory}) = _$AddCategoryImpl;

  String get workspaceID;
  TLToDoCategory get newCategory;

  /// Create a copy of TLToDoCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddCategoryImplCopyWith<_$AddCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateCategoryImplCopyWith<$Res> {
  factory _$$UpdateCategoryImplCopyWith(_$UpdateCategoryImpl value,
          $Res Function(_$UpdateCategoryImpl) then) =
      __$$UpdateCategoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String workspaceID, TLToDoCategory newCategory});

  $TLToDoCategoryCopyWith<$Res> get newCategory;
}

/// @nodoc
class __$$UpdateCategoryImplCopyWithImpl<$Res>
    extends _$TLToDoCategoryActionCopyWithImpl<$Res, _$UpdateCategoryImpl>
    implements _$$UpdateCategoryImplCopyWith<$Res> {
  __$$UpdateCategoryImplCopyWithImpl(
      _$UpdateCategoryImpl _value, $Res Function(_$UpdateCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLToDoCategoryAction
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

  /// Create a copy of TLToDoCategoryAction
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
    return 'TLToDoCategoryAction.updateCategory(workspaceID: $workspaceID, newCategory: $newCategory)';
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

  /// Create a copy of TLToDoCategoryAction
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
    required TResult Function(String workspaceID, TLToDoCategory newCategory)
        addCategory,
    required TResult Function(String workspaceID, TLToDoCategory newCategory)
        updateCategory,
    required TResult Function(
            TLWorkspace corrWorkspace, TLToDoCategory categoryToDelete)
        deleteCategory,
    required TResult Function(TLWorkspace corrWorkspace,
            TLToDoCategory bigCategory, int oldIndex, int newIndex)
        reorderSmallCategory,
    required TResult Function(
            TLWorkspace corrWorkspace, int oldIndex, int newIndex)
        reorderBigCategory,
  }) {
    return updateCategory(workspaceID, newCategory);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String workspaceID, TLToDoCategory newCategory)?
        addCategory,
    TResult? Function(String workspaceID, TLToDoCategory newCategory)?
        updateCategory,
    TResult? Function(
            TLWorkspace corrWorkspace, TLToDoCategory categoryToDelete)?
        deleteCategory,
    TResult? Function(TLWorkspace corrWorkspace, TLToDoCategory bigCategory,
            int oldIndex, int newIndex)?
        reorderSmallCategory,
    TResult? Function(TLWorkspace corrWorkspace, int oldIndex, int newIndex)?
        reorderBigCategory,
  }) {
    return updateCategory?.call(workspaceID, newCategory);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String workspaceID, TLToDoCategory newCategory)?
        addCategory,
    TResult Function(String workspaceID, TLToDoCategory newCategory)?
        updateCategory,
    TResult Function(
            TLWorkspace corrWorkspace, TLToDoCategory categoryToDelete)?
        deleteCategory,
    TResult Function(TLWorkspace corrWorkspace, TLToDoCategory bigCategory,
            int oldIndex, int newIndex)?
        reorderSmallCategory,
    TResult Function(TLWorkspace corrWorkspace, int oldIndex, int newIndex)?
        reorderBigCategory,
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
    required TResult Function(_RemoveCategory value) deleteCategory,
    required TResult Function(_ReorderSmallCategory value) reorderSmallCategory,
    required TResult Function(_ReorderBigCategory value) reorderBigCategory,
  }) {
    return updateCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddCategory value)? addCategory,
    TResult? Function(_UpdateCategory value)? updateCategory,
    TResult? Function(_RemoveCategory value)? deleteCategory,
    TResult? Function(_ReorderSmallCategory value)? reorderSmallCategory,
    TResult? Function(_ReorderBigCategory value)? reorderBigCategory,
  }) {
    return updateCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddCategory value)? addCategory,
    TResult Function(_UpdateCategory value)? updateCategory,
    TResult Function(_RemoveCategory value)? deleteCategory,
    TResult Function(_ReorderSmallCategory value)? reorderSmallCategory,
    TResult Function(_ReorderBigCategory value)? reorderBigCategory,
    required TResult orElse(),
  }) {
    if (updateCategory != null) {
      return updateCategory(this);
    }
    return orElse();
  }
}

abstract class _UpdateCategory implements TLToDoCategoryAction {
  const factory _UpdateCategory(
      {required final String workspaceID,
      required final TLToDoCategory newCategory}) = _$UpdateCategoryImpl;

  String get workspaceID;
  TLToDoCategory get newCategory;

  /// Create a copy of TLToDoCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateCategoryImplCopyWith<_$UpdateCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveCategoryImplCopyWith<$Res> {
  factory _$$RemoveCategoryImplCopyWith(_$RemoveCategoryImpl value,
          $Res Function(_$RemoveCategoryImpl) then) =
      __$$RemoveCategoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TLWorkspace corrWorkspace, TLToDoCategory categoryToDelete});

  $TLWorkspaceCopyWith<$Res> get corrWorkspace;
  $TLToDoCategoryCopyWith<$Res> get categoryToDelete;
}

/// @nodoc
class __$$RemoveCategoryImplCopyWithImpl<$Res>
    extends _$TLToDoCategoryActionCopyWithImpl<$Res, _$RemoveCategoryImpl>
    implements _$$RemoveCategoryImplCopyWith<$Res> {
  __$$RemoveCategoryImplCopyWithImpl(
      _$RemoveCategoryImpl _value, $Res Function(_$RemoveCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLToDoCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? corrWorkspace = null,
    Object? categoryToDelete = null,
  }) {
    return _then(_$RemoveCategoryImpl(
      corrWorkspace: null == corrWorkspace
          ? _value.corrWorkspace
          : corrWorkspace // ignore: cast_nullable_to_non_nullable
              as TLWorkspace,
      categoryToDelete: null == categoryToDelete
          ? _value.categoryToDelete
          : categoryToDelete // ignore: cast_nullable_to_non_nullable
              as TLToDoCategory,
    ));
  }

  /// Create a copy of TLToDoCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLWorkspaceCopyWith<$Res> get corrWorkspace {
    return $TLWorkspaceCopyWith<$Res>(_value.corrWorkspace, (value) {
      return _then(_value.copyWith(corrWorkspace: value));
    });
  }

  /// Create a copy of TLToDoCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLToDoCategoryCopyWith<$Res> get categoryToDelete {
    return $TLToDoCategoryCopyWith<$Res>(_value.categoryToDelete, (value) {
      return _then(_value.copyWith(categoryToDelete: value));
    });
  }
}

/// @nodoc

class _$RemoveCategoryImpl implements _RemoveCategory {
  const _$RemoveCategoryImpl(
      {required this.corrWorkspace, required this.categoryToDelete});

  @override
  final TLWorkspace corrWorkspace;
  @override
  final TLToDoCategory categoryToDelete;

  @override
  String toString() {
    return 'TLToDoCategoryAction.deleteCategory(corrWorkspace: $corrWorkspace, categoryToDelete: $categoryToDelete)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveCategoryImpl &&
            (identical(other.corrWorkspace, corrWorkspace) ||
                other.corrWorkspace == corrWorkspace) &&
            (identical(other.categoryToDelete, categoryToDelete) ||
                other.categoryToDelete == categoryToDelete));
  }

  @override
  int get hashCode => Object.hash(runtimeType, corrWorkspace, categoryToDelete);

  /// Create a copy of TLToDoCategoryAction
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
    required TResult Function(String workspaceID, TLToDoCategory newCategory)
        addCategory,
    required TResult Function(String workspaceID, TLToDoCategory newCategory)
        updateCategory,
    required TResult Function(
            TLWorkspace corrWorkspace, TLToDoCategory categoryToDelete)
        deleteCategory,
    required TResult Function(TLWorkspace corrWorkspace,
            TLToDoCategory bigCategory, int oldIndex, int newIndex)
        reorderSmallCategory,
    required TResult Function(
            TLWorkspace corrWorkspace, int oldIndex, int newIndex)
        reorderBigCategory,
  }) {
    return deleteCategory(corrWorkspace, categoryToDelete);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String workspaceID, TLToDoCategory newCategory)?
        addCategory,
    TResult? Function(String workspaceID, TLToDoCategory newCategory)?
        updateCategory,
    TResult? Function(
            TLWorkspace corrWorkspace, TLToDoCategory categoryToDelete)?
        deleteCategory,
    TResult? Function(TLWorkspace corrWorkspace, TLToDoCategory bigCategory,
            int oldIndex, int newIndex)?
        reorderSmallCategory,
    TResult? Function(TLWorkspace corrWorkspace, int oldIndex, int newIndex)?
        reorderBigCategory,
  }) {
    return deleteCategory?.call(corrWorkspace, categoryToDelete);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String workspaceID, TLToDoCategory newCategory)?
        addCategory,
    TResult Function(String workspaceID, TLToDoCategory newCategory)?
        updateCategory,
    TResult Function(
            TLWorkspace corrWorkspace, TLToDoCategory categoryToDelete)?
        deleteCategory,
    TResult Function(TLWorkspace corrWorkspace, TLToDoCategory bigCategory,
            int oldIndex, int newIndex)?
        reorderSmallCategory,
    TResult Function(TLWorkspace corrWorkspace, int oldIndex, int newIndex)?
        reorderBigCategory,
    required TResult orElse(),
  }) {
    if (deleteCategory != null) {
      return deleteCategory(corrWorkspace, categoryToDelete);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddCategory value) addCategory,
    required TResult Function(_UpdateCategory value) updateCategory,
    required TResult Function(_RemoveCategory value) deleteCategory,
    required TResult Function(_ReorderSmallCategory value) reorderSmallCategory,
    required TResult Function(_ReorderBigCategory value) reorderBigCategory,
  }) {
    return deleteCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddCategory value)? addCategory,
    TResult? Function(_UpdateCategory value)? updateCategory,
    TResult? Function(_RemoveCategory value)? deleteCategory,
    TResult? Function(_ReorderSmallCategory value)? reorderSmallCategory,
    TResult? Function(_ReorderBigCategory value)? reorderBigCategory,
  }) {
    return deleteCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddCategory value)? addCategory,
    TResult Function(_UpdateCategory value)? updateCategory,
    TResult Function(_RemoveCategory value)? deleteCategory,
    TResult Function(_ReorderSmallCategory value)? reorderSmallCategory,
    TResult Function(_ReorderBigCategory value)? reorderBigCategory,
    required TResult orElse(),
  }) {
    if (deleteCategory != null) {
      return deleteCategory(this);
    }
    return orElse();
  }
}

abstract class _RemoveCategory implements TLToDoCategoryAction {
  const factory _RemoveCategory(
      {required final TLWorkspace corrWorkspace,
      required final TLToDoCategory categoryToDelete}) = _$RemoveCategoryImpl;

  TLWorkspace get corrWorkspace;
  TLToDoCategory get categoryToDelete;

  /// Create a copy of TLToDoCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveCategoryImplCopyWith<_$RemoveCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReorderSmallCategoryImplCopyWith<$Res> {
  factory _$$ReorderSmallCategoryImplCopyWith(_$ReorderSmallCategoryImpl value,
          $Res Function(_$ReorderSmallCategoryImpl) then) =
      __$$ReorderSmallCategoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {TLWorkspace corrWorkspace,
      TLToDoCategory bigCategory,
      int oldIndex,
      int newIndex});

  $TLWorkspaceCopyWith<$Res> get corrWorkspace;
  $TLToDoCategoryCopyWith<$Res> get bigCategory;
}

/// @nodoc
class __$$ReorderSmallCategoryImplCopyWithImpl<$Res>
    extends _$TLToDoCategoryActionCopyWithImpl<$Res, _$ReorderSmallCategoryImpl>
    implements _$$ReorderSmallCategoryImplCopyWith<$Res> {
  __$$ReorderSmallCategoryImplCopyWithImpl(_$ReorderSmallCategoryImpl _value,
      $Res Function(_$ReorderSmallCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLToDoCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? corrWorkspace = null,
    Object? bigCategory = null,
    Object? oldIndex = null,
    Object? newIndex = null,
  }) {
    return _then(_$ReorderSmallCategoryImpl(
      corrWorkspace: null == corrWorkspace
          ? _value.corrWorkspace
          : corrWorkspace // ignore: cast_nullable_to_non_nullable
              as TLWorkspace,
      bigCategory: null == bigCategory
          ? _value.bigCategory
          : bigCategory // ignore: cast_nullable_to_non_nullable
              as TLToDoCategory,
      oldIndex: null == oldIndex
          ? _value.oldIndex
          : oldIndex // ignore: cast_nullable_to_non_nullable
              as int,
      newIndex: null == newIndex
          ? _value.newIndex
          : newIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of TLToDoCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLWorkspaceCopyWith<$Res> get corrWorkspace {
    return $TLWorkspaceCopyWith<$Res>(_value.corrWorkspace, (value) {
      return _then(_value.copyWith(corrWorkspace: value));
    });
  }

  /// Create a copy of TLToDoCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLToDoCategoryCopyWith<$Res> get bigCategory {
    return $TLToDoCategoryCopyWith<$Res>(_value.bigCategory, (value) {
      return _then(_value.copyWith(bigCategory: value));
    });
  }
}

/// @nodoc

class _$ReorderSmallCategoryImpl implements _ReorderSmallCategory {
  const _$ReorderSmallCategoryImpl(
      {required this.corrWorkspace,
      required this.bigCategory,
      required this.oldIndex,
      required this.newIndex});

  @override
  final TLWorkspace corrWorkspace;
  @override
  final TLToDoCategory bigCategory;
  @override
  final int oldIndex;
  @override
  final int newIndex;

  @override
  String toString() {
    return 'TLToDoCategoryAction.reorderSmallCategory(corrWorkspace: $corrWorkspace, bigCategory: $bigCategory, oldIndex: $oldIndex, newIndex: $newIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReorderSmallCategoryImpl &&
            (identical(other.corrWorkspace, corrWorkspace) ||
                other.corrWorkspace == corrWorkspace) &&
            (identical(other.bigCategory, bigCategory) ||
                other.bigCategory == bigCategory) &&
            (identical(other.oldIndex, oldIndex) ||
                other.oldIndex == oldIndex) &&
            (identical(other.newIndex, newIndex) ||
                other.newIndex == newIndex));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, corrWorkspace, bigCategory, oldIndex, newIndex);

  /// Create a copy of TLToDoCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReorderSmallCategoryImplCopyWith<_$ReorderSmallCategoryImpl>
      get copyWith =>
          __$$ReorderSmallCategoryImplCopyWithImpl<_$ReorderSmallCategoryImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String workspaceID, TLToDoCategory newCategory)
        addCategory,
    required TResult Function(String workspaceID, TLToDoCategory newCategory)
        updateCategory,
    required TResult Function(
            TLWorkspace corrWorkspace, TLToDoCategory categoryToDelete)
        deleteCategory,
    required TResult Function(TLWorkspace corrWorkspace,
            TLToDoCategory bigCategory, int oldIndex, int newIndex)
        reorderSmallCategory,
    required TResult Function(
            TLWorkspace corrWorkspace, int oldIndex, int newIndex)
        reorderBigCategory,
  }) {
    return reorderSmallCategory(corrWorkspace, bigCategory, oldIndex, newIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String workspaceID, TLToDoCategory newCategory)?
        addCategory,
    TResult? Function(String workspaceID, TLToDoCategory newCategory)?
        updateCategory,
    TResult? Function(
            TLWorkspace corrWorkspace, TLToDoCategory categoryToDelete)?
        deleteCategory,
    TResult? Function(TLWorkspace corrWorkspace, TLToDoCategory bigCategory,
            int oldIndex, int newIndex)?
        reorderSmallCategory,
    TResult? Function(TLWorkspace corrWorkspace, int oldIndex, int newIndex)?
        reorderBigCategory,
  }) {
    return reorderSmallCategory?.call(
        corrWorkspace, bigCategory, oldIndex, newIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String workspaceID, TLToDoCategory newCategory)?
        addCategory,
    TResult Function(String workspaceID, TLToDoCategory newCategory)?
        updateCategory,
    TResult Function(
            TLWorkspace corrWorkspace, TLToDoCategory categoryToDelete)?
        deleteCategory,
    TResult Function(TLWorkspace corrWorkspace, TLToDoCategory bigCategory,
            int oldIndex, int newIndex)?
        reorderSmallCategory,
    TResult Function(TLWorkspace corrWorkspace, int oldIndex, int newIndex)?
        reorderBigCategory,
    required TResult orElse(),
  }) {
    if (reorderSmallCategory != null) {
      return reorderSmallCategory(
          corrWorkspace, bigCategory, oldIndex, newIndex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddCategory value) addCategory,
    required TResult Function(_UpdateCategory value) updateCategory,
    required TResult Function(_RemoveCategory value) deleteCategory,
    required TResult Function(_ReorderSmallCategory value) reorderSmallCategory,
    required TResult Function(_ReorderBigCategory value) reorderBigCategory,
  }) {
    return reorderSmallCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddCategory value)? addCategory,
    TResult? Function(_UpdateCategory value)? updateCategory,
    TResult? Function(_RemoveCategory value)? deleteCategory,
    TResult? Function(_ReorderSmallCategory value)? reorderSmallCategory,
    TResult? Function(_ReorderBigCategory value)? reorderBigCategory,
  }) {
    return reorderSmallCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddCategory value)? addCategory,
    TResult Function(_UpdateCategory value)? updateCategory,
    TResult Function(_RemoveCategory value)? deleteCategory,
    TResult Function(_ReorderSmallCategory value)? reorderSmallCategory,
    TResult Function(_ReorderBigCategory value)? reorderBigCategory,
    required TResult orElse(),
  }) {
    if (reorderSmallCategory != null) {
      return reorderSmallCategory(this);
    }
    return orElse();
  }
}

abstract class _ReorderSmallCategory implements TLToDoCategoryAction {
  const factory _ReorderSmallCategory(
      {required final TLWorkspace corrWorkspace,
      required final TLToDoCategory bigCategory,
      required final int oldIndex,
      required final int newIndex}) = _$ReorderSmallCategoryImpl;

  TLWorkspace get corrWorkspace;
  TLToDoCategory get bigCategory;
  int get oldIndex;
  int get newIndex;

  /// Create a copy of TLToDoCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReorderSmallCategoryImplCopyWith<_$ReorderSmallCategoryImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReorderBigCategoryImplCopyWith<$Res> {
  factory _$$ReorderBigCategoryImplCopyWith(_$ReorderBigCategoryImpl value,
          $Res Function(_$ReorderBigCategoryImpl) then) =
      __$$ReorderBigCategoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TLWorkspace corrWorkspace, int oldIndex, int newIndex});

  $TLWorkspaceCopyWith<$Res> get corrWorkspace;
}

/// @nodoc
class __$$ReorderBigCategoryImplCopyWithImpl<$Res>
    extends _$TLToDoCategoryActionCopyWithImpl<$Res, _$ReorderBigCategoryImpl>
    implements _$$ReorderBigCategoryImplCopyWith<$Res> {
  __$$ReorderBigCategoryImplCopyWithImpl(_$ReorderBigCategoryImpl _value,
      $Res Function(_$ReorderBigCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLToDoCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? corrWorkspace = null,
    Object? oldIndex = null,
    Object? newIndex = null,
  }) {
    return _then(_$ReorderBigCategoryImpl(
      corrWorkspace: null == corrWorkspace
          ? _value.corrWorkspace
          : corrWorkspace // ignore: cast_nullable_to_non_nullable
              as TLWorkspace,
      oldIndex: null == oldIndex
          ? _value.oldIndex
          : oldIndex // ignore: cast_nullable_to_non_nullable
              as int,
      newIndex: null == newIndex
          ? _value.newIndex
          : newIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of TLToDoCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TLWorkspaceCopyWith<$Res> get corrWorkspace {
    return $TLWorkspaceCopyWith<$Res>(_value.corrWorkspace, (value) {
      return _then(_value.copyWith(corrWorkspace: value));
    });
  }
}

/// @nodoc

class _$ReorderBigCategoryImpl implements _ReorderBigCategory {
  const _$ReorderBigCategoryImpl(
      {required this.corrWorkspace,
      required this.oldIndex,
      required this.newIndex});

  @override
  final TLWorkspace corrWorkspace;
  @override
  final int oldIndex;
  @override
  final int newIndex;

  @override
  String toString() {
    return 'TLToDoCategoryAction.reorderBigCategory(corrWorkspace: $corrWorkspace, oldIndex: $oldIndex, newIndex: $newIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReorderBigCategoryImpl &&
            (identical(other.corrWorkspace, corrWorkspace) ||
                other.corrWorkspace == corrWorkspace) &&
            (identical(other.oldIndex, oldIndex) ||
                other.oldIndex == oldIndex) &&
            (identical(other.newIndex, newIndex) ||
                other.newIndex == newIndex));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, corrWorkspace, oldIndex, newIndex);

  /// Create a copy of TLToDoCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReorderBigCategoryImplCopyWith<_$ReorderBigCategoryImpl> get copyWith =>
      __$$ReorderBigCategoryImplCopyWithImpl<_$ReorderBigCategoryImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String workspaceID, TLToDoCategory newCategory)
        addCategory,
    required TResult Function(String workspaceID, TLToDoCategory newCategory)
        updateCategory,
    required TResult Function(
            TLWorkspace corrWorkspace, TLToDoCategory categoryToDelete)
        deleteCategory,
    required TResult Function(TLWorkspace corrWorkspace,
            TLToDoCategory bigCategory, int oldIndex, int newIndex)
        reorderSmallCategory,
    required TResult Function(
            TLWorkspace corrWorkspace, int oldIndex, int newIndex)
        reorderBigCategory,
  }) {
    return reorderBigCategory(corrWorkspace, oldIndex, newIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String workspaceID, TLToDoCategory newCategory)?
        addCategory,
    TResult? Function(String workspaceID, TLToDoCategory newCategory)?
        updateCategory,
    TResult? Function(
            TLWorkspace corrWorkspace, TLToDoCategory categoryToDelete)?
        deleteCategory,
    TResult? Function(TLWorkspace corrWorkspace, TLToDoCategory bigCategory,
            int oldIndex, int newIndex)?
        reorderSmallCategory,
    TResult? Function(TLWorkspace corrWorkspace, int oldIndex, int newIndex)?
        reorderBigCategory,
  }) {
    return reorderBigCategory?.call(corrWorkspace, oldIndex, newIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String workspaceID, TLToDoCategory newCategory)?
        addCategory,
    TResult Function(String workspaceID, TLToDoCategory newCategory)?
        updateCategory,
    TResult Function(
            TLWorkspace corrWorkspace, TLToDoCategory categoryToDelete)?
        deleteCategory,
    TResult Function(TLWorkspace corrWorkspace, TLToDoCategory bigCategory,
            int oldIndex, int newIndex)?
        reorderSmallCategory,
    TResult Function(TLWorkspace corrWorkspace, int oldIndex, int newIndex)?
        reorderBigCategory,
    required TResult orElse(),
  }) {
    if (reorderBigCategory != null) {
      return reorderBigCategory(corrWorkspace, oldIndex, newIndex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddCategory value) addCategory,
    required TResult Function(_UpdateCategory value) updateCategory,
    required TResult Function(_RemoveCategory value) deleteCategory,
    required TResult Function(_ReorderSmallCategory value) reorderSmallCategory,
    required TResult Function(_ReorderBigCategory value) reorderBigCategory,
  }) {
    return reorderBigCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddCategory value)? addCategory,
    TResult? Function(_UpdateCategory value)? updateCategory,
    TResult? Function(_RemoveCategory value)? deleteCategory,
    TResult? Function(_ReorderSmallCategory value)? reorderSmallCategory,
    TResult? Function(_ReorderBigCategory value)? reorderBigCategory,
  }) {
    return reorderBigCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddCategory value)? addCategory,
    TResult Function(_UpdateCategory value)? updateCategory,
    TResult Function(_RemoveCategory value)? deleteCategory,
    TResult Function(_ReorderSmallCategory value)? reorderSmallCategory,
    TResult Function(_ReorderBigCategory value)? reorderBigCategory,
    required TResult orElse(),
  }) {
    if (reorderBigCategory != null) {
      return reorderBigCategory(this);
    }
    return orElse();
  }
}

abstract class _ReorderBigCategory implements TLToDoCategoryAction {
  const factory _ReorderBigCategory(
      {required final TLWorkspace corrWorkspace,
      required final int oldIndex,
      required final int newIndex}) = _$ReorderBigCategoryImpl;

  TLWorkspace get corrWorkspace;
  int get oldIndex;
  int get newIndex;

  /// Create a copy of TLToDoCategoryAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReorderBigCategoryImplCopyWith<_$ReorderBigCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
