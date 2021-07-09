import 'package:covid19_app/data/utils/database.dart';

class FavoriteCountry{
  String? countryName;
  String? flag;
 String? userName;
  FavoriteCountry(
      {
       this.userName,
        this.countryName,
        this.flag,
      });
  Map<String,dynamic> toMap(){
    return {
      DatabaseCovid.userName: userName,
      DatabaseCovid.flag: flag,
      DatabaseCovid.countryFavoriteName:countryName,
    };
  }
}