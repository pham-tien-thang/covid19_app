
import 'package:covid19_app/presentation/login/bloc/login_bloc.dart';
import 'package:covid19_app/presentation/login/ui/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginRoute {
  static Widget get route => BlocProvider(
        create: (BuildContext context) => LoginBloc(),
        child: const LoginScreen(),
      );
}
