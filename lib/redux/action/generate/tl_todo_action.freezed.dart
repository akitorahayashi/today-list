// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../tl_todo_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TLToDoAction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String categoryId, String? smallCategoryId,
            int indexOfEditingToDo, bool ifInToday)
        startEditingToDo,
    required TResult Function(String newTitle) updateToDoTitle,
    required TResult Function(String stepTitle) addStep,
    required TResult Function() completeEditing,
    required TResult Function() resetEditingToDo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String categoryId, String? smallCategoryId,
            int indexOfEditingToDo, bool ifInToday)?
        startEditingToDo,
    TResult? Function(String newTitle)? updateToDoTitle,
    TResult? Function(String stepTitle)? addStep,
    TResult? Function()? completeEditing,
    TResult? Function()? resetEditingToDo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String categoryId, String? smallCategoryId,
            int indexOfEditingToDo, bool ifInToday)?
        startEditingToDo,
    TResult Function(String newTitle)? updateToDoTitle,
    TResult Function(String stepTitle)? addStep,
    TResult Function()? completeEditing,
    TResult Function()? resetEditingToDo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StartEditingToDoAction value) startEditingToDo,
    required TResult Function(UpdateToDoTitleAction value) updateToDoTitle,
    required TResult Function(AddStepAction value) addStep,
    required TResult Function(CompleteEditingToDoAction value) completeEditing,
    required TResult Function(ResetEditingToDoAction value) resetEditingToDo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StartEditingToDoAction value)? startEditingToDo,
    TResult? Function(UpdateToDoTitleAction value)? updateToDoTitle,
    TResult? Function(AddStepAction value)? addStep,
    TResult? Function(CompleteEditingToDoAction value)? completeEditing,
    TResult? Function(ResetEditingToDoAction value)? resetEditingToDo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StartEditingToDoAction value)? startEditingToDo,
    TResult Function(UpdateToDoTitleAction value)? updateToDoTitle,
    TResult Function(AddStepAction value)? addStep,
    TResult Function(CompleteEditingToDoAction value)? completeEditing,
    TResult Function(ResetEditingToDoAction value)? resetEditingToDo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TLToDoActionCopyWith<$Res> {
  factory $TLToDoActionCopyWith(
          TLToDoAction value, $Res Function(TLToDoAction) then) =
      _$TLToDoActionCopyWithImpl<$Res, TLToDoAction>;
}

/// @nodoc
class _$TLToDoActionCopyWithImpl<$Res, $Val extends TLToDoAction>
    implements $TLToDoActionCopyWith<$Res> {
  _$TLToDoActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StartEditingToDoActionImplCopyWith<$Res> {
  factory _$$StartEditingToDoActionImplCopyWith(
          _$StartEditingToDoActionImpl value,
          $Res Function(_$StartEditingToDoActionImpl) then) =
      __$$StartEditingToDoActionImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String categoryId,
      String? smallCategoryId,
      int indexOfEditingToDo,
      bool ifInToday});
}

