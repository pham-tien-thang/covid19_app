import 'package:covid19_app/data/utils/shared_pref_manager.dart';
import 'package:covid19_app/presentation/common/dialog.dart';
import 'package:covid19_app/presentation/common/enum.dart';
import 'package:covid19_app/presentation/common/toast.dart';
import 'package:covid19_app/presentation/detail_favorite/ui/detail_favorite_screen.dart';
import 'package:covid19_app/presentation/favorite/bloc/favorite_bloc.dart';
import 'package:covid19_app/presentation/login/ui/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // scaffold.removeCurrentSnackBar();
    super.dispose();
    //_scaffoldKey.currentState!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return sharedPrefs.check! ? _isLogin() : _isNotLogin();
  }

  Widget _isLogin() {
    return BlocProvider(
        create: (BuildContext context) => FavoriteBloc()
          ..add(
            LoadFavoriteEvent(),
          ),
        child: Scaffold(
          key: _scaffoldKey,
          body: Column(children: [
            const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Danh sách theo dõi",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "coiny",
                      color: Colors.black,
                      fontSize: 20),
                )),
            BlocConsumer<FavoriteBloc, FavoriteState>(
                listener: (previous, state) {
              if (state is DeleteFavoriteSuccessState) {
                showSnackbar("Đã xóa ${state.name}", "ẩn", context);
              }
              if (state is DeleteFavoriteFailState) {
                showSnackbar("Xóa thất bại", "ẩn", context);
              }
            }, buildWhen: (previous, state) {
              if (state is DeleteFavoriteFailState ||
                  state is DeleteFavoriteSuccessState) {
                return false;
              }
              return true;
            }, builder: (context, state) {
              if (state is FavoriteLoadingSuccessState) {
                if (state.listCountry!.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        itemCount: state.listCountry!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailFavoriteScreen(
                                              country: state.listCountry!
                                                  .elementAt(index))));
                            },
                            child: Card(
                                child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                                                  .flag!),
                                            )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Center(
                                            child: Text(state.listCountry!
                                                .elementAt(index)
                                                .countryName!),
                                          ),
                                        )
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
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      ScaffoldMessenger.of(context)
                                          .removeCurrentSnackBar();
                                      final a = await showDialogApp(context,"Hủy","Đồng ý","Hủy theo dõi quốc gia này?");
                                      if (a == Selects.cancel) {
                                      } else if (a == Selects.accept) {
                                        context.read<FavoriteBloc>().add(
                                            DeleteFavoriteEvent(
                                                countryName: state.listCountry
                                                    ?.elementAt(index)
                                                    .countryName));
                                        context
                                            .read<FavoriteBloc>()
                                            .add(LoadFavoriteEvent());
                                      }
                                    },
                                  )),
                                ],
                              ),
                            )),
                          );
                        }),
                  );
                } else {
                  return const Expanded(
                      child: Center(
                          child: Text(
                    "Bạn chưa theo dõi quốc gia nào",
                    style: TextStyle(fontSize: 15),
                  )));
                }
              } else if (state is FavoriteLoadingFailState) {
                return const Center(
                  child: Text("Lỗi không xác định"),
                );
              } else if (state is FavoriteLoadingState) {
                return const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else {
                return Container();
              }
            }),
          ]),
        ));
  }

  Widget _isNotLogin() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Bạn chưa ",
            style: TextStyle(fontSize: 15),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: SizedBox(
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "đăng nhập",
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
