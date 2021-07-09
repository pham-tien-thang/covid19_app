import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid19_app/data/model/country_response.dart';
import 'package:covid19_app/data/utils/database.dart';
import 'package:covid19_app/data/utils/shared_pref_manager.dart';
import 'package:covid19_app/domain/entities/favorite_entity.dart';
import 'package:covid19_app/presentation/common/error_form.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(DetailInitial(),);
  DatabaseCovid databaseCovid = DatabaseCovid();

  /// nhan vao mot event [DetailEvent],
  /// neu event la [AddFavoriteEventFromDetail] thi se check trang thai dang nhap [sharedPrefs.check]
  /// neu [sharedPrefs.check] la true thi goi vao ham [_mapAddFavoriteToState]
  /// neu [sharedPrefs.check] la false thi tra ve[AddFavoriteFailStateFromDetail]
  @override
  Stream<DetailState> mapEventToState(
    DetailEvent event,
  ) async* {
    if (event is AddFavoriteEventFromDetail) {
      if (!sharedPrefs.check!) {
        yield AddFavoriteFailStateFromDetail(error: Error.isNotLogin);
      } else {
        yield* _mapAddFavoriteFromDetailToState(event);
      }
    }
  }

  ///Nhan vao event [AddFavoriteEventFromDetail]
  /// tra ve [AddFavoriteFailStatFromDetail] neu that bai kem theo trang thai
  ///tra ve [AddFavoriteSuccessStateFromDetail] neu thanh cong
  Stream<DetailState> _mapAddFavoriteFromDetailToState(
      AddFavoriteEventFromDetail addFavoriteEvent) async* {
    var userName = sharedPrefs.email;
    var countryName = addFavoriteEvent.country!.country.toString();
    var flag = addFavoriteEvent.country!.countryInfo.flag.toString();
    var favorite = [];
    favorite = await databaseCovid.getFavoriteByUsernameAndCountry(
        userName ?? "", countryName);
    var favoriteCountry = FavoriteCountry(
      userName: userName,
      countryName: countryName,
      flag: flag,
    );
    if (favorite.isEmpty) {
      try {
        //databaseCovid.deleteAll();
        databaseCovid.insertFavorite(favoriteCountry);
        yield AddFavoriteSuccessStateFromDetail(name: countryName);
      } catch (e) {
        yield AddFavoriteFailStateFromDetail(error: Error.unKnow);
      }
    } else {
      yield AddFavoriteFailStateFromDetail(error: Error.exist);
    }
  }
}