/// @nodoc
class __$$StartEditingToDoActionImplCopyWithImpl<$Res>
    extends _$TLToDoActionCopyWithImpl<$Res, _$StartEditingToDoActionImpl>
    implements _$$StartEditingToDoActionImplCopyWith<$Res> {
  __$$StartEditingToDoActionImplCopyWithImpl(
      _$StartEditingToDoActionImpl _value,
      $Res Function(_$StartEditingToDoActionImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? smallCategoryId = freezed,
    Object? indexOfEditingToDo = null,
    Object? ifInToday = null,
  }) {
    return _then(_$StartEditingToDoActionImpl(
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      smallCategoryId: freezed == smallCategoryId
          ? _value.smallCategoryId
          : smallCategoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      indexOfEditingToDo: null == indexOfEditingToDo
          ? _value.indexOfEditingToDo
          : indexOfEditingToDo // ignore: cast_nullable_to_non_nullable
              as int,
      ifInToday: null == ifInToday
          ? _value.ifInToday
          : ifInToday // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$StartEditingToDoActionImpl implements StartEditingToDoAction {
  const _$StartEditingToDoActionImpl(
      {required this.categoryId,
      required this.smallCategoryId,
      required this.indexOfEditingToDo,
      required this.ifInToday});

  @override
  final String categoryId;
  @override
  final String? smallCategoryId;
  @override
  final int indexOfEditingToDo;
  @override
  final bool ifInToday;

  @override
  String toString() {
    return 'TLToDoAction.startEditingToDo(categoryId: $categoryId, smallCategoryId: $smallCategoryId, indexOfEditingToDo: $indexOfEditingToDo, ifInToday: $ifInToday)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StartEditingToDoActionImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.smallCategoryId, smallCategoryId) ||
                other.smallCategoryId == smallCategoryId) &&
            (identical(other.indexOfEditingToDo, indexOfEditingToDo) ||
                other.indexOfEditingToDo == indexOfEditingToDo) &&
            (identical(other.ifInToday, ifInToday) ||
                other.ifInToday == ifInToday));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, categoryId, smallCategoryId, indexOfEditingToDo, ifInToday);

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StartEditingToDoActionImplCopyWith<_$StartEditingToDoActionImpl>
      get copyWith => __$$StartEditingToDoActionImplCopyWithImpl<
          _$StartEditingToDoActionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String categoryId, String? smallCategoryId,
            int indexOfEditingToDo, bool ifInToday)
        startEditingToDo,
    required TResult Function(String newTitle) updateToDoTitle,
    required TResult Function(String stepTitle) addStep,
    required TResult Function() completeEditing,
    required TResult Function() resetEditingToDo,
  }) {
    return startEditingToDo(
        categoryId, smallCategoryId, indexOfEditingToDo, ifInToday);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String categoryId, String? smallCategoryId,
            int indexOfEditingToDo, bool ifInToday)?
        startEditingToDo,
    TResult? Function(String newTitle)? updateToDoTitle,
    TResult? Function(String stepTitle)? addStep,
    TResult? Function()? completeEditing,
    TResult? Function()? resetEditingToDo,
  }) {
    return startEditingToDo?.call(
        categoryId, smallCategoryId, indexOfEditingToDo, ifInToday);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String categoryId, String? smallCategoryId,
            int indexOfEditingToDo, bool ifInToday)?
        startEditingToDo,
    TResult Function(String newTitle)? updateToDoTitle,
    TResult Function(String stepTitle)? addStep,
    TResult Function()? completeEditing,
    TResult Function()? resetEditingToDo,
    required TResult orElse(),
  }) {
    if (startEditingToDo != null) {
      return startEditingToDo(
          categoryId, smallCategoryId, indexOfEditingToDo, ifInToday);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StartEditingToDoAction value) startEditingToDo,
    required TResult Function(UpdateToDoTitleAction value) updateToDoTitle,
    required TResult Function(AddStepAction value) addStep,
    required TResult Function(CompleteEditingToDoAction value) completeEditing,
    required TResult Function(ResetEditingToDoAction value) resetEditingToDo,
  }) {
    return startEditingToDo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StartEditingToDoAction value)? startEditingToDo,
    TResult? Function(UpdateToDoTitleAction value)? updateToDoTitle,
    TResult? Function(AddStepAction value)? addStep,
    TResult? Function(CompleteEditingToDoAction value)? completeEditing,
    TResult? Function(ResetEditingToDoAction value)? resetEditingToDo,
  }) {
    return startEditingToDo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StartEditingToDoAction value)? startEditingToDo,
    TResult Function(UpdateToDoTitleAction value)? updateToDoTitle,
    TResult Function(AddStepAction value)? addStep,
    TResult Function(CompleteEditingToDoAction value)? completeEditing,
    TResult Function(ResetEditingToDoAction value)? resetEditingToDo,
    required TResult orElse(),
  }) {
    if (startEditingToDo != null) {
      return startEditingToDo(this);
    }
    return orElse();
  }
}

