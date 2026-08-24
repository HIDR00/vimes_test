import 'package:base/app/app.dart';
import 'package:base/app/ui/home/bloc/home.dart';

abstract class DetailEvent extends BaseEvent {}

class DetailEventDeleteReceipt extends DetailEvent {
  DetailEventDeleteReceipt({required this.document});
  final Document document;
}

class DetailEventInit extends DetailEvent {
  DetailEventInit(this.document);
  final Document? document;
}

class DetailEventGetDetail extends DetailEvent {
  DetailEventGetDetail({required this.id});
  final String id;
}


