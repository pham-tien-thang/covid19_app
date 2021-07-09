
import 'package:covid19_app/data/model/country_response.dart';
import 'package:covid19_app/data/model/history.dart';
import 'package:covid19_app/data/model/world_response.dart';
import 'package:covid19_app/domain/covid_reponsitories/covid_repositories.dart';

class CovidUsescase {
  final CovidRepository repository;
  CovidUsescase(this.repository);
  Future<List<Country>> getListCountry()=> repository.getListCountry();
  Future<World> getWorld()=> repository.getWorld();
  Future<History> getHistory()=> repository.getHistory();
  Future<Country> getaCountry(String countryName)=> repository.getaCountry(countryName);
}