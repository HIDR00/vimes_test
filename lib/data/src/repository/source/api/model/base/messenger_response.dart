import 'package:freezed_annotation/freezed_annotation.dart';

part 'messenger_response.freezed.dart';
part 'messenger_response.g.dart';

@Freezed()
class MessengerResponse with _$MessengerResponse {
  const factory MessengerResponse({
    @JsonKey(name: 'message') String? message,
  }) = _MessengerResponse;

  factory MessengerResponse.fromJson(Map<String, dynamic> json) => _$MessengerResponseFromJson(json);
}
