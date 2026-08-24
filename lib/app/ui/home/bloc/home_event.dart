import 'package:base/app/app.dart';
import 'package:base/domain/domain.dart';

abstract class HomeEvent extends BaseEvent {}

class HomeEventInitial extends HomeEvent {
  HomeEventInitial();
}

class HomeEventLoadDocument extends HomeEvent {
  HomeEventLoadDocument();
}

class HomeEventFilterDocument extends HomeEvent {
  HomeEventFilterDocument();
}

class HomeEventSearchTextChange extends HomeEvent {
  HomeEventSearchTextChange({
    required this.value,
  });
  final String value;
}

class HomeEventWareHouseChange extends HomeEvent {
  HomeEventWareHouseChange({
    this.value,
  });
  final String? value;
}

class HomeEventFromDateChange extends HomeEvent {
  HomeEventFromDateChange({
    this.fromDate,
  });
  final DateTime? fromDate;
}

class HomeEventToDateChange extends HomeEvent {
  HomeEventToDateChange({
    this.toDate
  });
  final DateTime? toDate;
}

class HomeEventCreateDocument extends HomeEvent {
  HomeEventCreateDocument({
    this.toDate
  });
  final DateTime? toDate;
}

class HomeEventDeleteReceipt extends HomeEvent {
  HomeEventDeleteReceipt({required this.document});
  final Document document;
}