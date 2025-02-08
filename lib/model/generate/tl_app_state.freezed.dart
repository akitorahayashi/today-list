// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../tl_app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TLAppState _$TLAppStateFromJson(Map<String, dynamic> json) {
  return _TLAppState.fromJson(json);
}

/// @nodoc
mixin _$TLAppState {
  List<TLWorkspace> get tlWorkspaces => throw _privateConstructorUsedError;
  int get currentWorkspaceIndex => throw _privateConstructorUsedError;
  TLThemeType get selectedThemeType => throw _privateConstructorUsedError;

  /// Serializes this TLAppState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TLAppState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TLAppStateCopyWith<TLAppState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TLAppStateCopyWith<$Res> {
  factory $TLAppStateCopyWith(
          TLAppState value, $Res Function(TLAppState) then) =
      _$TLAppStateCopyWithImpl<$Res, TLAppState>;
  @useResult
  $Res call(
      {List<TLWorkspace> tlWorkspaces,
      int currentWorkspaceIndex,
      TLThemeType selectedThemeType});
}

/// @nodoc
class _$TLAppStateCopyWithImpl<$Res, $Val extends TLAppState>
    implements $TLAppStateCopyWith<$Res> {
  _$TLAppStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TLAppState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tlWorkspaces = null,
    Object? currentWorkspaceIndex = null,
    Object? selectedThemeType = null,
  }) {
    return _then(_value.copyWith(
      tlWorkspaces: null == tlWorkspaces
          ? _value.tlWorkspaces
          : tlWorkspaces // ignore: cast_nullable_to_non_nullable
              as List<TLWorkspace>,
      currentWorkspaceIndex: null == currentWorkspaceIndex
          ? _value.currentWorkspaceIndex
          : currentWorkspaceIndex // ignore: cast_nullable_to_non_nullable
              as int,
      selectedThemeType: null == selectedThemeType
          ? _value.selectedThemeType
          : selectedThemeType // ignore: cast_nullable_to_non_nullable
              as TLThemeType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TLAppStateImplCopyWith<$Res>
    implements $TLAppStateCopyWith<$Res> {
  factory _$$TLAppStateImplCopyWith(
          _$TLAppStateImpl value, $Res Function(_$TLAppStateImpl) then) =
      __$$TLAppStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TLWorkspace> tlWorkspaces,
      int currentWorkspaceIndex,
      TLThemeType selectedThemeType});
}

/// @nodoc
class __$$TLAppStateImplCopyWithImpl<$Res>
    extends _$TLAppStateCopyWithImpl<$Res, _$TLAppStateImpl>
    implements _$$TLAppStateImplCopyWith<$Res> {
  __$$TLAppStateImplCopyWithImpl(
      _$TLAppStateImpl _value, $Res Function(_$TLAppStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TLAppState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tlWorkspaces = null,
    Object? currentWorkspaceIndex = null,
    Object? selectedThemeType = null,
  }) {
    return _then(_$TLAppStateImpl(
      tlWorkspaces: null == tlWorkspaces
          ? _value._tlWorkspaces
          : tlWorkspaces // ignore: cast_nullable_to_non_nullable
              as List<TLWorkspace>,
      currentWorkspaceIndex: null == currentWorkspaceIndex
          ? _value.currentWorkspaceIndex
          : currentWorkspaceIndex // ignore: cast_nullable_to_non_nullable
              as int,
      selectedThemeType: null == selectedThemeType
          ? _value.selectedThemeType
          : selectedThemeType // ignore: cast_nullable_to_non_nullable
              as TLThemeType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TLAppStateImpl implements _TLAppState {
  const _$TLAppStateImpl(
      {final List<TLWorkspace> tlWorkspaces = const [],
      this.currentWorkspaceIndex = 0,
      this.selectedThemeType = TLThemeType.sunOrange})
      : _tlWorkspaces = tlWorkspaces;

  factory _$TLAppStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$TLAppStateImplFromJson(json);

  final List<TLWorkspace> _tlWorkspaces;
  @override
  @JsonKey()
  List<TLWorkspace> get tlWorkspaces {
    if (_tlWorkspaces is EqualUnmodifiableListView) return _tlWorkspaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tlWorkspaces);
  }

  @override
  @JsonKey()
  final int currentWorkspaceIndex;
  @override
  @JsonKey()
  final TLThemeType selectedThemeType;

  @override
  String toString() {
    return 'TLAppState(tlWorkspaces: $tlWorkspaces, currentWorkspaceIndex: $currentWorkspaceIndex, selectedThemeType: $selectedThemeType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TLAppStateImpl &&
            const DeepCollectionEquality()
                .equals(other._tlWorkspaces, _tlWorkspaces) &&
            (identical(other.currentWorkspaceIndex, currentWorkspaceIndex) ||
                other.currentWorkspaceIndex == currentWorkspaceIndex) &&
            (identical(other.selectedThemeType, selectedThemeType) ||
                other.selectedThemeType == selectedThemeType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tlWorkspaces),
      currentWorkspaceIndex,
      selectedThemeType);

  /// Create a copy of TLAppState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TLAppStateImplCopyWith<_$TLAppStateImpl> get copyWith =>
      __$$TLAppStateImplCopyWithImpl<_$TLAppStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TLAppStateImplToJson(
      this,
    );
  }
}

abstract class _TLAppState implements TLAppState {
  const factory _TLAppState(
      {final List<TLWorkspace> tlWorkspaces,
      final int currentWorkspaceIndex,
      final TLThemeType selectedThemeType}) = _$TLAppStateImpl;

  factory _TLAppState.fromJson(Map<String, dynamic> json) =
      _$TLAppStateImpl.fromJson;

  @override
  List<TLWorkspace> get tlWorkspaces;
  @override
  int get currentWorkspaceIndex;
  @override
  TLThemeType get selectedThemeType;

  /// Create a copy of TLAppState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TLAppStateImplCopyWith<_$TLAppStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
