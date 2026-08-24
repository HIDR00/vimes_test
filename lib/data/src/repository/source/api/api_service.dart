import 'package:base/data/data.dart';
import 'package:base/data/src/repository/source/api/client/none_auth_app_server_api_client.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class ApiService {
  ApiService(this._noneAuthAppServerApiClient);

  final NoneAuthAppServerApiClient _noneAuthAppServerApiClient;

  Future<MessengerResponse?> ping() async {
    return _noneAuthAppServerApiClient.request(
        method: RestMethod.get,
        path: '/ping',
        successResponseMapperType: SuccessResponseMapperType.messengerJsonObject,
        decoder: (data) => MessengerResponse.fromJson(data as Map<String, dynamic>));
  }
}
