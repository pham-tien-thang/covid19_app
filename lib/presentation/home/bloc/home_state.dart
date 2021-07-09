part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeSuccessState extends HomeState {
  World? world;
  HomeSuccessState({this.world});
}

class HomeLoadingState extends HomeState {}

class HomeFailState extends HomeState {}

class ChartState extends HomeState {
  final List? date;
  final List<Spot>? spotCases;
  final List<Spot>? spotRecovered;
  final List<Spot>? spotDeaths;
  ChartState({this.spotCases, this.spotDeaths, this.spotRecovered,this.date});
}
