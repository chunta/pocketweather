import 'dart:async';
import 'package:pocket_weather/model/city_forecast.dart';
import 'package:pocket_weather/model/city_repository.dart';
import 'package:logger/logger.dart';

class CityViewModel {
  final logger = Logger();

  CityViewModel._();

  static final CityViewModel _instance = CityViewModel._();

  factory CityViewModel() {
    return _instance;
  }

  Stream<List<CityForecast>> getWorldCitiesStream() {
    return CityRepository().worldCitiesDataStream;
  }

  Future<void> fetchWorldFamousCities() async {
    await CityRepository().fetchWorldCities();
  }

  Stream<List<CityForecast>> getTaiwanCitiesStream() {
    return CityRepository().taiwanCitiesDataStream;
  }

  Future<void> fetchTaiwanCities() async {
    await CityRepository().fetchTaiwanCities();
  }

  Future<CityForecast> fetchForcastByName(String name) async {
    return CityRepository().fetchForcastByName(name);
  }

  Future<CityForecast> fetchForcastByLatLon(double lat, double lon) async {
    return CityRepository().fetchForcastByLatLon(lat, lon);
  }

  void dispose() {
    logger.d("call dispost of CityViewModel");
  }
}
