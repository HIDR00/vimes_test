import 'package:base/app/app.dart';
import 'package:base/domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState extends BaseState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    @Default('') String messenger,
    @Default(<Document>[]) List<Document> lDocument,
    @Default(<Document>[]) List<Document> lFilterDocument,
    @Default(<String>[]) List<String> warehouses,
    @Default(0) int totalItem,
    String? selectedWarehouse,
    @Default('') String searchText,
    DateTime? fromDate,
    DateTime? toDate,
  }) = _HomeState;
}
