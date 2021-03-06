import 'package:covid19_app/config/app_color.dart';
import 'package:covid19_app/presentation/common/enum.dart';
import 'package:covid19_app/presentation/common/error_form.dart';
import 'package:covid19_app/utils/route/app_routing.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:covid19_app/presentation/common/dialog.dart';
import 'package:covid19_app/presentation/common/toast.dart';
import 'package:covid19_app/data/api/covid_api.dart';
import 'package:covid19_app/data/responsitories/covid_respository_impl.dart';
import 'package:covid19_app/domain/usescase/covid_usescase.dart';
import 'package:dio/dio.dart';
import 'package:covid19_app/presentation/search/bloc/search_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  _SearchScreen createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  final TextEditingController _searchControler = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FToast fToast = FToast();
  @override
  void dispose() {
    fToast.removeQueuedCustomToasts();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Center(
          child: BlocProvider(
            create: (BuildContext context) => SearchBloc(CovidUsescase(
              CovidRespositoryImpl(
                CovidApi(
                  Dio(),
                ),
              ),
            ))
              ..add(
                LoadSearchEvent(),
              ),
            child: BlocConsumer<SearchBloc, SearchState>(
              listener: (pre, state) async {
                if (state is AddFavoriteSuccessState) {
                  // FToast fToast2 = FToast();
                  showToast(
                      "???? th??m " + state.name.toString(),
                      _scaffoldKey.currentContext!,
                      AppColor.mainColor,
                      Icons.check,
                      fToast);
                }
                if (state is AddFavoriteFailState) {
                  switch (state.error) {
                    case Error.isNotLogin:
                      {
                        var dialog = await showDialogApp(
                            context, "H???y", "????ng nh???p", "B???n ch??a ????ng nh???p");
                        if (dialog == Selects.cancel) {
                        } else if (dialog == Selects.accept) {
                          Navigator.pushNamed(
                              context, RouteDefine.loginScreen.name);
                        }
                      }
                      break;
                    case Error.exist:
                      showToast(
                          "???? theo d??i qu???c gia n??y",
                          _scaffoldKey.currentContext!,
                          Colors.orange,
                          Icons.warning,
                          fToast);
                      // fToast2.removeCustomToast();
                      break;
                  }
                }
              },
              buildWhen: (previous, state) {
                if (state is AddFavoriteFailState ||
                    state is AddFavoriteSuccessState) {
                  return false;
                }
                return true;
              },
              builder: (context, state) {
                if (state is SearchSuccessState || state is SearchResult) {
                  return GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (s) {
                              context
                                  .read<SearchBloc>()
                                  .add(OnSearchEvent(query: s));
                            },
                            controller: _searchControler,
                            decoration: InputDecoration(
                              hintText: 'T??m ki???m qu???c gia',
                              contentPadding: const EdgeInsets.fromLTRB(
                                  20.0, 15.0, 20.0, 15.0),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1.0)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),
                        if (state is SearchSuccessState) ...[
                          Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(8),
                                itemCount: state.listCountry!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      fToast.removeQueuedCustomToasts();
                                      Navigator.pushNamed(
                                        context,
                                        RouteDefine.detailScreen.name,
                                        arguments:
                                            state.listCountry!.elementAt(index),
                                      );
                                    },
                                    child: Card(
                                        child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                        color: Colors.black,
                                                        width: 1,
                                                      )),
                                                      child: Image.network(state
                                                          .listCountry!
                                                          .elementAt(index)
                                                          .countryInfo
                                                          .flag
                                                          .toString()),
                                                    )),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                    flex: 5,
                                                    child: Text(
                                                      state.listCountry!
                                                          .elementAt(index)
                                                          .country
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          const Expanded(
                                            flex: 2,
                                            child: SizedBox(),
                                          ),
                                          Expanded(
                                              child: IconButton(
                                            icon: const Icon(
                                              Icons.add,
                                              color: Colors.green,
                                            ),
                                            onPressed: () {
                                              FocusScope.of(context)
                                                  .requestFocus(FocusNode());
                                              fToast.removeQueuedCustomToasts();
                                              context.read<SearchBloc>().add(
                                                  AddFavoriteEvent(
                                                      country: state
                                                          .listCountry!
                                                          .elementAt(index)));
                                            },
                                          )),
                                        ],
                                      ),
                                    )),
                                  );
                                }),
                          )
                        ],
                        if (state is SearchResult) ...[
                          Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(8),
                                itemCount: state.listCountry!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        RouteDefine.detailScreen.name,
                                        arguments:
                                        state.listCountry!.elementAt(index),
                                      );
                                    },
                                    child: Card(
                                        child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                        color: Colors.black,
                                                        width: 1,
                                                      )),
                                                      child: Image.network(state
                                                          .listCountry!
                                                          .elementAt(index)
                                                          .countryInfo
                                                          .flag
                                                          .toString()),
                                                    )),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                    flex: 5,
                                                    child: Text(
                                                      state.listCountry!
                                                          .elementAt(index)
                                                          .country
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          const Expanded(
                                            flex: 2,
                                            child: SizedBox(),
                                          ),
                                          Expanded(
                                              child: IconButton(
                                            icon: const Icon(
                                              Icons.add,
                                              color: Colors.green,
                                            ),
                                            onPressed: () {
                                              FocusScope.of(context)
                                                  .requestFocus(FocusNode());
                                              fToast.removeQueuedCustomToasts();
                                              context.read<SearchBloc>().add(
                                                  AddFavoriteEvent(
                                                      country: state
                                                          .listCountry!
                                                          .elementAt(index)));
                                            },
                                          )),
                                        ],
                                      ),
                                    )),
                                  );
                                }),
                          )
                        ],
                      ],
                    ),
                  );
                } else if (state is SearchLoadingState) {
                  return const Center(
                      child: SpinKitDoubleBounce(
                    color: Colors.green,
                  ));
                } else if (state is SearchFailState) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("K???t n???i th???t b???i"),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          context.read<SearchBloc>().add(LoadSearchEvent());
                        },
                        child: Container(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            width: 100,
                            height: 40,
                            color: Colors.blue,
                            child: const Text(
                              "Th??? l???i",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ));
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
