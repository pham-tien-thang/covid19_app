part of 'favorite_bloc.dart';

abstract class FavoriteEvent {}
class LoadFavoriteEvent extends FavoriteEvent {
}
class DeleteFavoriteEvent extends FavoriteEvent {
  String? countryName;
  DeleteFavoriteEvent({this.countryName});
}

