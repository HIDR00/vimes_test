import 'package:base/data/src/repository/source/api/mapper/base/base_success_response_mapper.dart';
import 'package:base/data/src/repository/source/api/model/base/data_response.dart';
import 'package:base/shared/src/model/typedef.dart';

class DataJsonObjectResponseMapper<T extends Object> extends BaseSuccessResponseMapper<T, DataResponse> {
  @override
  DataResponse<T>? mapToDataModel({required response, Decoder<T>? decoder}) {
    return decoder != null && response is Map<String, dynamic>
        ? DataResponse.fromJson(response, (json) => decoder(json))
        : null;
  }
}
