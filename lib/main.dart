
import 'dart:io';

import 'package:covid19_app/data/utils/shared_pref_manager.dart';
import 'package:covid19_app/presentation/common/dialog.dart';
import 'package:covid19_app/presentation/common/enum.dart';
import 'package:covid19_app/utils/route/app_routing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:covid19_app/config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  sharedPrefs.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRouting.generateRoute,
      debugShowCheckedModeBanner: false,
      //initialRoute: RouteDefine.mainScreen.name,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _controller = PageController();
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        final a = await showDialogApp(context,"Hủy","Đồng ý","Thoát ứng dụng ?");
        if (a == Selects.cancel) {
          return false;
        } else if (a == Selects.accept) {
          exit(1);
        }
        return false;
      },
      child: Scaffold(
        body: Center(
          child:Container(
            color: Colors.white,
            child: Stack(
              children: [
                PageView(
                  controller: _controller,
                  children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,10,0,0),
                        child: Image.asset("assets/image/p1.png"),
                      ),
                      const Text("Phòng tránh Covid-19",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.mainColor,
                        fontSize: 20,
                        fontFamily: "coiny",
                      ),)
                    ],
                  ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,10,0,0),
                          child: Image.asset("assets/image/p2.png"),
                        ),
                        const Text("Rửa tay sát khuẩn",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor.mainColor,
                            fontSize: 20,
                            fontFamily: "coiny",
                          ),)
                      ],
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,10,0,0),
                            child: Image.asset("assets/image/p3.png"),
                          ),
                          const Text("Đeo khẩu trang",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColor.mainColor,
                              fontSize: 20,
                              fontFamily: "coiny",
                            ),),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style:ElevatedButton.styleFrom(
                                  side: const BorderSide(width: 2.0, color: Colors.white54,),
                                  onPrimary: Colors.grey,
                                  primary: AppColor.mainColor,
                                 // minimumSize: Size(mediaQuery.o.width/1.5, 50),
                                  padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(40)),
                                  )),
                              onPressed: () {
                                Navigator.pushNamed(context, RouteDefine.homeScreen.name);
                              },
                              child: const Text("Tiếp tục ",style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: SmoothPageIndicator(
                          controller: _controller,
                          count: 3,
                          effect: const WormEffect(),
                          onDotClicked: (index) =>
                              _controller.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.bounceOut,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
       // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

}
class MainRoute {
  static Widget get route => const MyApp();
}
