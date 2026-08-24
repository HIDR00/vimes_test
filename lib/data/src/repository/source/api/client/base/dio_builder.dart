import 'package:base/shared/shared.dart';
import 'package:dio/dio.dart';

class DioBuilder {
  DioBuilder._();

  static Dio createDio({BaseOptions? options, List<Interceptor> interceptor = const []}) {
    final dio = Dio(BaseOptions(
      baseUrl: options?.baseUrl ?? EnvConstants.appApiUrl,
    ));

    final sortedInterceptors = [...interceptor];

    dio.interceptors.addAll(sortedInterceptors);
    return dio;
  }
}
