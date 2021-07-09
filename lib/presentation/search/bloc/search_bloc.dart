import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid19_app/data/model/country_response.dart';
import 'package:covid19_app/data/utils/database.dart';
import 'package:covid19_app/data/utils/shared_pref_manager.dart';
import 'package:covid19_app/domain/entities/favorite_entity.dart';
import 'package:covid19_app/domain/usescase/covid_usescase.dart';
import 'package:covid19_app/presentation/common/error_form.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.covidUsecase) : super(SearchInitial());
  final CovidUsescase covidUsecase;
  List<Country> listRetrofit = [];
  List<Country> listS = [];
   DatabaseCovid databaseCovid = DatabaseCovid();

  /// nhan vao mot event [SearchEvent],
  /// neu event la [LoadSearchEvent] thi goi vao ham [_mapLoadSearchToState]
  /// neu event la [OnSearchEvent] thi goi vao ham [_mapOnSearchToState]
  /// neu event la [AddFavoriteEvent] thi se check trang thai dang nhap [sharedPrefs.check]
  /// neu [sharedPrefs.check] la true thi goi vao ham [_mapAddFavoriteToState]
  /// neu [sharedPrefs.check] la false thi tra ve[AddFavoriteFailState]
  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is LoadSearchEvent) {
      yield* _mapLoadSearchToState(event);
    } else if (event is OnSearchEvent) {
      yield* _mapOnSearchToState(event);
    } else if (event is AddFavoriteEvent) {
      if(!sharedPrefs.check!){
        yield AddFavoriteFailState(
            error: Error.isNotLogin,
        );
      }
      else{
        yield* _mapAddFavoriteToState(event);
      }

    }
  }
  ///Nhan vao event [LoadSearchEvent]
  /// dau tien se tra ve [SearchLoadingState]
  ///neu load thanh cong tra ve [SearchSuccessState] neu that bai tra ve [SearchFailState]
  Stream<SearchState> _mapLoadSearchToState(SearchEvent even) async* {
    yield SearchLoadingState();
    try {
      final reponse = await covidUsecase.getListCountry();
      listRetrofit = reponse;
      yield SearchSuccessState(listCountry: listRetrofit);
    } catch (e) {
      yield SearchFailState();
    }
  }
  ///Nhan vao event [OnSearch] sau do tra ve [SearchResult]
  Stream<SearchState> _mapOnSearchToState(OnSearchEvent event) async* {
    listS.clear();
    var query = event.query.toString();
    listS = listRetrofit
        .where((country) =>
    country.country.toLowerCase().contains(query.toLowerCase()) ||
        country.countryInfo.iso2
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
    yield SearchResult(listCountry: listS);
  }
  ///Nhan vao event [AddFavoriteEvent]
  /// tra ve [AddFavoriteFailState] neu that bai kem theo trang thai
  ///tra ve [AddFavoriteSuccessState] neu thanh cong
   Stream<SearchState> _mapAddFavoriteToState(AddFavoriteEvent addFavoriteEvent)async*{
    var userName =sharedPrefs.email;
    var countryName = addFavoriteEvent.country!.country.toString();
    var flag = addFavoriteEvent.country!.countryInfo.flag.toString();
    var favorite=[];
    favorite =  await databaseCovid.getFavoriteByUsernameAndCountry(userName??"", countryName);
    var favoriteCountry = FavoriteCountry(
      userName: userName,
      countryName: countryName,
      flag: flag,
    );
    if(favorite.isEmpty){
      try{
        //databaseCovid.deleteAll();
        databaseCovid.insertFavorite(favoriteCountry);
        yield AddFavoriteSuccessState(
            name: countryName
        );
      }
      catch(e){
        yield AddFavoriteFailState(
            error:Error.unKnow
        );
      }
    }else{

      yield AddFavoriteFailState(
          error:Error.exist
      );
    }
  }
}
