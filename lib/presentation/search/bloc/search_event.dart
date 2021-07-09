part of 'search_bloc.dart';

abstract class SearchEvent {}
class OnSearchEvent extends SearchEvent {
  String? query;
  OnSearchEvent({this.query}) ;
}
class LoadSearchEvent extends SearchEvent {
}
class AddFavoriteEvent extends SearchEvent {
  Country? country;
  AddFavoriteEvent({this.country}) ;
}