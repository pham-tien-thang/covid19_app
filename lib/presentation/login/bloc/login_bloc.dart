import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid19_app/data/utils/shared_pref_manager.dart';
import 'package:covid19_app/presentation/common/error_form.dart';

import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc()
      : super(
          LoginInitial(),
        );

  /// neu event la [LoginPress]
  ///neu [LoginEvent.email] hoac [LoginEvent.password] rong thi tra ve [LoginFail]
  ///neu khong thi gọi vao ham [_mapLoginPress]
  /// neu event la [ObscureText] tra ve [PassWordLoginState]
  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginPress) {
      yield LoginLoading();
      if (event.email!.isEmpty) {
        yield LoginFail(
          errMail: "Nhập email",
          errPassWord: "",
        );
      } else if (event.password!.isEmpty) {
        yield LoginFail(
          errMail: "",
          errPassWord: "Nhập mật khẩu",
        );
      } else {
        yield* _mapLoginPress(event);
      }
    } else if (event is ObscureText) {
      bool? value = !event.obcureText!;
      yield PassWordLoginState(obcureText: value);
    }
  }

  ///nhan vao mot event [LoginPress] sau do
  ///tra ve[LoginSuccess] neu thanh cong
  ///tra ve[LoginFail] kem theo 1 trang thai [Error] neu that bai
  Stream<LoginState> _mapLoginPress(LoginPress event) async* {
    try {
      var userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: event.email!, password: event.password!);
      "User data : ${userCredential.user!.displayName}   ${userCredential.user!.email}  ${userCredential.user.toString()}";
      sharedPrefs.addStringToSF(userCredential.user!.email.toString());
      yield LoginSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == Error.userNotFound) {
        yield LoginFail(
          errMail: "Email không tồn tại",
          errPassWord: "",
          error: Error.userNotFound,
        );
      } else if (e.code == Error.wrongPassword) {
        yield LoginFail(
          errMail: "",
          errPassWord: "Sai mật khẩu",
          error: Error.wrongPassword,
        );
      } else if (e.code == Error.invalidEmail) {
        yield LoginFail(
          errMail: "Sai định dạng mail",
          errPassWord: "",
          error: Error.invalidEmail,
        );
      } else if (e.code == Error.networkRequestFailed) {
        yield LoginFail(
          errMail: "",
          errPassWord: "",
          error: Error.networkRequestFailed,
        );
      } else {
        yield LoginFail(
          errMail: "",
          errPassWord: "",
          error: Error.unKnow,
        );
      }
    }
  }
}
