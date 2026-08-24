// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EditState {
  bool get isLoading => throw _privateConstructorUsedError;
  String get messenger => throw _privateConstructorUsedError;
  bool get isSave => throw _privateConstructorUsedError;

  /// Create a copy of EditState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EditStateCopyWith<EditState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditStateCopyWith<$Res> {
  factory $EditStateCopyWith(EditState value, $Res Function(EditState) then) =
      _$EditStateCopyWithImpl<$Res, EditState>;
  @useResult
  $Res call({bool isLoading, String messenger, bool isSave});
}

/// @nodoc
class _$EditStateCopyWithImpl<$Res, $Val extends EditState>
    implements $EditStateCopyWith<$Res> {
  _$EditStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? messenger = null,
    Object? isSave = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      messenger: null == messenger
          ? _value.messenger
          : messenger // ignore: cast_nullable_to_non_nullable
              as String,
      isSave: null == isSave
          ? _value.isSave
          : isSave // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EditStateImplCopyWith<$Res>
    implements $EditStateCopyWith<$Res> {
  factory _$$EditStateImplCopyWith(
          _$EditStateImpl value, $Res Function(_$EditStateImpl) then) =
      __$$EditStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, String messenger, bool isSave});
}

/// @nodoc
class __$$EditStateImplCopyWithImpl<$Res>
    extends _$EditStateCopyWithImpl<$Res, _$EditStateImpl>
    implements _$$EditStateImplCopyWith<$Res> {
  __$$EditStateImplCopyWithImpl(
      _$EditStateImpl _value, $Res Function(_$EditStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? messenger = null,
    Object? isSave = null,
  }) {
    return _then(_$EditStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      messenger: null == messenger
          ? _value.messenger
          : messenger // ignore: cast_nullable_to_non_nullable
              as String,
      isSave: null == isSave
          ? _value.isSave
          : isSave // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$EditStateImpl implements _EditState {
  const _$EditStateImpl(
      {this.isLoading = false, this.messenger = '', this.isSave = false});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final String messenger;
  @override
  @JsonKey()
  final bool isSave;

  @override
  String toString() {
    return 'EditState(isLoading: $isLoading, messenger: $messenger, isSave: $isSave)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.messenger, messenger) ||
                other.messenger == messenger) &&
            (identical(other.isSave, isSave) || other.isSave == isSave));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, messenger, isSave);

  /// Create a copy of EditState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditStateImplCopyWith<_$EditStateImpl> get copyWith =>
      __$$EditStateImplCopyWithImpl<_$EditStateImpl>(this, _$identity);
}

abstract class _EditState implements EditState {
  const factory _EditState(
      {final bool isLoading,
      final String messenger,
      final bool isSave}) = _$EditStateImpl;

  @override
  bool get isLoading;
  @override
  String get messenger;
  @override
  bool get isSave;

  /// Create a copy of EditState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditStateImplCopyWith<_$EditStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
