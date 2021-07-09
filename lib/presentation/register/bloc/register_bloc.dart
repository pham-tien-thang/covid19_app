import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid19_app/presentation/common/error_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial());

  ///nhan vao mot [RegisterEvent], dau tien se tra ve [RegisterLoading],
  ///sau do neu  [RegisterEvent.email] rong hoac  [RegisterEvent.password] rong,
  /// hoac [RegisterEvent.repassword] khac [RegisterEvent.password], thi tra ve [RegisterFail]
  /// neu khong thi goi vao ham [_mapRegisterPressToState]
  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterPress) {
      yield RegisterLoading();
      if (event.email!.isEmpty) {
        yield RegisterFail(
          errMail: "Nhập email",
          errPassWord: "",
          errRePassWord: "",
        );
      } else if (event.password!.isEmpty) {
        yield RegisterFail(
          errMail: "",
          errPassWord: "Nhập mật khẩu",
          errRePassWord: "",
        );
      } else if (event.repassword!.isEmpty ||
          event.repassword != event.password) {
        yield RegisterFail(
          errMail: "",
          errPassWord: "",
          errRePassWord: "Nhập lại mật khẩu",
        );
      } else {
        yield* _mapRegisterPressToState(event);
      }
    } else if (event is ObscureTextPassWord) {
      bool? value = !event.obcureText!;
      yield PassWordRegisterState(obcureText: value);
    } else if (event is ObscureTextRePassWord) {
      bool? value = !event.obcureText!;
      yield RePassWordRegisterState(obcureText: value);
    }
  }

  ///nhan vao mot event [RegisterPress] ,
  /// neu dang ky thanh cong se tra ve [RegisterSuccess]
  /// neu khong se tra ve [RegisterFail]
  Stream<RegisterState> _mapRegisterPressToState(RegisterPress event) async* {
    try {
      var userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: event.email!, password: event.password!);
      "User data : ${userCredential.user!.displayName}   ${userCredential.user!.email}  ${userCredential.user.toString()}";
      yield RegisterSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == Error.invalidEmail) {
        yield RegisterFail(
          errMail: "Sai định dạng mail",
          errPassWord: "",
          errRePassWord: "",
          error: Error.invalidEmail,
        );
      } else if (e.code == Error.weakPassword) {
        yield RegisterFail(
          errMail: "",
          errPassWord: "Mật khẩu quá yếu",
          errRePassWord: "",
          error: Error.weakPassword,
        );
      } else if (e.code == Error.emailAlreadyInUse) {
        yield RegisterFail(
          errMail: "Email đã được sử dụng",
          errPassWord: "",
          errRePassWord: "",
          error: Error.emailAlreadyInUse,
        );
      } else if (e.code == Error.networkRequestFailed) {
        yield RegisterFail(
          errMail: "",
          errPassWord: "",
          errRePassWord: "",
          error: Error.networkRequestFailed,
        );
      } else {
        yield RegisterFail(
          errMail: "",
          errPassWord: "",
          errRePassWord: "",
          error: Error.unKnow,
        );
      }
    }
  }
}
