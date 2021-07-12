import 'package:covid19_app/presentation/home/ui/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:covid19_app/data/api/covid_api.dart';
import 'package:covid19_app/data/responsitories/covid_respository_impl.dart';
import 'package:covid19_app/domain/usescase/covid_usescase.dart';
import 'package:dio/dio.dart';
import 'package:covid19_app/presentation/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeRoute {
  static Widget get route => BlocProvider(
        create: (BuildContext context) => HomeBloc(
          CovidUsescase(
            CovidRespositoryImpl(
              CovidApi(
                Dio(),
              ),
            ),
          ),
        )..add(LoadingHomeEvent()),
        child: const HomeScreen(),
      );
}
