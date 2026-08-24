import 'package:base/app/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'home.dart';

@Injectable()
class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc(this._repository) : super(HomeState()) {
    on<HomeEventInitial>(_homeInitial);
    on<HomeEventLoadDocument>(_homeEventLoadDocument);
    on<HomeEventFilterDocument>(_homeEventFilterDocument);
    on<HomeEventSearchTextChange>(_homeEventSearchTextChange);
    on<HomeEventWareHouseChange>(_homeEventWareHouseChange);
    on<HomeEventFromDateChange>(_homeEventFromDateChange);
    on<HomeEventToDateChange>(_homeEventToDateChange);
    on<HomeEventDeleteReceipt>(_homeEventDeleteReceipt);
  }

  final Repository _repository;

  Future<void> _homeInitial(
    HomeEventInitial event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    add(HomeEventLoadDocument());
  }

  Future<void> _homeEventLoadDocument(
    HomeEventLoadDocument event,
    Emitter<HomeState> emit,
  ) async {
    final documents = await _repository.getImportReceipts();
    emit(
      state.copyWith(
        isLoading: false,
        lDocument: documents,
        lFilterDocument: documents,
        warehouses: getWarehouses(documents),
        totalItem: getTotalItem(documents),
      ),
    );
  }

  Future<void> _homeEventFilterDocument(
    HomeEventFilterDocument event,
    Emitter<HomeState> emit,
  ) async {
    final documents = filterDocument(
      keyword: state.searchText,
      warehouse: state.selectedWarehouse,
      fromDate: state.fromDate,
      toDate: state.toDate,
    );

    emit(
      state.copyWith(
        lFilterDocument: documents,
      ),
    );
  }

  List<Document> filterDocument({
    String keyword = '',
    String? warehouse,
    DateTime? fromDate,
    DateTime? toDate,
  }) {
    final searchText = keyword.trim().toLowerCase();

    return state.lDocument.where((document) {
      final matchesSearch = searchText.isEmpty ||
          document.number.toLowerCase().contains(searchText) ||
          document.deliverer.toLowerCase().contains(searchText) ||
          document.reference.toLowerCase().contains(searchText) ||
          document.warehouse.toLowerCase().contains(searchText) ||
          document.items.any((item) {
            return item.name.toLowerCase().contains(searchText) ||
                item.code.toLowerCase().contains(searchText);
          });

      final matchesWarehouse =
          warehouse == null || document.warehouse == warehouse;
      final matchesFromDate = fromDate == null ||
          !_dateOnly(document.createdDate).isBefore(_dateOnly(fromDate));
      final matchesToDate = toDate == null ||
          !_dateOnly(document.createdDate).isAfter(_dateOnly(toDate));

      return matchesSearch &&
          matchesWarehouse &&
          matchesFromDate &&
          matchesToDate;
    }).toList();
  }

  List<String> getWarehouses(List<Document> lDocument) {
    final warehouses = lDocument
        .map((document) => document.warehouse.trim())
        .where((warehouse) => warehouse.isNotEmpty)
        .toSet()
        .toList();
    warehouses.sort();
    return warehouses;
  }

  int getTotalItem(List<Document> documents) {
    return documents.fold<int>(
      0,
      (sum, document) => sum + document.items.length,
    );
  }

  DateTime _dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  Future<void> _homeEventSearchTextChange(
    HomeEventSearchTextChange event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(searchText: event.value));
    add(HomeEventFilterDocument());
  }

  Future<void> _homeEventWareHouseChange(
    HomeEventWareHouseChange event,
    Emitter<HomeState> emit,
  ) async {
    final warehouse = event.value?.trim();
    emit(
      state.copyWith(
        selectedWarehouse:
            warehouse == null || warehouse.isEmpty ? null : warehouse,
      ),
    );
  }

  Future<void> _homeEventFromDateChange(
    HomeEventFromDateChange event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(fromDate: event.fromDate));
  }

  Future<void> _homeEventToDateChange(
    HomeEventToDateChange event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(toDate: event.toDate));
  }

  Future<void> _homeEventDeleteReceipt(
    HomeEventDeleteReceipt event,
    Emitter<HomeState> emit,
  ) async {
    await _repository.deleteImportReceipt(event.document);
    add(HomeEventInitial());
  }
}
