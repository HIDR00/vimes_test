// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'messenger_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MessengerResponse _$MessengerResponseFromJson(Map<String, dynamic> json) {
  return _MessengerResponse.fromJson(json);
}

/// @nodoc
mixin _$MessengerResponse {
  @JsonKey(name: 'message')
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this MessengerResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessengerResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessengerResponseCopyWith<MessengerResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessengerResponseCopyWith<$Res> {
  factory $MessengerResponseCopyWith(
          MessengerResponse value, $Res Function(MessengerResponse) then) =
      _$MessengerResponseCopyWithImpl<$Res, MessengerResponse>;
  @useResult
  $Res call({@JsonKey(name: 'message') String? message});
}

/// @nodoc
class _$MessengerResponseCopyWithImpl<$Res, $Val extends MessengerResponse>
    implements $MessengerResponseCopyWith<$Res> {
  _$MessengerResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessengerResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessengerResponseImplCopyWith<$Res>
    implements $MessengerResponseCopyWith<$Res> {
  factory _$$MessengerResponseImplCopyWith(_$MessengerResponseImpl value,
          $Res Function(_$MessengerResponseImpl) then) =
      __$$MessengerResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'message') String? message});
}

/// @nodoc
class __$$MessengerResponseImplCopyWithImpl<$Res>
    extends _$MessengerResponseCopyWithImpl<$Res, _$MessengerResponseImpl>
    implements _$$MessengerResponseImplCopyWith<$Res> {
  __$$MessengerResponseImplCopyWithImpl(_$MessengerResponseImpl _value,
      $Res Function(_$MessengerResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessengerResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$MessengerResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessengerResponseImpl implements _MessengerResponse {
  const _$MessengerResponseImpl({@JsonKey(name: 'message') this.message});

  factory _$MessengerResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessengerResponseImplFromJson(json);

  @override
  @JsonKey(name: 'message')
  final String? message;

  @override
  String toString() {
    return 'MessengerResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessengerResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of MessengerResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessengerResponseImplCopyWith<_$MessengerResponseImpl> get copyWith =>
      __$$MessengerResponseImplCopyWithImpl<_$MessengerResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessengerResponseImplToJson(
      this,
    );
  }
}

abstract class _MessengerResponse implements MessengerResponse {
  const factory _MessengerResponse(
          {@JsonKey(name: 'message') final String? message}) =
      _$MessengerResponseImpl;

  factory _MessengerResponse.fromJson(Map<String, dynamic> json) =
      _$MessengerResponseImpl.fromJson;

  @override
  @JsonKey(name: 'message')
  String? get message;

  /// Create a copy of MessengerResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessengerResponseImplCopyWith<_$MessengerResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
