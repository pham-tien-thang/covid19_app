part of 'detail_favorite_bloc.dart';

abstract class DetailFavoriteEvent {}

class LoadDetailFavoriteEvent extends DetailFavoriteEvent {
  String? api;
  LoadDetailFavoriteEvent({this.api});
}
