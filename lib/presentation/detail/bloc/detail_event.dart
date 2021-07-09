part of 'detail_bloc.dart';

abstract class DetailEvent {}

class AddFavoriteEventFromDetail extends DetailEvent {
  Country? country;
  AddFavoriteEventFromDetail({this.country});
}
