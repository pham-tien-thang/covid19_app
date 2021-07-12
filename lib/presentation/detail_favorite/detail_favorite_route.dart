import 'package:covid19_app/domain/entities/favorite_entity.dart';
import 'package:covid19_app/presentation/detail_favorite/bloc/detail_favorite_bloc.dart';
import 'package:covid19_app/presentation/detail_favorite/ui/detail_favorite_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_app/data/api/covid_api.dart';
import 'package:covid19_app/data/responsitories/covid_respository_impl.dart';
import 'package:covid19_app/domain/usescase/covid_usescase.dart';
import 'package:dio/dio.dart';

class DetailFavoriteRoute {
  static Widget route(FavoriteCountry country) => BlocProvider(
        create: (BuildContext context) => DetailFavoriteBloc(
          CovidUsescase(
            CovidRespositoryImpl(
              CovidApi(
                Dio(),
              ),
            ),
          ),
        )..add(
            LoadDetailFavoriteEvent(api: country.countryName),
          ),
        child: DetailFavoriteScreen(
          country: country,
        ),
      );
}
