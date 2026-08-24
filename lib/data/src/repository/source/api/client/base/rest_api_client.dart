import 'package:base/data/src/repository/source/api/mapper/base/base_success_response_mapper.dart';
import 'package:base/shared/shared.dart';
import 'package:dio/dio.dart';

enum RestMethod { get, post, put, patch, delete }

class RestApiClient {
  RestApiClient({required this.dio});

  final Dio dio;

  Future<T?> request<D extends Object, T extends Object>(
      {required RestMethod method,
      required String path,
      Object? body,
      Map<String, dynamic>? queryParameters,
      Decoder<D>? decoder,
      SuccessResponseMapperType? successResponseMapperType}) async {
    final response = await _requestByMethod(method: method, path: path);
    return BaseSuccessResponseMapper<D, T>.fromType(
            successResponseMapperType ?? SuccessResponseMapperType.dataJsonObject)
        .map(response: response.data, decoder: decoder);
  }

  Future<Response<dynamic>> _requestByMethod(
      {required RestMethod method, required String path, Object? body, Map<String, dynamic>? queryParameters}) {
    switch (method) {
      case RestMethod.get:
        return dio.get(path, data: body, queryParameters: queryParameters);
      case RestMethod.post:
        return dio.post(path, data: body, queryParameters: queryParameters);
      case RestMethod.put:
        return dio.put(path, data: body, queryParameters: queryParameters);
      case RestMethod.patch:
        return dio.patch(path, data: body, queryParameters: queryParameters);
      case RestMethod.delete:
        return dio.delete(path, data: body, queryParameters: queryParameters);
    }
  }
}
