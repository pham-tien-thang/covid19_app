import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;
///tao[_sharedPrefs] neu chua khoi tao
  init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }
  //xoa key email
  removeValues () async {
    _sharedPrefs!.remove("email");
  }
  //nhan vao mot string tao key email va set gia tri
  addStringToSF(String email) async {
    _sharedPrefs!.setString('email', email);
  }
  //lay gia tri key email
  String? get email => _sharedPrefs!.getString('email');
  //check key email
  bool? get check => _sharedPrefs!.containsKey('email');
}

final sharedPrefs = SharedPrefs();