abstract class StartEditingToDoAction implements TLToDoAction {
  const factory StartEditingToDoAction(
      {required final String categoryId,
      required final String? smallCategoryId,
      required final int indexOfEditingToDo,
      required final bool ifInToday}) = _$StartEditingToDoActionImpl;

  String get categoryId;
  String? get smallCategoryId;
  int get indexOfEditingToDo;
  bool get ifInToday;

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StartEditingToDoActionImplCopyWith<_$StartEditingToDoActionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateToDoTitleActionImplCopyWith<$Res> {
  factory _$$UpdateToDoTitleActionImplCopyWith(
          _$UpdateToDoTitleActionImpl value,
          $Res Function(_$UpdateToDoTitleActionImpl) then) =
      __$$UpdateToDoTitleActionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String newTitle});
}

/// @nodoc
class __$$UpdateToDoTitleActionImplCopyWithImpl<$Res>
    extends _$TLToDoActionCopyWithImpl<$Res, _$UpdateToDoTitleActionImpl>
    implements _$$UpdateToDoTitleActionImplCopyWith<$Res> {
  __$$UpdateToDoTitleActionImplCopyWithImpl(_$UpdateToDoTitleActionImpl _value,
      $Res Function(_$UpdateToDoTitleActionImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newTitle = null,
  }) {
    return _then(_$UpdateToDoTitleActionImpl(
      newTitle: null == newTitle
          ? _value.newTitle
          : newTitle // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UpdateToDoTitleActionImpl implements UpdateToDoTitleAction {
  const _$UpdateToDoTitleActionImpl({required this.newTitle});

  @override
  final String newTitle;

  @override
  String toString() {
    return 'TLToDoAction.updateToDoTitle(newTitle: $newTitle)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateToDoTitleActionImpl &&
            (identical(other.newTitle, newTitle) ||
                other.newTitle == newTitle));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newTitle);

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateToDoTitleActionImplCopyWith<_$UpdateToDoTitleActionImpl>
      get copyWith => __$$UpdateToDoTitleActionImplCopyWithImpl<
          _$UpdateToDoTitleActionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String categoryId, String? smallCategoryId,
            int indexOfEditingToDo, bool ifInToday)
        startEditingToDo,
    required TResult Function(String newTitle) updateToDoTitle,
    required TResult Function(String stepTitle) addStep,
    required TResult Function() completeEditing,
    required TResult Function() resetEditingToDo,
  }) {
    return updateToDoTitle(newTitle);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String categoryId, String? smallCategoryId,
            int indexOfEditingToDo, bool ifInToday)?
        startEditingToDo,
    TResult? Function(String newTitle)? updateToDoTitle,
    TResult? Function(String stepTitle)? addStep,
    TResult? Function()? completeEditing,
    TResult? Function()? resetEditingToDo,
  }) {
    return updateToDoTitle?.call(newTitle);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String categoryId, String? smallCategoryId,
            int indexOfEditingToDo, bool ifInToday)?
        startEditingToDo,
    TResult Function(String newTitle)? updateToDoTitle,
    TResult Function(String stepTitle)? addStep,
    TResult Function()? completeEditing,
    TResult Function()? resetEditingToDo,
    required TResult orElse(),
  }) {
    if (updateToDoTitle != null) {
      return updateToDoTitle(newTitle);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StartEditingToDoAction value) startEditingToDo,
    required TResult Function(UpdateToDoTitleAction value) updateToDoTitle,
    required TResult Function(AddStepAction value) addStep,
    required TResult Function(CompleteEditingToDoAction value) completeEditing,
    required TResult Function(ResetEditingToDoAction value) resetEditingToDo,
  }) {
    return updateToDoTitle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StartEditingToDoAction value)? startEditingToDo,
    TResult? Function(UpdateToDoTitleAction value)? updateToDoTitle,
    TResult? Function(AddStepAction value)? addStep,
    TResult? Function(CompleteEditingToDoAction value)? completeEditing,
    TResult? Function(ResetEditingToDoAction value)? resetEditingToDo,
  }) {
    return updateToDoTitle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StartEditingToDoAction value)? startEditingToDo,
    TResult Function(UpdateToDoTitleAction value)? updateToDoTitle,
    TResult Function(AddStepAction value)? addStep,
    TResult Function(CompleteEditingToDoAction value)? completeEditing,
    TResult Function(ResetEditingToDoAction value)? resetEditingToDo,
    required TResult orElse(),
  }) {
    if (updateToDoTitle != null) {
      return updateToDoTitle(this);
    }
    return orElse();
  }
}

