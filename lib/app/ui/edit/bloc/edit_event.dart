import 'dart:async';

import 'package:base/app/app.dart';
import 'package:base/app/ui/home/bloc/home.dart';

abstract class EditEvent extends BaseEvent {}

class EditEventInitial extends EditEvent {
  EditEventInitial();
}

class EditEventSaveDocument extends EditEvent {
  EditEventSaveDocument(this.document, this.completer);

  final Document document;
  final Completer<void> completer;
}
