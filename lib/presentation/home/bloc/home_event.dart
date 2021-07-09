part of 'home_bloc.dart';

abstract class HomeEvent {}

class LoadingHomeEvent extends HomeEvent {}

class ChangeChartEvent extends HomeEvent {
  bool? status;
  ChangeChartEvent(this.status);
}
