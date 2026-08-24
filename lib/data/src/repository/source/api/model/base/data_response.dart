import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_response.freezed.dart';
part 'data_response.g.dart';

@Freezed(genericArgumentFactories: true)
class DataResponse<T> with _$DataResponse<T> {
  const factory DataResponse({
    @JsonKey(name: 'success') bool? success,
    @JsonKey(name: 'error_code') String? errorCode,
    @JsonKey(name: 'data') T? data,
  }) = _DataResponse<T>;
  
  factory DataResponse.fromJson(Map<String,dynamic> json,T Function(Object?) fromJson) => _$DataResponseFromJson(json,fromJson);
}