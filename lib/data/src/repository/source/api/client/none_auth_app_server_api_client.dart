import 'package:base/data/data.dart';
import 'package:base/shared/shared.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class NoneAuthAppServerApiClient extends RestApiClient {
  NoneAuthAppServerApiClient() : super(
    dio: DioBuilder.createDio(
      options: BaseOptions(baseUrl: EnvConstants.appApiUrl),
      interceptor: [

      ]
    )
  );
}