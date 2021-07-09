
import 'package:covid19_app/data/model/history.dart';
import 'package:covid19_app/data/model/world_response.dart';

import '../../data/model/country_response.dart';

abstract class CovidRepository {
  Future<List<Country>> getListCountry();
  Future<World> getWorld();
  Future<History> getHistory();
  Future<Country> getaCountry(String countryName);
}