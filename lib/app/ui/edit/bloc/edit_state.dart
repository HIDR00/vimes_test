import 'package:base/app/app.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_state.freezed.dart';

@freezed
class EditState extends BaseState with _$EditState {
  const factory EditState({
    @Default(false) bool isLoading,
    @Default('') String messenger,
    @Default(false) bool isSave,
  }) = _EditState;
}