abstract class UpdateToDoTitleAction implements TLToDoAction {
  const factory UpdateToDoTitleAction({required final String newTitle}) =
      _$UpdateToDoTitleActionImpl;

  String get newTitle;

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateToDoTitleActionImplCopyWith<_$UpdateToDoTitleActionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddStepActionImplCopyWith<$Res> {
  factory _$$AddStepActionImplCopyWith(
          _$AddStepActionImpl value, $Res Function(_$AddStepActionImpl) then) =
      __$$AddStepActionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String stepTitle});
}

/// @nodoc
class __$$AddStepActionImplCopyWithImpl<$Res>
    extends _$TLToDoActionCopyWithImpl<$Res, _$AddStepActionImpl>
    implements _$$AddStepActionImplCopyWith<$Res> {
  __$$AddStepActionImplCopyWithImpl(
      _$AddStepActionImpl _value, $Res Function(_$AddStepActionImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stepTitle = null,
  }) {
    return _then(_$AddStepActionImpl(
      stepTitle: null == stepTitle
          ? _value.stepTitle
          : stepTitle // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AddStepActionImpl implements AddStepAction {
  const _$AddStepActionImpl({required this.stepTitle});

  @override
  final String stepTitle;

  @override
  String toString() {
    return 'TLToDoAction.addStep(stepTitle: $stepTitle)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddStepActionImpl &&
            (identical(other.stepTitle, stepTitle) ||
                other.stepTitle == stepTitle));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stepTitle);

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddStepActionImplCopyWith<_$AddStepActionImpl> get copyWith =>
      __$$AddStepActionImplCopyWithImpl<_$AddStepActionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String categoryId, String? smallCategoryId,
            int indexOfEditingToDo, bool ifInToday)
        startEditingToDo,
    required TResult Function(String newTitle) updateToDoTitle,
    required TResult Function(String stepTitle) addStep,
    required TResult Function() completeEditing,
    required TResult Function() resetEditingToDo,
  }) {
    return addStep(stepTitle);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String categoryId, String? smallCategoryId,
            int indexOfEditingToDo, bool ifInToday)?
        startEditingToDo,
    TResult? Function(String newTitle)? updateToDoTitle,
    TResult? Function(String stepTitle)? addStep,
    TResult? Function()? completeEditing,
    TResult? Function()? resetEditingToDo,
  }) {
    return addStep?.call(stepTitle);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String categoryId, String? smallCategoryId,
            int indexOfEditingToDo, bool ifInToday)?
        startEditingToDo,
    TResult Function(String newTitle)? updateToDoTitle,
    TResult Function(String stepTitle)? addStep,
    TResult Function()? completeEditing,
    TResult Function()? resetEditingToDo,
    required TResult orElse(),
  }) {
    if (addStep != null) {
      return addStep(stepTitle);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StartEditingToDoAction value) startEditingToDo,
    required TResult Function(UpdateToDoTitleAction value) updateToDoTitle,
    required TResult Function(AddStepAction value) addStep,
    required TResult Function(CompleteEditingToDoAction value) completeEditing,
    required TResult Function(ResetEditingToDoAction value) resetEditingToDo,
  }) {
    return addStep(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StartEditingToDoAction value)? startEditingToDo,
    TResult? Function(UpdateToDoTitleAction value)? updateToDoTitle,
    TResult? Function(AddStepAction value)? addStep,
    TResult? Function(CompleteEditingToDoAction value)? completeEditing,
    TResult? Function(ResetEditingToDoAction value)? resetEditingToDo,
  }) {
    return addStep?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StartEditingToDoAction value)? startEditingToDo,
    TResult Function(UpdateToDoTitleAction value)? updateToDoTitle,
    TResult Function(AddStepAction value)? addStep,
    TResult Function(CompleteEditingToDoAction value)? completeEditing,
    TResult Function(ResetEditingToDoAction value)? resetEditingToDo,
    required TResult orElse(),
  }) {
    if (addStep != null) {
      return addStep(this);
    }
    return orElse();
  }
}

