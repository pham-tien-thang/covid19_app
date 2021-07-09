import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid19_app/data/utils/database.dart';
import 'package:covid19_app/data/utils/shared_pref_manager.dart';
import 'package:covid19_app/domain/entities/favorite_entity.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc()
      : super(
          FavoriteInitial(),
        );
  DatabaseCovid databaseCovid = DatabaseCovid();

  ///nhan vao mot [FavoriteEvent] neu event la [LoadFavoriteEvent] thi goi ham [_mapLoadFavoriteToState]
  ///neu event la [DeleteFavoriteEvent] thi goi [_mapDeleteFavoriteToState]
  @override
  Stream<FavoriteState> mapEventToState(
    FavoriteEvent event,
  ) async* {
    if (event is LoadFavoriteEvent) {
      yield* _mapLoadFavoriteToState(event);
    } else if (event is DeleteFavoriteEvent) {
      yield* _mapDeleteFavoriteToState(event);
    }
  }

  ///nhan vao [LoadFavoriteEvent] , tra ve [FavoriteLoadingState]
  ///neu load thanh cong tra ve [FavoriteLoadingSuccessState]
  ///neu that bai tra ve [FavoriteLoadingFailState]
  Stream<FavoriteState> _mapLoadFavoriteToState(FavoriteEvent even) async* {
    yield FavoriteLoadingState();
    try {
      var listFavorite = <FavoriteCountry>[];
      listFavorite =
          await databaseCovid.getFavoriteByUsername(sharedPrefs.email!);
      yield FavoriteLoadingSuccessState(listCountry: listFavorite);
    } catch (e) {
      yield FavoriteLoadingFailState();
    }
  }

  //
  Stream<FavoriteState> _mapDeleteFavoriteToState(
      DeleteFavoriteEvent even) async* {
    try {
      int delete;
      delete = await databaseCovid.deleteFavoriteByNameAndCountry(
          sharedPrefs.email!, even.countryName!);
      if (delete == 0) {
        yield DeleteFavoriteFailState();
      } else {
        yield DeleteFavoriteSuccessState(name: even.countryName!);
      }
    } catch (e) {
      yield DeleteFavoriteFailState();
    }
  }
}
