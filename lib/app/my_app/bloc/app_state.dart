import 'package:base/app/base/bloc/base_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
class AppState extends BaseState with _$AppState {
  
  const factory AppState({
    @Default(false) bool isLoading,
    @Default('') String messenger
  }) = _AppState;
}
