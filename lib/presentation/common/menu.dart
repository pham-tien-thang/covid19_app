import 'package:covid19_app/data/utils/shared_pref_manager.dart';
import 'package:flutter/material.dart';

class Option {
  static const String logout = 'Đăng xuất';
  static const String login = 'Đăng nhập';
  static const String favorite = 'Theo dõi';
  static const String declare = 'Khai báo y tế ';
  static const String customise = 'Báo cáo dịch bệnh';
  static const List<String> isLogin = <String>[
    logout,
  ];
  static const List<String> phoneCall = <String>[
    declare,
    customise,
  ];
  static const List<String> isNotLogin = <String>[login];
}

List<PopupMenuItem> menu(BuildContext context) {
  return sharedPrefs.check!
      ? Option.isLogin.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList()
      : Option.isNotLogin.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
}

List<PopupMenuItem> menuCall(BuildContext context) {
  return Option.phoneCall.map((String choice) {
    return PopupMenuItem<String>(
      value: choice,
      child: Text(choice),
    );
  }).toList();
}
