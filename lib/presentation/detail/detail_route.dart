
import 'package:covid19_app/data/model/country_response.dart';
import 'package:covid19_app/presentation/detail/bloc/detail_bloc.dart';
import 'package:covid19_app/presentation/detail/ui/detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailRoute {
  static Widget route(Country country) => BlocProvider(
    create: (BuildContext context) => DetailBloc(),
    child: DetailScreen(country: country,),
  );
}
