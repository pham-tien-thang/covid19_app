part of 'detail_favorite_bloc.dart';

abstract class DetailFavoriteState {}

class DetailFavoriteInitial extends DetailFavoriteState {}

class LoadingDetailFavoriteState extends DetailFavoriteState {}

class LoadDetailFavoriteSuccessState extends DetailFavoriteState {
  Country? country;
  LoadDetailFavoriteSuccessState({this.country});
}

class LoadDetailFavoriteFailState extends DetailFavoriteState {}
