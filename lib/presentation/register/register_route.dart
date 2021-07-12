
import 'package:covid19_app/presentation/register/bloc/register_bloc.dart';
import 'package:covid19_app/presentation/register/ui/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterRoute {
  static Widget get route => BlocProvider(
        create: (BuildContext context) => RegisterBloc(),
        child: const RegisterScreen(),
      );


}
