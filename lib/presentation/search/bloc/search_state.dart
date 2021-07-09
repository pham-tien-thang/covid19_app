part of 'search_bloc.dart';

abstract class SearchState {

}
class SearchInitial extends SearchState {
}
class SearchSuccessState extends SearchState {
  List<Country>? listCountry;
  SearchSuccessState({this.listCountry});
}
class SearchLoadingState extends SearchState {}
class SearchFailState extends SearchState {}
class SearchResult extends SearchState
{
  List<Country>? listCountry;
  SearchResult({this.listCountry});
}
class AddFavoriteSuccessState extends SearchState
{
String? name;
AddFavoriteSuccessState({this.name});
}
class AddFavoriteFailState extends SearchState
{
  String? error;
  AddFavoriteFailState({this.error});
}
