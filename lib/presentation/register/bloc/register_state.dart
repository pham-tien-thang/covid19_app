part of 'register_bloc.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFail extends RegisterState {
  String? errMail;
  String? errPassWord;
  String? errRePassWord;
  String? error;
  RegisterFail(
      {this.errMail, this.errPassWord, this.errRePassWord, this.error});
}

class PassWordRegisterState extends RegisterState {
  bool? obcureText;
  PassWordRegisterState({this.obcureText});
}

class RePassWordRegisterState extends RegisterState {
  bool? obcureText;
  RePassWordRegisterState({this.obcureText});
}
