import 'package:base/app/app.dart';
import 'package:base/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'Edit.dart';

@Injectable()
class EditBloc extends BaseBloc<EditEvent, EditState> {
  EditBloc(this._repository) : super(EditState()) {
    on<EditEventInitial>(_editInitial);
    on<EditEventSaveDocument>(_editEventSaveDocument);
  }

  final Repository _repository;

  Future<void> _editInitial(
    EditEventInitial event,
    Emitter<EditState> emit,
  ) async {
    // final output = await _repository.ping();
    // emit(state.copyWith(messenger: output));
  }

  Future<void> _editEventSaveDocument(
    EditEventSaveDocument event,
    Emitter<EditState> emit,
  ) async {
    try {
      if (event.document.id == null) {
        await _repository.createImportReceipt(event.document);
      } else {
        await _repository.updateImportReceipt(event.document);
      }
      event.completer.complete();
    } catch (error, stackTrace) {
      event.completer.completeError(error, stackTrace);
    }
  }
}
