part of 'detail_bloc.dart';

abstract class DetailState {}

class DetailInitial extends DetailState {}

class AddFavoriteSuccessStateFromDetail extends DetailState {
  String? name;
  AddFavoriteSuccessStateFromDetail({this.name});
}

class AddFavoriteFailStateFromDetail extends DetailState {
  String? error;
  AddFavoriteFailStateFromDetail({this.error});
}
