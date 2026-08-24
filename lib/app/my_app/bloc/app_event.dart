import 'package:base/app/base/bloc/base_event.dart';

abstract class AppEvent extends BaseEvent {}

class AppEventInitial extends AppEvent {
  AppEventInitial();
}
