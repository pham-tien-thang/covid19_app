part of 'favorite_bloc.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}
class FavoriteLoadingState extends FavoriteState {}
class FavoriteLoadingFailState extends FavoriteState {}
class FavoriteLoadingSuccessState extends FavoriteState
{
  List<FavoriteCountry>? listCountry;
  FavoriteLoadingSuccessState({this.listCountry});
}
class DeleteFavoriteSuccessState extends FavoriteState {
  String? name;
  DeleteFavoriteSuccessState({this.name});
}
class DeleteFavoriteFailState extends FavoriteState {
  String? error;
  DeleteFavoriteFailState({this.error});
}