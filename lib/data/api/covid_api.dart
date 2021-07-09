import 'package:covid19_app/data/model/country_response.dart';
import 'package:covid19_app/data/model/history.dart';
import 'package:covid19_app/data/model/world_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'covid_api.g.dart';

@RestApi(baseUrl: "https://disease.sh/v3/covid-19")
abstract class CovidApi {
  factory CovidApi(Dio dio) = _CovidApi;
  @GET("/all")
  Future<World> getCovidWorld();
  @GET("/historical/all")
  Future<History> getHistory();
  @GET("/countries")
  Future<List<Country>> getListCountry();
  @GET("/countries/{country}")
  Future<Country> getCountry(@Path("country") String countryName);
}
