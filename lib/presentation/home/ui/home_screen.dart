import 'dart:io';

import 'package:covid19_app/data/utils/shared_pref_manager.dart';
import 'package:covid19_app/presentation/common/array.dart';
import 'package:covid19_app/presentation/common/enum.dart';
import 'package:covid19_app/presentation/favorite/ui/favorite_screen.dart';
import 'package:covid19_app/presentation/home/ui/chart/line/line_chart.dart';
import 'package:covid19_app/utils/route/app_routing.dart';
import '../../common/menu.dart';
import 'package:covid19_app/presentation/common/dialog.dart';
import 'package:covid19_app/presentation/home/bloc/home_bloc.dart';
import 'package:covid19_app/presentation/home/ui/chart/pie/pie_chart.dart';
import 'package:covid19_app/presentation/home/ui/item/header.dart';
import 'package:covid19_app/presentation/search/ui/seach_screen.dart';
import 'statisicalpackage/statistical.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  String infected = "0";
  String death = "0";
  String recovered = "0";
  bool? status = true;
  late Animation<double> animationInfected, animationDeath, animationRecovered;
  late AnimationController _controller;

  ///khi item cua bottomNavigation duoc chon thi [_selectedIndex] bang index tuong ung cua item
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //chay khi man hinh bat dau khoi tao
  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    super.initState();
  }

  //chay khi state bi xoa
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  ///khi nguoi dung bam back,
  /// neu [_selectedIndex] = 0 (nguoi dung dang o trang home) thi show [showDialogFunction]
  /// neu [_selectedIndex] khac 0 thi gan [_selectedIndex] = 0 (nguoi dung quay ve trang home)
  Future<bool> shouldPop() async {
    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0;
      });
      return false;
    } else {
      final a =
          await showDialogApp(context, "Hủy", "Đồng ý", "Thoát ứng dụng ?");
      if (a == Selects.cancel) {
        return false;
      } else if (a == Selects.accept) {
        exit(1);
      }
      return false;
    }
  }

  //show menu lua chon cho nguoi dung
  _showPopupMenu(Offset offset, BuildContext context) async {
    var left = offset.dx;
    var top = offset.dy;
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: menu(context),
      elevation: 8.0,
    );
    if (result == Option.login) {
      Navigator.pushNamed(context, RouteDefine.loginScreen.name);
    } else if (result == Option.favorite) {
    } else if (result == Option.logout) {
      try {
        await FirebaseAuth.instance.signOut();
        sharedPrefs.removeValues();
        Navigator.pushNamed(context, RouteDefine.loginScreen.name);
      } catch (e) {
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return shouldPop();
      },
      child: SafeArea(
          child: Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: 'Trang chủ',
                    backgroundColor: Colors.white,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Tìm kiếm',
                    backgroundColor: Colors.white,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Theo dõi',
                    backgroundColor: Colors.white,
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.amber[800],
                unselectedItemColor: Colors.black,
                onTap: _onItemTapped,
              ),
              body: _allWidget(_selectedIndex))),
    );
  }

  Widget _allWidget(int i) {
    switch (i) {
      case 0:
        return _widgetHome();
      case 1:
        return const SearchScreen();
      case 2:
        return const FavoriteScreen();
      default:
        return const Text("lỗi");
    }
  }

  Widget _widgetHome() {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, state) {
        return state is ChartState ? false : true;
      },
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const Center(
              child: SpinKitDoubleBounce(
            color: Colors.green,
          ));
        } else if (state is HomeSuccessState) {
          animationInfected =
              Tween<double>(begin: 0, end: state.world!.cases * 1)
                  .animate(_controller)
                    ..addListener(() {
                      // print(animationInfected.value.toStringAsFixed(0));
                      setState(() {
                        infected = animationInfected.value.toStringAsFixed(0);
                      });
                    });
          animationDeath =
              Tween<double>(begin: 0, end: state.world!.deaths * 1)
                  .animate(_controller)
                    ..addListener(() {
                      //print(animationDeath.value.toStringAsFixed(0));
                      setState(() {
                        death = animationDeath.value.toStringAsFixed(0);
                      });
                    });
          animationRecovered = Tween<double>(
                  begin: 0, end: state.world!.recovered * 1)
              .animate(_controller)
                ..addListener(() {
                  // print(animationRecovered.value.toStringAsFixed(0));
                  setState(() {
                    recovered = animationRecovered.value.toStringAsFixed(0);
                  });
                });
          _controller.forward();
          return SingleChildScrollView(
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(alignment: const Alignment(1, -1), children: [
                   const Header(),
                  GestureDetector(
                    onTapDown: (TapDownDetails details) {
                      _showPopupMenu(details.globalPosition, context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_drop_down_circle_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Statistical(
                        country: "thế giới",
                        death: int.parse(death),
                        infected: int.parse(infected),
                        newRecovered: state.world!.todayRecovered,
                        newDeath: state.world!.todayDeaths,
                        recovered: int.parse(recovered),
                        newInfected: state.world!.todayCases,
                      ),
                      BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                        if (state is HomeSuccessState) {
                          return Stack(
                            alignment: const Alignment(1, -1),
                            children: [
                              // IconButton(
                              //   onPressed: () {
                              //     context
                              //         .read<HomeBloc>()
                              //         .add(ChangeChartEvent(true));
                              //   },
                              //   icon: const Icon(Icons.replay_circle_filled),
                              // ),
                              MyPieChart(
                                valueDeath: state.world!.deaths,
                                valueInfected: state.world!.cases -
                                    (state.world!.recovered +
                                        state.world!.deaths),
                                valueRecovered: state.world!.recovered,
                              ),
                            ],
                          );
                        } else if (state is ChartState) {
                          return Stack(
                            alignment: const Alignment(1, -1),
                            children: [
                              // IconButton(
                              //   onPressed: () {
                              //     context
                              //         .read<HomeBloc>()
                              //         .add(ChangeChartEvent(false));
                              //   },
                              //   icon: const Icon(Icons.replay_circle_filled),
                              // ),
                              MyLineChart(
                                leftTittle: leftTitleWord,
                                maxY: 1000000 / 1.25,
                                step: 250000 / 1.25,
                                spotCases: state.spotCases!,
                                spotDeaths: state.spotDeaths!,
                                spotRevovered: state.spotRecovered!,
                                bottomTittle: state.date!,
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      }),
                    ],
                  ),
                ),
              ],
            )),
          );
        } else if (state is HomeFailState) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Kết nối thất bại"),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  context.read<HomeBloc>().add(LoadingHomeEvent());
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
      },
    );
  }
}
