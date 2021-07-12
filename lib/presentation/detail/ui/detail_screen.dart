import 'package:covid19_app/config/app_color.dart';
import 'package:covid19_app/data/model/country_response.dart';
import 'package:covid19_app/presentation/common/dialog.dart';
import 'package:covid19_app/presentation/common/enum.dart';
import 'package:covid19_app/presentation/common/error_form.dart';
import 'package:covid19_app/presentation/common/toast.dart';
import 'package:covid19_app/presentation/detail/bloc/detail_bloc.dart';
import 'package:covid19_app/presentation/home/ui/chart/pie/pie_chart.dart';
import 'package:covid19_app/presentation/home/ui/item/header.dart';
import 'package:covid19_app/presentation/home/ui/statisicalpackage/statistical.dart';
import 'package:covid19_app/presentation/login/ui/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.country}) : super(key: key);
  final Country country;
  @override
  _DetailScreen createState() => _DetailScreen();
}

class _DetailScreen extends State<DetailScreen> with TickerProviderStateMixin {
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
      create: (BuildContext context) => DetailBloc(),
      child:
          BlocConsumer<DetailBloc, DetailState>(listener: (pre, state) async {
        if (state is AddFavoriteSuccessStateFromDetail) {
          // FToast fToast2 = FToast();
          showToast(
              "Đã thêm " + state.name.toString(),
              _scaffoldKey.currentContext!,
              AppColor.mainColor,
              Icons.check,
              fToast);
        }
        if (state is AddFavoriteFailStateFromDetail) {
          switch (state.error) {
            case Error.isNotLogin:
              var dialog = await showDialogApp(
                  context, "Hủy", "Đăng nhập", "Bạn chưa đăng nhập");
              if (dialog == Selects.cancel) {
              } else if (dialog == Selects.accept) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              }

              break;
            case Error.exist:
              showToast(
                  "Đã theo dõi quốc gia này",
                  _scaffoldKey.currentContext!,
                  Colors.orange,
                  Icons.warning,
                  fToast);
              // fToast2.removeCustomToast();
              break;
          }
        }
      }, builder: (context, state) {
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
                        InkWell(
                          onTap: () {
                            fToast.removeQueuedCustomToasts();
                            context.read<DetailBloc>().add(
                                AddFavoriteEventFromDetail(
                                    country: widget.country));
                          },
                          child: const Icon(
                            Icons.add,
                            size: 30,
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
                        country: widget.country.country.toString(),
                        death: widget.country.deaths,
                        infected: widget.country.cases,
                        newRecovered: widget.country.todayRecovered,
                        newDeath: widget.country.todayDeaths,
                        recovered: widget.country.recovered,
                        newInfected: widget.country.todayCases,
                      ),
                      MyPieChart(
                        valueDeath: widget.country.deaths,
                        valueInfected:
                            widget.country.cases - widget.country.recovered,
                        valueRecovered: widget.country.recovered,
                      )
                    ],
                  ),
                ),
              ],
            )),
          ),
        );
      }),
    );
  }
}
