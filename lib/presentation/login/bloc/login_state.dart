part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFail extends LoginState {
  String? errMail;
  String? errPassWord;
  String? error;
  LoginFail({this.errMail, this.errPassWord, this.error});
}

class PassWordLoginState extends LoginState {
  bool? obcureText;
  PassWordLoginState({this.obcureText});
}
