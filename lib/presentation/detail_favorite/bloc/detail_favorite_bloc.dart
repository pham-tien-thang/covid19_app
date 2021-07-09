import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid19_app/data/model/country_response.dart';
import 'package:covid19_app/domain/usescase/covid_usescase.dart';

part 'detail_favorite_event.dart';
part 'detail_favorite_state.dart';

class DetailFavoriteBloc
    extends Bloc<DetailFavoriteEvent, DetailFavoriteState> {
  DetailFavoriteBloc(this.covidUsecase)
      : super(
          DetailFavoriteInitial(),
        );
  final CovidUsescase covidUsecase;
  Country? country;
  @override
  Stream<DetailFavoriteState> mapEventToState(
    DetailFavoriteEvent event,
  ) async* {
    if (event is LoadDetailFavoriteEvent) {
      yield LoadingDetailFavoriteState();
      try {
        final reponse = await covidUsecase.getaCountry(event.api!);
        country = reponse;
        yield LoadDetailFavoriteSuccessState(country: country);
      } catch (e) {
        yield LoadDetailFavoriteFailState();
      }
    }
  }
}
