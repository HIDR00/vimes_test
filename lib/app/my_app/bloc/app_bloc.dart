import 'package:base/app/base/bloc/base_bloc.dart';
import 'package:base/app/my_app/bloc/app_event.dart';
import 'package:base/app/my_app/bloc/app_state.dart';
import 'package:base/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class AppBloc extends BaseBloc<AppEvent, AppState> {
  AppBloc(this._repository) : super(AppState()) {
    on<AppEventInitial>(_appInitial);
  }

  final Repository _repository;

  Future<void> _appInitial(AppEventInitial event, Emitter<AppState> emit) async {
    final output = await _repository.ping();
    emit(state.copyWith(messenger: output));
  }
}
