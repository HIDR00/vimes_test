import 'package:base/app/app.dart';
import 'package:base/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'detail.dart';

@Injectable()
class DetailBloc extends BaseBloc<DetailEvent, DetailState> {
  DetailBloc(this._repository) : super(DetailState()) {
     on<DetailEventInit>(_detailEventInit);
    on<DetailEventDeleteReceipt>(_detailEventDeleteReceipt);
    on<DetailEventGetDetail>(_detailEventGetDetail);
  }

  final Repository _repository;

  Future<void> _detailEventInit(
    DetailEventInit event,
    Emitter<DetailState> emit,
  ) async {
    emit(state.copyWith(document: event.document));
  }

  Future<void> _detailEventDeleteReceipt(
    DetailEventDeleteReceipt event,
    Emitter<DetailState> emit,
  ) async {
    await _repository.deleteImportReceipt(event.document);
    // emit(state.copyWith(messenger: output));
  }

  Future<void> _detailEventGetDetail(
    DetailEventGetDetail event,
    Emitter<DetailState> emit,
  ) async {
    final output = await _repository.getImportReceiptById(event.id);
    emit(state.copyWith(document: output));
  }
}
