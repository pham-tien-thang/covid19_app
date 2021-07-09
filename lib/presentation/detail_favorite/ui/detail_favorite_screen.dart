import 'package:covid19_app/data/api/covid_api.dart';
import 'package:covid19_app/data/responsitories/covid_respository_impl.dart';
import 'package:covid19_app/domain/entities/favorite_entity.dart';
import 'package:covid19_app/domain/usescase/covid_usescase.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:covid19_app/presentation/detail_favorite/bloc/detail_favorite_bloc.dart';
import 'package:covid19_app/presentation/home/ui/chart/pie/pie_chart.dart';
import 'package:covid19_app/presentation/home/ui/item/header.dart';
import 'package:covid19_app/presentation/home/ui/statisicalpackage/statistical.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';

class DetailFavoriteScreen extends StatefulWidget {
  const DetailFavoriteScreen({Key? key, required this.country}) : super(key: key);
  final FavoriteCountry country;
  @override
  _DetailFavoriteScreen createState() => _DetailFavoriteScreen();
}

class _DetailFavoriteScreen extends State<DetailFavoriteScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FToast fToast = FToast();
  @override
  void dispose() {
    fToast.removeQueuedCustomToasts();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: _detailWidget()));
  }

  Widget _detailWidget() {
    return BlocProvider(
      create: (BuildContext context) => DetailFavoriteBloc(
          CovidUsescase(CovidRespositoryImpl(CovidApi(Dio()))))
        ..add(LoadDetailFavoriteEvent(api: widget.country.countryName)),
      child: BlocBuilder<DetailFavoriteBloc, DetailFavoriteState>(
          builder: (context, state) {
        if (state is LoadingDetailFavoriteState) {
          return const Center(
              child: SpinKitDoubleBounce(
            color: Colors.green,
          ));
        } else if (state is LoadDetailFavoriteSuccessState) {
          return Scaffold(
            key: _scaffoldKey,
            body: SingleChildScrollView(
              child: Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(alignment: const Alignment(-1, -1), children: [
                    const Header(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Statistical(
                          country: state.country!.country,
                          death: state.country!.deaths,
                          infected: state.country!.cases,
                          newRecovered: state.country!.todayRecovered,
                          newDeath: state.country!.todayDeaths,
                          recovered: state.country!.recovered,
                          newInfected: state.country!.todayCases,
                        ),
                        MyPieChart(
                          valueDeath: state.country!.deaths,
                          valueInfected:
                              state.country!.cases - state.country!.recovered,
                          valueRecovered: state.country!.recovered,
                        )
                      ],
                    ),
                  ),
                ],
              )),
            ),
          );
        } else if (state is LoadDetailFavoriteFailState) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const  Text("Kết nối thất bại"),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  context
                      .read<DetailFavoriteBloc>()
                      .add(LoadDetailFavoriteEvent(api: widget.country.countryName));
                },
                child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    width: 100,
                    height: 40,
                    color: Colors.blue,
                    child: const Text(
                      "Thử lại",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          ));
        } else {
          return Container();
        }
      }),
    );
  }
}
