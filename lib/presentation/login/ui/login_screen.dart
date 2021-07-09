import 'package:covid19_app/config/app_color.dart';
import 'package:covid19_app/presentation/common/error_form.dart';
import 'package:covid19_app/presentation/common/toast.dart';
import 'package:covid19_app/presentation/login/bloc/login_bloc.dart';
import 'package:covid19_app/presentation/register/ui/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _passWord = TextEditingController();
  final bool _obscuretext = true;
  FToast fToast = FToast();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context).size;
    var availableHeight =
        _mediaQuery.height - MediaQuery.of(context).padding.top;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(
            FocusNode(),
          );
        },
        child: Scaffold(
          body: Center(
            child: BlocProvider(
                create: (BuildContext context) => LoginBloc(),
                child: BlocConsumer<LoginBloc, LoginState>(
                    listener: (previous, state) {
                  if (state is LoginSuccess) {
                    showToast("Đăng nhập thành công", context,
                        AppColor.mainColor, Icons.check, fToast);
                    Navigator.of(context).pop();
                  }
                  if (state is LoginFail) {
                    if (state.error == Error.networkRequestFailed) {
                      showToast("Kiểm tra kết nối internet !", context,
                          Colors.grey, Icons.warning, fToast);
                    }
                    if (state.error == Error.unKnow) {
                      showToast("Lỗi không xác định !", context, Colors.grey,
                          Icons.warning, fToast);
                    }
                  }
                }, builder: (context, state) {
                  return Container(
                    color: Colors.white,
                    width: _mediaQuery.width,
                    height: availableHeight,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Image.asset("assets/image/header.png"),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Text(
                              "ĐĂNG NHẬP",
                              style: TextStyle(
                                  fontFamily: "coiny",
                                  color: AppColor.mainColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Center(
                              child: Text(
                                "Đăng nhập để theo dõi thông tin dịch bệnh",
                                style: TextStyle(
                                    fontFamily: "coiny", fontSize: 12.5),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _name,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  errorText: state is LoginFail
                                      ? (state.errMail!.isEmpty
                                          ? null
                                          : state.errMail)
                                      : null,
                                  suffixIcon: const Icon(
                                    Icons.mail,
                                    color: AppColor.mainColor,
                                  ),
                                  fillColor: Colors.grey,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 1.0)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1.0)),
                                  hintText: 'Email của bạn',
                                  hintStyle:
                                      const TextStyle(color: Colors.grey)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: TextField(
                              controller: _passWord,
                              obscureText: state is PassWordLoginState
                                  ? state.obcureText!
                                  : _obscuretext,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  errorText: state is LoginFail
                                      ? (state.errPassWord!.isEmpty
                                          ? null
                                          : state.errPassWord)
                                      : null,
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      var eventObs = state is PassWordLoginState
                                          ? state.obcureText!
                                          : _obscuretext;
                                      context.read<LoginBloc>().add(
                                          ObscureText(obcureText: eventObs));
                                    },
                                    child: Icon(
                                      state is PassWordLoginState
                                          ? (state.obcureText!
                                              ? Icons.lock
                                              : Icons.lock_open)
                                          : Icons.lock,
                                      color: AppColor.mainColor,
                                    ),
                                  ),
                                  fillColor: Colors.grey,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 1.0)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1.0)),
                                  hintText: 'Mật khẩu',
                                  hintStyle:
                                      const TextStyle(color: Colors.grey)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Chưa có tài khoản?",
                                  style: TextStyle(
                                      fontSize: 12.5, color: Colors.grey),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterScreen()));
                                  },
                                  child: const Text(
                                    " Đăng ký ngay",
                                    style: TextStyle(
                                        fontSize: 12.5,
                                        color: AppColor.mainColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                          if (state is! LoginLoading) ...[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    side: const BorderSide(
                                      width: 2.0,
                                      color: Colors.white54,
                                    ),
                                    onPrimary: Colors.grey,
                                    primary: Colors.black,
                                    // minimumSize: Size(mediaQuery.o.width/1.5, 50),
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 20, 40, 20),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(40)),
                                    )),
                                onPressed: () {
                                  context.read<LoginBloc>().add(LoginPress(
                                        email: _name.text,
                                        password: _passWord.text,
                                      ));
                                },
                                child: const Text(
                                  "Đăng nhập ",
                                  style: TextStyle(color: AppColor.mainColor),
                                ),
                              ),
                            ),
                          ],
                          if (state is LoginLoading) ...[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      side: const BorderSide(
                                        width: 2.0,
                                        color: Colors.white54,
                                      ),
                                      onPrimary: Colors.grey,
                                      primary: Colors.grey,
                                      // minimumSize: Size(mediaQuery.o.width/1.5, 50),
                                      padding: const EdgeInsets.fromLTRB(
                                          40, 20, 40, 20),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40)),
                                      )),
                                  onPressed: () {},
                                  child: SizedBox(
                                    width: _mediaQuery.width / 5,
                                    child: const SpinKitFadingCircle(
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  )),
                            ),
                          ]
                        ],
                      ),
                    ),
                  );
                })),
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }
}