abstract class AddStepAction implements TLToDoAction {
  const factory AddStepAction({required final String stepTitle}) =
      _$AddStepActionImpl;

  String get stepTitle;

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddStepActionImplCopyWith<_$AddStepActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CompleteEditingToDoActionImplCopyWith<$Res> {
  factory _$$CompleteEditingToDoActionImplCopyWith(
          _$CompleteEditingToDoActionImpl value,
          $Res Function(_$CompleteEditingToDoActionImpl) then) =
      __$$CompleteEditingToDoActionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CompleteEditingToDoActionImplCopyWithImpl<$Res>
    extends _$TLToDoActionCopyWithImpl<$Res, _$CompleteEditingToDoActionImpl>
    implements _$$CompleteEditingToDoActionImplCopyWith<$Res> {
  __$$CompleteEditingToDoActionImplCopyWithImpl(
      _$CompleteEditingToDoActionImpl _value,
      $Res Function(_$CompleteEditingToDoActionImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CompleteEditingToDoActionImpl implements CompleteEditingToDoAction {
  const _$CompleteEditingToDoActionImpl();

  @override
  String toString() {
    return 'TLToDoAction.completeEditing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompleteEditingToDoActionImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String categoryId, String? smallCategoryId,
            int indexOfEditingToDo, bool ifInToday)
        startEditingToDo,
    required TResult Function(String newTitle) updateToDoTitle,
    required TResult Function(String stepTitle) addStep,
    required TResult Function() completeEditing,
    required TResult Function() resetEditingToDo,
  }) {
    return completeEditing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String categoryId, String? smallCategoryId,
            int indexOfEditingToDo, bool ifInToday)?
        startEditingToDo,
    TResult? Function(String newTitle)? updateToDoTitle,
    TResult? Function(String stepTitle)? addStep,
    TResult? Function()? completeEditing,
    TResult? Function()? resetEditingToDo,
  }) {
    return completeEditing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String categoryId, String? smallCategoryId,
            int indexOfEditingToDo, bool ifInToday)?
        startEditingToDo,
    TResult Function(String newTitle)? updateToDoTitle,
    TResult Function(String stepTitle)? addStep,
    TResult Function()? completeEditing,
    TResult Function()? resetEditingToDo,
    required TResult orElse(),
  }) {
    if (completeEditing != null) {
      return completeEditing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StartEditingToDoAction value) startEditingToDo,
    required TResult Function(UpdateToDoTitleAction value) updateToDoTitle,
    required TResult Function(AddStepAction value) addStep,
    required TResult Function(CompleteEditingToDoAction value) completeEditing,
    required TResult Function(ResetEditingToDoAction value) resetEditingToDo,
  }) {
    return completeEditing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StartEditingToDoAction value)? startEditingToDo,
    TResult? Function(UpdateToDoTitleAction value)? updateToDoTitle,
    TResult? Function(AddStepAction value)? addStep,
    TResult? Function(CompleteEditingToDoAction value)? completeEditing,
    TResult? Function(ResetEditingToDoAction value)? resetEditingToDo,
  }) {
    return completeEditing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StartEditingToDoAction value)? startEditingToDo,
    TResult Function(UpdateToDoTitleAction value)? updateToDoTitle,
    TResult Function(AddStepAction value)? addStep,
    TResult Function(CompleteEditingToDoAction value)? completeEditing,
    TResult Function(ResetEditingToDoAction value)? resetEditingToDo,
    required TResult orElse(),
  }) {
    if (completeEditing != null) {
      return completeEditing(this);
    }
    return orElse();
  }
}

