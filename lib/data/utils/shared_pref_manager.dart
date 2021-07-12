import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;
  String keyEmail = "email";
///tao[_sharedPrefs] neu chua khoi tao
  init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }
  //xoa key email
  removeValues () async {
    _sharedPrefs!.remove(keyEmail);
  }
  //nhan vao mot string tao key email va set gia tri
  addStringToSF(String email) async {
    _sharedPrefs!.setString(keyEmail, email);
  }
  //lay gia tri key email
  String? get email => _sharedPrefs!.getString(keyEmail);
  //check key email
  bool? get check => _sharedPrefs!.containsKey(keyEmail);
}

final sharedPrefs = SharedPrefs();