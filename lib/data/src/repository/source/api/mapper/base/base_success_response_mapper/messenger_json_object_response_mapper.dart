import 'package:base/data/data.dart';
import 'package:base/shared/src/model/typedef.dart';

class MessengerJsonObjectResponseMapper extends BaseSuccessResponseMapper<MessengerResponse,MessengerResponse> {
  MessengerJsonObjectResponseMapper();

  @override
  MessengerResponse? mapToDataModel({required response, Decoder<MessengerResponse>? decoder}) {
    return decoder != null && response is Map<String, dynamic>
        ? decoder(response)
        : null;
  }
}