abstract class CompleteEditingToDoAction implements TLToDoAction {
  const factory CompleteEditingToDoAction() = _$CompleteEditingToDoActionImpl;
}

/// @nodoc
abstract class _$$ResetEditingToDoActionImplCopyWith<$Res> {
  factory _$$ResetEditingToDoActionImplCopyWith(
          _$ResetEditingToDoActionImpl value,
          $Res Function(_$ResetEditingToDoActionImpl) then) =
      __$$ResetEditingToDoActionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetEditingToDoActionImplCopyWithImpl<$Res>
    extends _$TLToDoActionCopyWithImpl<$Res, _$ResetEditingToDoActionImpl>
    implements _$$ResetEditingToDoActionImplCopyWith<$Res> {
  __$$ResetEditingToDoActionImplCopyWithImpl(
      _$ResetEditingToDoActionImpl _value,
      $Res Function(_$ResetEditingToDoActionImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLToDoAction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetEditingToDoActionImpl implements ResetEditingToDoAction {
  const _$ResetEditingToDoActionImpl();

  @override
  String toString() {
    return 'TLToDoAction.resetEditingToDo()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetEditingToDoActionImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String categoryId, String? smallCategoryId,
            int indexOfEditingToDo, bool ifInToday)
        startEditingToDo,
    required TResult Function(String newTitle) updateToDoTitle,
    required TResult Function(String stepTitle) addStep,
    required TResult Function() completeEditing,
    required TResult Function() resetEditingToDo,
  }) {
    return resetEditingToDo();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String categoryId, String? smallCategoryId,
            int indexOfEditingToDo, bool ifInToday)?
        startEditingToDo,
    TResult? Function(String newTitle)? updateToDoTitle,
    TResult? Function(String stepTitle)? addStep,
    TResult? Function()? completeEditing,
    TResult? Function()? resetEditingToDo,
  }) {
    return resetEditingToDo?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String categoryId, String? smallCategoryId,
            int indexOfEditingToDo, bool ifInToday)?
        startEditingToDo,
    TResult Function(String newTitle)? updateToDoTitle,
    TResult Function(String stepTitle)? addStep,
    TResult Function()? completeEditing,
    TResult Function()? resetEditingToDo,
    required TResult orElse(),
  }) {
    if (resetEditingToDo != null) {
      return resetEditingToDo();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StartEditingToDoAction value) startEditingToDo,
    required TResult Function(UpdateToDoTitleAction value) updateToDoTitle,
    required TResult Function(AddStepAction value) addStep,
    required TResult Function(CompleteEditingToDoAction value) completeEditing,
    required TResult Function(ResetEditingToDoAction value) resetEditingToDo,
  }) {
    return resetEditingToDo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StartEditingToDoAction value)? startEditingToDo,
    TResult? Function(UpdateToDoTitleAction value)? updateToDoTitle,
    TResult? Function(AddStepAction value)? addStep,
    TResult? Function(CompleteEditingToDoAction value)? completeEditing,
    TResult? Function(ResetEditingToDoAction value)? resetEditingToDo,
  }) {
    return resetEditingToDo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StartEditingToDoAction value)? startEditingToDo,
    TResult Function(UpdateToDoTitleAction value)? updateToDoTitle,
    TResult Function(AddStepAction value)? addStep,
    TResult Function(CompleteEditingToDoAction value)? completeEditing,
    TResult Function(ResetEditingToDoAction value)? resetEditingToDo,
    required TResult orElse(),
  }) {
    if (resetEditingToDo != null) {
      return resetEditingToDo(this);
    }
    return orElse();
  }
}

abstract class ResetEditingToDoAction implements TLToDoAction {
  const factory ResetEditingToDoAction() = _$ResetEditingToDoActionImpl;
}
