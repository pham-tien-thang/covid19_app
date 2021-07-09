part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginPress extends LoginEvent {
  final String? email;
  final String? password;
  LoginPress({this.email, this.password});
}

class ObscureText extends LoginEvent {
  bool? obcureText;
  ObscureText({this.obcureText});
}
