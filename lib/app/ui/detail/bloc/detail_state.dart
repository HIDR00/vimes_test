import 'package:base/app/app.dart';
import 'package:base/domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_state.freezed.dart';

@freezed
class DetailState extends BaseState with _$DetailState {
  const factory DetailState({
    @Default(false) bool isLoading,
    @Default('') String messenger,
    Document? document
  }) = _DetailState;
}