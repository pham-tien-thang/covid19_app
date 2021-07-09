import 'package:covid19_app/config/app_color.dart';
import '../../../common/menu.dart';
import 'package:covid19_app/presentation/home/ui/item/cliper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);
  @override
  _Header createState() => _Header();
}

class _Header extends State<Header> {
  _showPopupMenu(Offset offset, BuildContext context) async {
    var left = offset.dx;
    var top = offset.dy;
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: menuCall(context),
      elevation: 8.0,
    );

    if (result == Option.declare) {
      launch("tel://18001119");
    } else if(result == Option.customise) {
      launch("tel://19009095");
    }
  }
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
          height: 220,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColor.mainColor, Colors.greenAccent]),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,10,0,0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: SvgPicture.asset(
                      "assets/image/Drcorona.svg",
                      alignment: Alignment.bottomCenter,
                    )),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,

                    children: [
                      const Text(
                        "Bạn cảm thấy không ổn ?",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "nếu bạn có các triệu chứng của covid hãy gọi ngay cho chúng tôi để được giúp đỡ",
                        style: TextStyle(
                            color: Colors.white, fontSize: 12.5),
                      ),
                      InkWell(
                        onTap: (){

                        },
                        onTapDown: (t){
                          _showPopupMenu(t.globalPosition, context);

                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 2,
                                offset: const Offset(1, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const[
                               Icon(
                                Icons.call,
                                color: AppColor.mainColor,
                                size: 10,
                              ),
                               SizedBox(width: 10,),
                               Text(
                                "Gọi ngay",
                                style: TextStyle(color: AppColor.mainColor,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

