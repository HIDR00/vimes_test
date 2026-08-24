import 'package:base/data/data.dart';
import 'package:base/data/src/repository/source/api/mapper/base/base_success_response_mapper/messenger_json_object_response_mapper.dart';
import 'package:base/shared/shared.dart';

enum SuccessResponseMapperType {
  dataJsonObject,
  messengerJsonObject
}

abstract class BaseSuccessResponseMapper<I extends Object, O extends Object> {
  const BaseSuccessResponseMapper();

  factory BaseSuccessResponseMapper.fromType(SuccessResponseMapperType type) {
    return switch (type) {
      SuccessResponseMapperType.dataJsonObject => DataJsonObjectResponseMapper<I>() as BaseSuccessResponseMapper<I, O>,
      SuccessResponseMapperType.messengerJsonObject => MessengerJsonObjectResponseMapper() as BaseSuccessResponseMapper<I,O>
    };
  }

  O? map({required dynamic response, Decoder<I>? decoder}) {
    return mapToDataModel(response: response, decoder: decoder);
  }

  O? mapToDataModel({required dynamic response, Decoder<I>? decoder});
}
