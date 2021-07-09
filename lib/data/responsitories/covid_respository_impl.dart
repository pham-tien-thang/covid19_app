import 'package:covid19_app/data/api/covid_api.dart';
import 'package:covid19_app/data/model/country_response.dart';
import 'package:covid19_app/data/model/history.dart';
import 'package:covid19_app/data/model/world_response.dart';
import 'package:covid19_app/domain/covid_reponsitories/covid_repositories.dart';

class CovidRespositoryImpl extends CovidRepository{
  CovidApi covidApi;
  CovidRespositoryImpl(this.covidApi);
  @override
  Future<List<Country>> getListCountry() async {
    final response = await covidApi.getListCountry();
    return response;
  }
  @override
  Future<World> getWorld()async {
    final response = await covidApi.getCovidWorld();
    return response;
  }
  @override
  Future<Country> getaCountry(String countryName)async {
    final response = await covidApi.getCountry(countryName);
    return response;
  }
  @override
  Future<History> getHistory() async {
    final response = await covidApi.getHistory();
    return response;
  }

}