import 'dart:async';
import 'package:pocket_weather/model/city_forecast.dart';
import 'package:pocket_weather/model/city_repository.dart';

class CityViewModel {
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

  void dispose() {
    // ignore: avoid_print
    print("call dispost of CityViewModel");
  }
}
