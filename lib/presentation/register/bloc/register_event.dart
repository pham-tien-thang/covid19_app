part of 'register_bloc.dart';

abstract class RegisterEvent {}

class RegisterPress extends RegisterEvent {
  final String? email;
  final String? password;
  final String? repassword;
  RegisterPress({this.email, this.password, this.repassword});
}

class ObscureTextPassWord extends RegisterEvent {
  bool? obcureText;
  ObscureTextPassWord({this.obcureText});
}

class ObscureTextRePassWord extends RegisterEvent {
  bool? obcureText;
  ObscureTextRePassWord({this.obcureText});
}
